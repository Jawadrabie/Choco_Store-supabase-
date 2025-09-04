// lib/screen/profile/profile_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../cubits/auth/auth_cubit.dart';
import '../../screen/sign_in_up_screen/sign_in_up_page.dart';
import '../../shared_widget/custom_main_container.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _supabase = Supabase.instance.client;
  bool _loading = true;
  Map<String, dynamic>? _profile; // will hold row from public.profiles
  String _email = '';

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() => _loading = true);

    try {
      final user = _supabase.auth.currentUser;
      if (user == null) {
        // no user - show empty state
        setState(() {
          _email = '';
          _profile = null;
          _loading = false;
        });
        return;
      }

      _email = user.email ?? '';

      // Query the profiles table for the current user
      final dynamic res = await _supabase
          .from('profiles')
          .select()
          .eq('user_id', user.id)
          .maybeSingle();

      // Normalize the response into a Map<String, dynamic> if possible
      Map<String, dynamic>? row;
      if (res == null) {
        row = null;
      } else if (res is Map) {
        // e.g. SDK returned a Map
        row = Map<String, dynamic>.from(res as Map);
      } else if (res is List && res.isNotEmpty && res[0] is Map) {
        // sometimes SDK returns a List
        row = Map<String, dynamic>.from(res[0] as Map);
      } else {
        // unknown shape -> leave null
        row = null;
      }

      setState(() {
        _profile = row;
        _loading = false;
      });
    } catch (e) {
      // show error but keep UI stable
      setState(() {
        _profile = null;
        _loading = false;
      });
      final message = e.toString();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل جلب البيانات: $message')),
        );
      }
    }
  }

  Future<void> _onSignOut() async {
    // call cubit to handle signOut logic (clearing SharedPreferences etc.)
    try {
      context.read<AuthCubit>().signOut();
    } catch (_) {
      // fallback: call repository directly (if needed)
      try {
        await _supabase.auth.signOut();
      } catch (_) {}
    }

    // navigate to SignInPage and clear history
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const SignInPage()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final fullName = _profile != null
        ? (_profile!['full_name'] ?? '') as String
        : '';
    final phone = _profile != null ? (_profile!['phone'] ?? '') as String : '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('الملف الشخصي'),
        backgroundColor: const Color(0xFF995D39),
        centerTitle: true,
      ),
      body: CustomMainContainer(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
            child: Column(
              children: [
                const SizedBox(height: 8),
                // Profile card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundColor: const Color(0xFF9C5D3A),
                        child: Text(
                          (fullName.isNotEmpty ? fullName[0] : (_email.isNotEmpty ? _email[0] : 'U')).toUpperCase(),
                          style: const TextStyle(fontSize: 28, color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fullName.isNotEmpty ? fullName : 'اسم غير محدد',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF160704),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              _email.isNotEmpty ? _email : 'لا يوجد بريد مسجّل',
                              style: const TextStyle(fontSize: 14, color: Color(0xFF160704)),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              phone.isNotEmpty ? phone : 'لا يوجد رقم مسجل',
                              style: const TextStyle(fontSize: 14, color: Color(0xFF160704)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Additional info or action buttons (read-only as requested)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _ReadOnlyField(label: 'الاسم', value: fullName),
                      const SizedBox(height: 10),
                      _ReadOnlyField(label: 'البريد الإلكتروني', value: _email),
                      const SizedBox(height: 10),
                      _ReadOnlyField(label: 'رقم الجوال', value: phone),
                    ],
                  ),
                ),

                // Sign out button fixed at bottom
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9C5D3A),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () async {
                        // confirm dialog
                        final ok = await showDialog<bool>(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('تأكيد'),
                            content: const Text('هل تريد تسجيل الخروج؟'),
                            actions: [
                              TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('إلغاء')),
                              TextButton(onPressed: () => Navigator.of(ctx).pop(true), child: const Text('نعم')),
                            ],
                          ),
                        );
                        if (ok == true) await _onSignOut();
                      },
                      child: const Text('تسجيل خروج', style: TextStyle(color: Color(0xFF160704), fontSize: 16)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ReadOnlyField extends StatelessWidget {
  final String label;
  final String value;
  const _ReadOnlyField({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 13, color: Color(0xFF160704), fontWeight: FontWeight.bold)),
      const SizedBox(height: 6),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFF160704), width: 0.8),
        ),
        child: Text(value.isNotEmpty ? value : '-', style: const TextStyle(fontSize: 15, color: Color(0xFF160704))),
      ),
    ]);
  }
}
