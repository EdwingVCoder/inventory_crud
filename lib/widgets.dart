import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const TextInput(
      {super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          hintText: hintText,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------

Padding productData(String label, value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Text(label,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
        const SizedBox(
          width: 8,
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16),
        )
      ],
    ),
  );
}
