import 'package:chocolate_store/shared_widget/custom_child_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../shared_widget/custom_main_container.dart';
import '../home_page_screen/home_page.dart';
import 'custom_text_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/auth/auth_cubit.dart';
import '../../cubits/auth/auth_state.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isSignIn = true;
  final _formKey = GlobalKey<FormState>();

  // controllers (added, but UI same)
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _confirmPasswordCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomMainContainer(
        child: Center(
          child: CustomChildContainer(
            width: 350,
            height: 700,
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                // show errors in snackbar
                if (state.errorMessage != null) {
                  print(state.errorMessage!);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorMessage!)),
                  );
                }
                // on success navigate to HomePag
                if (state.isSuccess) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return HomePage();
                      },
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    Row(
                      children: [
                        // IconButton(
                        //   onPressed: () {},
                        //   icon: const Icon(
                        //     CupertinoIcons.arrow_left_circle,
                        //     color: Color(0xFF160704),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Center(
                            widthFactor: 5.5,
                            child: Text(
                              isSignIn ? 'تسجيل دخول' : 'إنشاء حساب',
                              textDirection: TextDirection.rtl,
                              style: const TextStyle(
                                color: Color(0xFF160704),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 30),
                      width: 350,
                      child: const Center(
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                " شـوكـولا مـزاج",
                                style: TextStyle(
                              fontFamily: 'YesevaOne',
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF160704),
                                    letterSpacing: 0),
                              ),
                            ),
                            Text(
                              "mazag chocolate",
                              style: TextStyle(
                                  fontFamily: 'YesevaOne',
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF160704),
                                  letterSpacing: 0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 17),
                      width: 350,
                      child: const Text(
                        "!خيارك الأول للسعادة",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF160704),
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0, left: 18, right: 18),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            if (!isSignIn)
                              CustomTextFormField(
                                controller: _nameCtrl,
                                label: 'اسم المستخدم',
                                icon: Icons.person,
                                validator: (value) {
                                  if (value == null || value.isEmpty) return 'مطلوب';
                                  return null;
                                },
                              ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                            ),
                            CustomTextFormField(
                              controller: _emailCtrl,
                              label: 'البريد الالكتروني',
                              icon: Icons.email,
                              validator: (value) {
                                if (value == null || !value.contains('@') || !value.contains('.')) {
                                  return 'بريد الكتروني خاطئ';
                                }
                                return null;
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                            ),
                            CustomTextFormField(
                              controller: _passwordCtrl,
                              label: 'كلمة المرور',
                              icon: Icons.password,
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.length < 6) {
                                  return 'كلمة المرور يجب أن تكون على الأقل 6 محارف';
                                }
                                return null;
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                            ),
                            if (!isSignIn)
                              CustomTextFormField(
                                controller: _confirmPasswordCtrl,
                                label: 'تأكيد كلمة المرور',
                                icon: Icons.password,
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.length < 6) {
                                    return 'أعد كتابة كلمة المرور';
                                  }
                                  if (value != _passwordCtrl.text) {
                                    return 'كلمتا المرور غير متطابقتين';
                                  }
                                  return null;
                                },
                              ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                            ),
                            if (!isSignIn)
                              CustomTextFormField(
                                controller: _phoneCtrl,
                                label: 'رقم الهاتف ',
                                icon: Icons.phone,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'تاكد من رقم هاتفك';
                                  }
                                  return null;
                                },
                              ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                            ),
                            ElevatedButton.icon(
                              icon: const Icon(
                                Icons.arrow_circle_right_rounded,
                                color: Color(0xFF160704),
                                size: 35,
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF9C5D3A),
                                  shape: const StadiumBorder(),
                                  minimumSize: const Size(120, 50)),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (isSignIn) {
                                    // call cubit signIn
                                    context.read<AuthCubit>().signIn(
                                      _emailCtrl.text.trim(),
                                      _passwordCtrl.text.trim(),
                                    );
                                  } else {
                                    // sign up
                                    context.read<AuthCubit>().signUp(
                                      _emailCtrl.text.trim(),
                                      _passwordCtrl.text.trim(),
                                      _nameCtrl.text.trim(),
                                      _phoneCtrl.text.trim(),
                                    );
                                  }
                                }
                              },
                              label: Text(
                                isSignIn ? 'تسجيل دخول' : 'إنشاء حساب',
                                style: const TextStyle(
                                  color: Color(0xFF160704),
                                ),
                              ),
                            ),

                            // New: "نسيت كلمة المرور؟" button (only in sign-in mode)
                            if (isSignIn)
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    final email = _emailCtrl.text.trim();
                                    if (email.isEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text("رجاءً اكتب ايميلك أولاً")),
                                      );
                                    } else {
                                      // call cubit resetPassword
                                      context.read<AuthCubit>().resetPassword(email);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text("تفقد بريدك الإلكتروني")),
                                      );
                                    }
                                  },
                                  child: const Text(
                                    'نسيت كلمة المرور؟',
                                    style: TextStyle(
                                      color: Color(0xFF160704),
                                    ),
                                  ),
                                ),
                              ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _formKey.currentState?.reset();
                                      isSignIn = !isSignIn;
                                    });
                                  },
                                  child: Text(
                                    isSignIn ? 'إنشاء حساب' : 'تسجيل دخول',
                                    style: const TextStyle(
                                      color: Color(0xFF160704),
                                    ),
                                  ),
                                ),
                                Text(isSignIn ? 'مستخدم جديد؟' : 'هل تمتلك حساب بالفعل؟'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
