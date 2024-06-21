import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool? obscureText;
  const CustomTextField(
      {super.key,
      required this.label,
      required this.icon,
      required this.keyboardType,
      required this.controller,
      this.validator,
      this.suffixIcon,
      this.obscureText
      });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return "Please enter $label";
            }
            return null;
          },
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary.withOpacity(.1),
          ), // Non-focused border color
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary.withOpacity(.68),
          ), // Non-focused border color
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        filled: true,
        fillColor: Theme.of(context).colorScheme.primary.withOpacity(.02),
        helperStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontFamily: "Poppins",
          fontSize: 11,
        ),
        labelText: label,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary.withOpacity(.2),
          ),
        ),
        prefixIcon: Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
          size: 20,
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
