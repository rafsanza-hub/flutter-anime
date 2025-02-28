
part of 'auth_bloc.dart';

abstract class AuthEvent {}

class SignInWithGoogleEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}

class CheckAuthEvent extends AuthEvent {}

