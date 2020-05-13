library repo;

import 'package:base/base.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/models/tour.dart';

import 'providers/providers.dart';

part 'repositories/authRepository.dart';
part 'repositories/userRepository.dart';

class Repository {
  static final Repository _repository = Repository._();

  Repository._();
  factory Repository() => _repository;

  final _AuthRepository auth = _AuthRepository();
  final _UserRepository user = _UserRepository();
}

enum StorageKey {
  Email,
  Token,
}
