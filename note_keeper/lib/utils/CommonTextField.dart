import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_keeper/Constants/CommonColors.dart';

class CommonTextFormField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final bool enabled;
  final int? maxLength;
  final void Function(String)? onChanged;
  CommonTextFormField(
      {super.key,
      this.hintText,
      required this.controller,
      this.validator,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.prefixIcon,
      this.suffixIcon,
      this.onSuffixIconPressed,
      this.enabled = true,
      this.maxLength,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    ///Common Customise textField
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      enabled: enabled,
      validator: validator,
      maxLength: maxLength ?? 50,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        counterText: '',
        hintStyle: TextStyle(color: CommonColors.placeHolderColour),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: CommonColors.greyColour)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(
                  suffixIcon,
                  color: Colors.grey,
                ),
                onPressed: onSuffixIconPressed,
              )
            : null,
      ),
    );
  }
}
