import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final SupabaseClient _client = Supabase.instance.client;

  // sign up with email/password (returns AuthResponse)
  Future<AuthResponse> signUpWithEmail(String email, String password) async {
    final res = await _client.auth.signUp(
      email: email,
      password: password,
    );
    return res;
  }

  // sign in with email/password (returns AuthResponse)
  Future<AuthResponse> signInWithEmail(String email, String password) async {
    final res = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return res;
  }

  // reset password (send email)
  Future<void> resetPassword(String email) async {
    await _client.auth.resetPasswordForEmail(email);
  }

  // sign out
  Future<void> signOut() async {
    await _client.auth.signOut();
  }
}
