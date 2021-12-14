import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserSignupButtonSubmitted extends UserEvent {
  final String email;
  final String password;
  final String fullname;
  const UserSignupButtonSubmitted(
      {required this.email, required this.password, required this.fullname});
  @override
  List<Object> get props => [email, password, fullname];
}

class UserLoginButtonSubmitted extends UserEvent {
  final String email;
  final String password;
  const UserLoginButtonSubmitted({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}
