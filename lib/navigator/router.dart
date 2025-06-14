


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:postify_app/navigator/route.dart';
import 'package:postify_app/view/auth/forgot_password_screen.dart';
import 'package:postify_app/view/auth/login.dart';
import 'package:postify_app/view/auth/signup_screen.dart';
import 'package:postify_app/view/home/home_screen.dart';
import 'package:postify_app/view/home/post_page.dart';
import 'package:postify_app/view/onboarding/welcome_screen.dart';


class AppRouter {
  static final navKey = GlobalKey<NavigatorState>();

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteStrings.base:
        return CupertinoPageRoute(builder: (_) => WelcomeScreen() );
      case AppRouteStrings.loginScreen:
        return CupertinoPageRoute(builder: (_) => LoginScreen());
      case AppRouteStrings.signupScreen:
        return CupertinoPageRoute(builder: (_) => SignupScreen());
        case AppRouteStrings.forgoPasswordScreen:
        return CupertinoPageRoute(builder: (_) => ForgotPasswordScreen());
        case AppRouteStrings.postsPage:
        return CupertinoPageRoute(builder: (_) => PostsPage());
      default:
        return CupertinoPageRoute(builder: (_) =>HomeScreen());
    }
  }
}

void navigateToPage(BuildContext context, Widget page) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    ),
  );
}

void navigateToNextPageWithoutHistory(BuildContext context, String page) {
  Navigator.pushReplacementNamed(context, page);
}

void navigateToPageOutOfNavBar(BuildContext context, Widget page) {
  Navigator.of(
    context,
    rootNavigator: true,
  ).push(MaterialPageRoute(builder: (context) => page));
}
