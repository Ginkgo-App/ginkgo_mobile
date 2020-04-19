library repo;

import 'package:base/base.dart';
import 'package:flutter/material.dart';

import 'providers/providers.dart';

part 'repositories/authRepository.dart';

class Repository {
  static final Repository _repository = Repository._();

  Repository._();
  factory Repository() => _repository;

  final _AuthRepository auth = _AuthRepository();
}

enum StorageKey {
  Email,
  Token,
}
