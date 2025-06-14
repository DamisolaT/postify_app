import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:postify_app/core/constants/validator.dart';
import 'package:postify_app/core/customs/custom_textfield.dart';
import 'package:postify_app/core/utils/app_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
                  'Forgot Password?',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10,),
                const FittedBox(
                  child: Text(
                    'Dont worry!It occurs please enter your email \naddress linked with your account',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                ),
                const SizedBox(height: 32,),
                 CustomBorderedTextFormField(
                    title: '',
                    hintText: "Enter your email",
                    validator: FormValidator.validateEmail,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z@._-]')),
                    ],
                    controller: _emailController,
                  ),
                  SizedBox(height: 38,),
                   AppButton(
                  text: 'Send Code',
                  onPressed: () {},
                  color: Colors.black,
                  textStyle: TextStyle(color: Colors.white),
                ),
                Spacer(),
                Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Remember Password?",
                          style: TextStyle(fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () {
                            
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 26,)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
