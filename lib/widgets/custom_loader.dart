import 'package:delivery/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: AppColors.mainColor,
        child: const CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
