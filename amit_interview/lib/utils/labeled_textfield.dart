import 'package:amit_interview/utils/spacing.dart';
import 'package:flutter/material.dart';

Widget labelTextField({
  required String label,
  required TextEditingController textController,
  required String hint,
  String? Function(String?)? validator,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label),
      vSpace(4),
      TextFormField(
        controller: textController,
        decoration: InputDecoration(labelText: hint),
        validator: validator,
      ),
    ],
  );
}
