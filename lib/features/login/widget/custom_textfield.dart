import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.emailController,
    required this.validator,
    required this.hintText,
    this.suffixIcon,
    required this.keyboardType,
    this.isPasswordVisible = false,
  });

  final TextEditingController emailController;
  final String? Function(String?)? validator;
  final String hintText;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final bool? isPasswordVisible;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      autofocus: false,
      obscureText: isPasswordVisible!,
      keyboardType: keyboardType,
      autocorrect: false,
      validator: validator,
      cursorColor: Colors.orangeAccent,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 14),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          borderSide: BorderSide(
            color: Colors.black54,
          ),
        ),
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          borderSide: BorderSide(color: Colors.black54.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          borderSide: BorderSide(
            color: Colors.deepOrangeAccent.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
