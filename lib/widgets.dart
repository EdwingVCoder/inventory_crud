import 'package:flutter/material.dart';

class CodeInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const CodeInput(
      {super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefix: const Text('#'),
          border: const UnderlineInputBorder(),
          hintText: hintText,
        ),
      ),
    );
  }
}

class MoneyInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const MoneyInput(
      {super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefix: const Text('\$'),
          suffix: const Text('COP'),
          border: const UnderlineInputBorder(),
          hintText: hintText,
        ),
      ),
    );
  }
}

class StockInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const StockInput(
      {super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          suffix: const Text('Unidades'),
          border: const UnderlineInputBorder(),
          hintText: hintText,
        ),
      ),
    );
  }
}

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
