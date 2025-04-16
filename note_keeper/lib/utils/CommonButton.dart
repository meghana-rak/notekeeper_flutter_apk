import 'package:flutter/material.dart';
import 'package:note_keeper/Constants/CommonTextStyle.dart';

class CommonButton extends StatelessWidget {



  ///Common Button for all use
  final String? title;
  final void Function()? onTap;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  const CommonButton(
      {super.key,
      this.title,
      this.onTap,
      this.color,
      this.padding,
      this.margin});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: padding,
        width: double.infinity,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color ?? Colors.white,
        ),
        child: Text(
          title ?? 'Confirm',
          style: commonTextStyle.copyWith(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
