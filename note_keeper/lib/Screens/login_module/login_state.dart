part of 'login_cubit.dart';

@immutable
sealed class LoginState {}
///This all state for login
final class LoginInitial extends LoginState {}

final class VisibleToggle extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginError extends LoginState {}
