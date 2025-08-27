import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<AuthEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email, errorMessage: null));
    });
    on<AuthPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password, errorMessage: null));
    });
    on<AuthUsernameChanged>((event, emit) {
      emit(state.copyWith(username: event.username, errorMessage: null));
    });
    on<AuthSubmitted>((event, emit) async {
      emit(state.copyWith(isLoading: true, errorMessage: null, isSuccess: false));
      try {
        // Replace with your actual authentication logic
        await Future.delayed(Duration(seconds: 2));
        // Here you can call your API or Firebase, etc.
        if (state.email == 'test@test.com' && state.password == 'password') {
          emit(state.copyWith(isLoading: false, isSuccess: true));
        } else {
          emit(state.copyWith(isLoading: false, errorMessage: 'Invalid credentials'));
        }
      } catch (e) {
        emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      }
    });
  }
}