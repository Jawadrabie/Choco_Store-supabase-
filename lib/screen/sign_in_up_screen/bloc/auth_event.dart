import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthEmailChanged extends AuthEvent {
  final String email;
  AuthEmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class AuthPasswordChanged extends AuthEvent {
  final String password;
  AuthPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class AuthUsernameChanged extends AuthEvent {
  final String username;
  AuthUsernameChanged(this.username);

  @override
  List<Object?> get props => [username];
}

class AuthSubmitted extends AuthEvent {
  final bool isSignIn;
  AuthSubmitted(this.isSignIn);

  @override
  List<Object?> get props => [isSignIn];
}