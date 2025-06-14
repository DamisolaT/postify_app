import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:postify_app/core/utils/app_assets.dart';
import 'package:postify_app/core/utils/app_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              AppAssets.splashImage,
              fit: BoxFit.cover,
            ),
          ),
          // Overlay content
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                 SvgPicture.asset(AppAssets.iconSvg),
                  
                  // App name
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Damzy",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        TextSpan(
                          text: "digital",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  
                  AppButton(text: 'Login', onPressed: (){
                   Navigator.pushNamed(context, '/login_screen');
                  }, color: Colors.black, textStyle: TextStyle(color: Colors.white),),
                  const SizedBox(height: 12),

                  
                   AppButton(text: 'Register', onPressed: (){
                     Navigator.pushNamed(context, '/signup_screen');
                  }, color: Colors.white, textStyle: TextStyle(color: Colors.black),),
                  const SizedBox(height: 16),

                  // Guest Option
                  
                  TextButton(
                    onPressed: () {
                      //Navigator.pushNamed(context, '/signup_screen');
                    },
                    child: const Text(
                      "Continue as a guest",
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
