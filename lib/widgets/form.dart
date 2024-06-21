import 'package:flutter/material.dart';

class Forms extends StatelessWidget {
  final String label;
  final bool isnum;
  final String? Function(String?)? validtor;
  final TextEditingController controller;
  const Forms(
      {super.key,
      required this.label,
      required this.isnum,
      required this.controller,
      required this.validtor,});

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: TextFormField(
        controller: controller,
        validator: validtor,
        minLines: 1,
        
        keyboardType: isnum ? TextInputType.phone : TextInputType.text,
        maxLines: null,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          label: Text(
            label,
            style: const TextStyle(fontSize: 12, fontFamily: "Poppins"),
          ),
        ),
      ),
    );
  }
}
