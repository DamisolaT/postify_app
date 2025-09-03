import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:postify_app/core/constants/validator.dart';
import 'package:postify_app/core/customs/custom_textfield.dart';
import 'package:postify_app/core/utils/app_assets.dart';
import 'package:postify_app/core/utils/app_button.dart';
import 'package:postify_app/navigator/route.dart';
import 'package:postify_app/widgets/social_media.dart';
import 'package:postify_app/view/auth/firebase_auth_impl/firebase_auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                const Text(
                  'Welcome back! Glad \nto see you, Again!',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),
                CustomBorderedTextFormField(
                  title: '',
                  hintText: "Enter your email",
                  validator: FormValidator.validateEmail,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z@._-]')),
                  ],
                  controller: _emailController,
                ),
                const SizedBox(height: 15),
                CustomBorderedTextFormField(
                  title: '',
                  hintText: "Enter your password",
                  validator: (value) => FormValidator.validatePassword(value),
                  obscureText: true,
                  controller: _passwordController,
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/forgot_password_screen');
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                AppButton(
                  text: 'Login',
                  onPressed: _signIn,
                  color: Colors.black,
                  textStyle: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 30),
                Row(
                  children: const [
                    Expanded(child: Divider(color: Colors.grey, thickness: 1)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Or Login with',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey, thickness: 1)),
                  ],
                ),
                const SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SocialIcons(icon: SvgPicture.asset(AppAssets.facebookSvg)),
                    GestureDetector(
                      onTap: () async {
                        try {
                          // Force sign out first to always show the account picker
                          await _auth.signOut();

                          final userCredential =
                              await _auth.signInWithGoogle();

                          if (userCredential != null) {
                            Navigator.pushReplacementNamed(
                                // ignore: use_build_context_synchronously
                                context, AppRouteStrings.postsPage);
                          }
                        } catch (e) {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Google Sign-In failed: ${e.toString()}'),
                            ),
                          );
                        }
                      },
                      child: SocialIcons(
                        icon: SvgPicture.asset(AppAssets.googleSvg),
                      ),
                    ),
                    SocialIcons(icon: SvgPicture.asset(AppAssets.appleSvg)),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don’t have an account? ",
                      style: TextStyle(fontSize: 14),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/register_screen');
                      },
                      child: const Text(
                        "Register Now ",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (_formKey.currentState!.validate()) {
      User? user = await _auth.signInWithEmailAndPassword(email, password);
      if (user != null) {
        Navigator.pushReplacementNamed(context, AppRouteStrings.postsPage);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed. Please try again.')),
        );
      }
    }
  }
}
