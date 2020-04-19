part of base;

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

  Future<Response> authConnect(
    ApiMethod method,
    String url, {
    Map<String, String> headers,
    Map<String, String> query,
    Map<String, dynamic> body,
    bool handleError = true,
    bool hasCaching = true,
  }) async {
    if (headers != null) {
      _headers.addAll(headers);
    }

    return await normalConnect(
      method,
      url,
      body: body,
      headers: headers,
      query: query,
      handleError: handleError,
    );
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
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    if (headers != null && data == null) {
      _headers.addAll(headers);
    }

    final options = Options(headers: _headers);

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
      switch (method) {
        case ApiMethod.GET:
          response =
              await _client.get(url, queryParameters: query, options: options);
          break;
        case ApiMethod.POST:
          response = await _client.post(url,
              queryParameters: query, options: options, data: data ?? body);
          break;
        default:
          response =
              await _client.get(url, queryParameters: query, options: options);
          break;
      }

      // Cache api
      bool success = !(response.data is List && response.data != null)
          ? response.data['success']
          : null;
      if (response.statusCode != 200 && response.statusCode != 201 ||
          (success != null && !success)) {
        if (handleError) {
          throw response.data['message'];
        }
      } else {
        if (method == ApiMethod.GET) {
          CacheProvider()
              .cache(url + query.toString(), jsonEncode(response.data));
        }
      }
      // END cache api
    }

    _client.close();

    return response;
  }
}

enum ApiMethod { GET, POST }
