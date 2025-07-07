import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final Function(String) onSaved;
  final String? initialValue;
  const CustomTextField(
    this.label,
    this.onSaved, {
    this.initialValue,
    super.key,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialValue ?? '');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: widget.label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
      ),
      onSaved: (value) => widget.onSaved(value ?? ''),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '${widget.label} is required';
        }
        return null;
      },
    );
  }
}

Widget verticalgap() => SizedBox(height: 16);
