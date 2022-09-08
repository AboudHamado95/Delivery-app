import 'package:flutter/material.dart';

import 'package:delivery/utils/colors.dart';
import 'package:delivery/utils/dimensions.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.icon,
      this.isObscure = false})
      : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool isObscure;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.radius15),
        boxShadow: [
          BoxShadow(
              blurRadius: 3,
              spreadRadius: 1,
              offset: const Offset(1, 1),
              color: Colors.grey.withOpacity(0.2))
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isObscure,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(icon, color: AppColors.yellowColor),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
            borderSide: const BorderSide(width: 1.0, color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
              borderSide: const BorderSide(width: 1.0, color: Colors.white)),
        ),
      ),
    );
  }
}
