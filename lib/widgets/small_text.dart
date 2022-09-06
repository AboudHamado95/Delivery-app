import 'package:flutter/material.dart';

import 'package:delivery/utils/colors.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  final double? size;
  final double? height;
  final TextOverflow? textOverflow;
  const SmallText({
    Key? key,
    this.color = AppColors.textColor,
    required this.text,
    this.size = 12,
    this.height = 1.2,
    this.textOverflow = TextOverflow.visible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: textOverflow,
      style: TextStyle(
          color: color,
          fontWeight: FontWeight.w400,
          fontSize: size,
          fontFamily: 'Roboto',
          height: height),
    );
  }
}
