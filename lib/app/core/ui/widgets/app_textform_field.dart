import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../extensions/theme_extension.dart';

class AppTextformField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final ValueNotifier<bool> _obscureTextVN;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;

  AppTextformField({
    required this.labelText,
    this.obscureText = false,
    this.inputFormatters,
    this.controller,
    this.validator,
    this.keyboardType,
    this.focusNode,
    super.key,
  }) : _obscureTextVN = ValueNotifier<bool>(obscureText);

  static const _borderRadius = BorderRadius.all(Radius.circular(15));

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _obscureTextVN,
      builder: (_, obscureTextVNValue, __) => TextFormField(
        keyboardType: keyboardType,
        obscureText: obscureTextVNValue,
        inputFormatters: inputFormatters,
        validator: validator,
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(fontSize: 15, color: Colors.black),
          border: const OutlineInputBorder(
            borderRadius: _borderRadius,
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: _borderRadius,
            borderSide: BorderSide(color: Colors.grey),
          ),
          suffixIcon: obscureText
              ? IconButton(
                  onPressed: () => _obscureTextVN.value = !obscureTextVNValue,
                  icon: Icon(
                    _getIcon(obscureTextVNValue),
                    color: context.primaryColor,
                  ),
                )
              : null,
        ),
      ),
    );
  }

  IconData _getIcon(bool obscureTextVNValue) =>
      obscureTextVNValue ? Icons.lock : Icons.lock_open;
}
