library repo;

import 'package:base/base.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/models.dart';

import 'providers/providers.dart';

part 'repositories/authRepository.dart';
part 'repositories/userRepository.dart';
part 'repositories/placeRepository.dart';
part 'repositories/tourRepository.dart';
part 'repositories/tourInfoRepository.dart';
part 'repositories/post_repository.dart';

class Repository {
  static final Repository _repository = Repository._();

  Repository._();
  factory Repository() => _repository;

  final _AuthRepository auth = _AuthRepository();
  final _UserRepository user = _UserRepository();
  final _PlaceRepository place = _PlaceRepository();
  final _TourRepository tour = _TourRepository();
  final _TourInfoRepository tourInfo = _TourInfoRepository();
  final _PostRepository post = _PostRepository();
  final ChatProvider chat = ChatProvider();
}

enum StorageKey {
  Email,
  Token,
}
