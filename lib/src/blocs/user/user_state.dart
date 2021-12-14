import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserFullNameSubmitFailure extends UserState {}

class UserLoadInProgress extends UserState {}

class UserSignupSuccess extends UserState {}

class UserLoginSuccess extends UserState {}

class UserEmailSubmitFailure extends UserState {}

class UserPasswordSubmitFailure extends UserState {}

class UserSignupFailure extends UserState {}

class UserLoginFailure extends UserState {}

class UserAuthFailure extends UserState {
  final String exception;
  const UserAuthFailure(this.exception);
  @override
  List<Object> get props => [exception];
}
