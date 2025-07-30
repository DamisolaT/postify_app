
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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