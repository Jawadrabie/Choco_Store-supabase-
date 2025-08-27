import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final String email;
  final String password;
  final String username;
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;

  const AuthState({
    this.email = '',
    this.password = '',
    this.username = '',
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  AuthState copyWith({
    String? email,
    String? password,
    String? username,
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      username: username ?? this.username,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [email, password, username, isLoading, errorMessage, isSuccess];
}