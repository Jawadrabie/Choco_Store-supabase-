import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const supabaseUrl =
      'https://greyryymsvoxdresvglq.supabase.co'; // ضع Project URL هنا
  static const supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdyZXlyeXltc3ZveGRyZXN2Z2xxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTY1NTU2NjIsImV4cCI6MjA3MjEzMTY2Mn0.4mNjZa0uzplXCVGalqAPKqCgQ4EfUxlIbOQ1ktzVifk'; // ضع anon key هنا

  static Future<void> init() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
      // debug: true, // فعل هذا أثناء التطوير إن أردت
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}
