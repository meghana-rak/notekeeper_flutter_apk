part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class PassVisibleToggle extends RegisterState {}

final class RegisterSuccess extends RegisterState {}

final class RegisterError extends RegisterState {}


final class DataError extends RegisterState {}
