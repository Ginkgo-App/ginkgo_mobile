library base;

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as Storage;

part 'src/appBase.dart';
part 'src/appClient.dart';
part 'src/appConfig.dart';
part 'src/blocLogger.dart';
part 'src/cacheProvider.dart';
part 'src/errorState.dart';
part 'src/extensions/contextExt.dart';
part 'src/storageProvider.dart';
part 'src/extensions/stringExt.dart';
