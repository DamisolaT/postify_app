import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:postify_app/core/constants/validator.dart';
import 'package:postify_app/core/customs/custom_textfield.dart';
import 'package:postify_app/core/utils/app_assets.dart';
import 'package:postify_app/core/utils/app_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
   final _userController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
   final _confirmPasswordController = TextEditingController();
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
                  'Hello! Register to get \nstarted',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),
                CustomBorderedTextFormField(
                      title: '',
                      hintText: "Username",

                      controller: _userController,
                    ),
                    SizedBox(height: 12,),
                CustomBorderedTextFormField(
                  title: '',
                  hintText: "Email",
                  validator: FormValidator.validateEmail,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z@._-]')),
                  ],
                  controller: _emailController,
                ),
                const SizedBox(height: 12),
                CustomBorderedTextFormField(
                  title: '',
                  hintText: "Password",
                  validator: (value) => FormValidator.validatePassword(value),
                  obscureText: true,
                  controller: _passwordController,
                ),
                const SizedBox(height: 12),
                CustomBorderedTextFormField(
                      title: '',
                      hintText: "Confirm password",
                      validator:
                          (value) => FormValidator.validatePassword(value),
                      obscureText: true,

                      controller: _confirmPasswordController,
                    ),
               
                SizedBox(height: 30),
                AppButton(
                  text: 'Register',
                  onPressed: () {
                    
                  },
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
                        'Or Register with',
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
                          "Already have an account? ",
                          style: TextStyle(fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () {
                            
                          },
                          child: const Text(
                            "Login Now  ",
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
}

class SocialIcons extends StatelessWidget {
  const SocialIcons({
    super.key,
    required this.icon,
  });

  final Widget icon; 

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 105.w,
      height: 56.h,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: icon,
      ),
    );
  }
}
