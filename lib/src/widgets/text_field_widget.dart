import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_code/app_consts/extension/text_style_extension.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController ctrl;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final String? hint;
  final TextInputAction? action;
  final TextInputType? textInputType;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? inputFormatter;
  final FocusNode? focusNode;
  final bool? obscureText,readOnly;
  final Widget? suffix;
  final Widget? prefix;
  final VoidCallback? onTap;

  const AppTextField({
    required this.ctrl,
    this.textStyle,
    this.onTap,
    this.readOnly,
    this.textInputType,
    this.hintStyle,
    this.hint,
    this.action,
    this.textCapitalization,
    this.inputFormatter,
    this.focusNode,
    this.obscureText,
    this.suffix,
    this.prefix,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: ctrl,
      onTap: onTap,
      style: textStyle ??
          const TextStyle().regular.copyWith(
                fontSize: 16,
              ),
      cursorColor: Colors.black,
      readOnly: readOnly ?? false,
      focusNode: focusNode,
      obscureText: obscureText ?? false,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      inputFormatters: inputFormatter,
      textInputAction: action,
      keyboardType: textInputType,
      decoration: InputDecoration(
        suffixIcon: suffix,
        suffixIconConstraints: const BoxConstraints(
          maxHeight: 30,
          maxWidth: 30,
        ),
        prefixIconConstraints: const BoxConstraints(maxHeight: 30),
        prefixIcon: prefix,
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 21,
          vertical: 16,
        ),
        hintText: hint,
        hintStyle: hintStyle ??
            const TextStyle().regular.copyWith(
                  fontSize: 16,
                  color: Colors.black54,
                ),
        isDense: false,
        filled: true,
        fillColor: Colors.black12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            style: BorderStyle.none,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            style: BorderStyle.none,
          ),
        ),
      ),
    );
  }
}
