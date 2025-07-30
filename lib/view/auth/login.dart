import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/svg.dart';
import 'package:postify_app/core/constants/validator.dart';
import 'package:postify_app/core/customs/custom_textfield.dart';
import 'package:postify_app/core/utils/app_assets.dart';
import 'package:postify_app/core/utils/app_button.dart';
import 'package:postify_app/navigator/route.dart';
import 'package:postify_app/view/auth/firebase_auth_impl/firebase_auth_service.dart';

import 'package:postify_app/widgets/social_media.dart';

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
  // final String? errorText;



  
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
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/forgot_password_screen');
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                AppButton(
                  text: 'Login',
                  onPressed: _signIn,
                  color: Colors.black,
                  textStyle: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey, thickness: 1)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Or Login with',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey, thickness: 1)),
                  ],
                ),
                SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SocialIcons(icon: SvgPicture.asset(AppAssets.facebookSvg),),
                    SizedBox(width: 8,),
                    SocialIcons(icon: SvgPicture.asset(AppAssets.googleSvg),),
                    SizedBox(width: 8,),
                    SocialIcons(icon: SvgPicture.asset(AppAssets.appleSvg),),
                  ],
                ),
                Spacer(),
                Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don’t have an account? ",
                          style: TextStyle(fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () {
                            
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
                    SizedBox(height: 30,)
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
      
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed. Please try again.')),
      );
    }
  }
}
}



  



   

