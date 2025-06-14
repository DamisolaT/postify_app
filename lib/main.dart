import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:postify_app/navigator/route.dart';
import 'package:postify_app/navigator/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: false,
      fontSizeResolver: FontSizeResolvers.height,
      
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
         
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
       navigatorKey: AppRouter.navKey,
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: AppRouteStrings.base,
      ),
    );
  }
}

