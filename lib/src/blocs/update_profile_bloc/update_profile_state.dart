part of 'update_profile_bloc.dart';

@immutable
abstract class UpdateProfileState {}

class UpdateProfileInitial extends UpdateProfileState {}

class UpdateProfileStateLoading extends UpdateProfileState {}

class UpdateProfileStateSuccess extends UpdateProfileState {}

class UpdateProfileStateFailure extends UpdateProfileState {
  final String error;

  UpdateProfileStateFailure(this.error);

  @override
  String toString() => '$runtimeType $error';
}
