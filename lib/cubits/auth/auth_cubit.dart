// lib/cubits/auth/auth_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/auth_repository.dart';
import 'auth_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(const AuthState());

  // sign in
  Future<void> signIn(String email, String password) async {
    emit(state.copyWith(isLoading: true, errorMessage: null, isSuccess: false));
    try {
      final AuthResponse res =
      await _authRepository.signInWithEmail(email, password);

      if (res.user == null && res.session == null) {
        throw Exception('فشل تسجيل الدخول.');
      }

      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: _formatError(e), isSuccess: false));
    }
  }

  // sign up (بدون إنشاء profile يدويًا)
  Future<void> signUp(
      String email, String password, String fullName, String phone) async {
    emit(state.copyWith(isLoading: true, errorMessage: null, isSuccess: false));
    try {
      final AuthResponse res =
      await _authRepository.signUpWithEmail(email, password);

      if (res.user == null) {
        throw Exception('فشل إنشاء الحساب.');
      }

      // 🚫 ما عاد نحتاج createProfile هنا
      // التريجر رح يعمل INSERT تلقائي في جدول profiles
      // وبعدين ينسخ الاسم + الرقم للـ raw_user_meta_data

      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: _formatError(e), isSuccess: false));
    }
  }

  // reset password
  Future<void> resetPassword(String email) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      await _authRepository.resetPassword(email);
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: _formatError(e)));
    }
  }

  // sign out
  Future<void> signOut() async {
    await _authRepository.signOut();
    emit(const AuthState(
        isLoading: false, isSuccess: false, errorMessage: null));
  }

  String _formatError(Object e) {
    final s = e.toString();
    if (s.contains('AuthApiException')) {
      final re = RegExp(r'message:\s*([^,]+),');
      final m = re.firstMatch(s);
      if (m != null) return m.group(1)!.trim();
    }
    return s;
  }
}