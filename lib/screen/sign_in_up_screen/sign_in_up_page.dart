import 'package:chocolate_store/shared_widget/custom_child_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../shared_widget/custom_main_container.dart';
import '../home_page_screen/home_page.dart';
import '../home_page_screen/home_page_model/prod_class.dart';
import 'custom_text_form_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isSignIn = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomMainContainer(
        child: Center(
          child: CustomChildContainer(
            width: 350,
            height: 700,
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.arrow_left_circle,
                        color: Color(0xFF160704),
                      ),
                    ),
                    Center(
                      widthFactor: 5,
                      child: Text(
                        isSignIn ? 'تسجيل دخول' : 'إنشاء حساب',
                        style: const TextStyle(
                          color: Color(0xFF160704),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 30),
                  width: 350,
                  child: const Center(
                    child: Text(
                      "شوكولا مزاج",
                      style: TextStyle(
                          fontFamily: 'YesevaOne',
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF160704),
                          letterSpacing: 4),
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
                  padding:
                      const EdgeInsets.only(top: 50.0, left: 18, right: 18),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        if (!isSignIn)
                          const CustomTextFormField(
                              label: 'اسم المستخدم', icon: Icons.person),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                        ),
                        CustomTextFormField(
                          label: 'البريد الالكتروني',
                          icon: Icons.email,
                          validator: (value) {
                            if (value == null || !value.contains('@')) {
                              return 'بريد الكتروني خاطئ';
                            }
                            return null;
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                        ),
                        CustomTextFormField(
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
                            label: 'تأكيد كلمة المرور',
                            icon: Icons.password,
                            validator: (value) {
                              if (value == null || value.length < 6) {
                                return 'أعد كتابة كلمة المرور';
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return HomePage(
                                      userName: 'اسم المستخدم',
                                    );
                                  },
                                ),
                              );
                            }
                          },
                          label: Text(
                            isSignIn ? 'تسجيل دخول' : 'إنشاء حساب',
                            style: const TextStyle(
                              color: Color(0xFF160704),
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
                            Text(isSignIn
                                ? 'مستخدم جديد؟'
                                : 'هل تمتلك حساب بالفعل؟'),
                          ],
                        ),
                      ],
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
