import 'dart:convert';
import 'dart:io';

import 'package:ansicolor/ansicolor.dart';
import 'package:base/base.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:ginkgo_mobile/src/blocs/auth/auth_bloc.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:ginkgo_mobile/src/widgets/errorWidgets/showErrorMessage.dart';
import 'package:object_mapper/object_mapper.dart';

class ApiClient {
  Map<String, String> _headers;
  Dio _client;

  ApiClient() {
    _client = Dio();
  }

  addHeader(Map<String, String> headers) {
    _headers.addAll(headers);
    return this;
  }

  Future<T> connect<T extends Mappable>(
    ApiMethod method,
    String url, {
    Map<String, String> headers,
    Map<String, String> query,
    Map<String, dynamic> body,
    FormData data,
    bool hasCaching = true,
  }) async {
    final response = await normalConnect(method, url,
        body: body,
        data: data,
        hasCaching: hasCaching,
        headers: headers,
        query: query);

    return Mapper.fromJson((response.data is String
            ? jsonDecode(response.data)
            : response.data)['Data'][0])
        .toObject<T>();
  }

  Future<Response> normalConnect(
    ApiMethod method,
    String url, {
    Map<String, String> headers,
    Map<String, String> query,
    Map<String, dynamic> body,
    FormData data,
    bool handleError = true,
    bool hasCaching = true,
  }) async {
    Map<String, String> _headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await Repository().auth.token}'
    };

    if (headers != null) {
      _headers.addAll(headers);
    }

    final options = Options(
      headers: _headers,
    );

    (_client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
    };

    Response response;

    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none) {
      // Read from cache when no internet connection
      if (method == ApiMethod.GET) {
        try {
          dynamic cacheData = jsonDecode(
              await CacheProvider().readCache(url + query.toString()));
          response = Response();
          response.statusCode = 200;
          response.data = cacheData;
        } catch (e) {
          print('Failed to parse cache: $e');
          throw 'No connection';
        }
      } else {
        throw 'No connection';
      }
    } else {
      try {
        switch (method) {
          case ApiMethod.GET:
            response = await _client.get(url,
                queryParameters: query, options: options);
            break;
          case ApiMethod.POST:
            response = await _client.post(url,
                queryParameters: query, options: options, data: data ?? body);
            break;
          case ApiMethod.PUT:
            response = await _client.put(url,
                queryParameters: query, options: options, data: data ?? body);
            break;
          case ApiMethod.DELETE:
            response = await _client.delete(url,
                queryParameters: query, options: options, data: data ?? body);
            break;
          default:
            response = await _client.get(url,
                queryParameters: query, options: options);
            break;
        }
      } on DioError catch (e) {
        if (e.response?.statusCode == 401) {
          showErrorMessage(
              'Phiên đăng nhập hết hạn. \nVui lòng đăng nhập lại.');
          AuthBloc().add(AuthEventLogout());
        }
        throw e.message;
      } finally {
        AnsiPen pen = new AnsiPen()..blue(bold: true);
        print(pen(enumToString(method) + ': $url'));
        pen = new AnsiPen()..yellow();
        if (query != null) {
          print(pen('Query: $query'));
        }
        if (headers != null) {
          print(pen('Headers: $headers'));
        }
        if (data != null || body != null) {
          print(pen('Data: ${data ?? jsonEncode(body)}'));
        }
        if (response?.data is Map && response.data['Data'] is List) {
          print(pen('Response: ${response.data['Data']}'));
        }
      }

      Map<String, dynamic> decoded =
          response.data is String ? jsonDecode(response.data) : response.data;

      // Cache api
      bool isSuccess = decoded != null &&
          decoded is! List &&
          (decoded['Data'] == null ||
              decoded['Data'] != null && decoded['Data'] is List) &&
          int.tryParse(decoded['ErrorCode'].toString()) == 0;

      if (response.statusCode != 200 && response.statusCode != 201 ||
          !isSuccess) {
        if (handleError) {
          throw ServerError(
            errorCode: decoded['ErrorCode'],
            message: decoded['Message'],
          );
        }
      } else {
        if (method == ApiMethod.GET) {
          CacheProvider().cache(
            url + query.toString(),
            jsonEncode(response.data),
          );
        }
      }
      // END cache api
    }

    // _client.close();

    return response;
  }
}

enum ApiMethod { GET, POST, PUT, DELETE }
