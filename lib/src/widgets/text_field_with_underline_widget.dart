import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_code/app_consts/extension/text_style_extension.dart';

class AppTextFieldWithUnderLine extends StatelessWidget {
  final TextEditingController ctrl;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final String? hint;
  final TextInputAction? action;
  final TextInputType? textInputType;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? inputFormatter;
  final FocusNode? focusNode;
  final bool? obscureText;
  final Widget? suffix;
  final VoidCallback? onSuffixTap;
  final Widget? prefix;
  final VoidCallback? onPrefixTap;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final bool? readOnly;
  final bool? enable;

  const AppTextFieldWithUnderLine({
    required this.ctrl,
    this.textStyle,
    this.textInputType,
    this.hintStyle,
    this.hint,
    this.action,
    this.textCapitalization,
    this.inputFormatter,
    this.focusNode,
    this.obscureText,
    this.suffix,
    this.onSuffixTap,
    this.prefix,
    this.onPrefixTap,
    this.onTap,
    this.padding,
    this.readOnly,
    this.enable,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: ctrl,
      enabled: enable,
      onTap: onTap,
      readOnly: readOnly ?? false,
      style: textStyle ??
          const TextStyle().regular.copyWith(
                fontSize: 16,
              ),
      focusNode: focusNode,
      obscureText: obscureText ?? false,
      keyboardType: textInputType,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      inputFormatters: inputFormatter,
      textInputAction: action,
      decoration: InputDecoration(
        suffixIcon: suffix != null
            ? InkWell(
                onTap: onSuffixTap,
                child: suffix,
              )
            : null,
        suffixIconConstraints: const BoxConstraints(
          maxHeight: 30,
        ),
        prefixIconConstraints: const BoxConstraints(
          maxHeight: 30,
        ),
        prefixIcon: prefix != null
            ? InkWell(
                onTap: onPrefixTap,
                child: prefix,
              )
            : null,
        contentPadding: padding ??
            const EdgeInsets.symmetric(
              vertical: 8,
            ),
        constraints: const BoxConstraints(
          maxHeight: 41,
        ),
        hintText: hint,
        hintStyle: hintStyle ??
            const TextStyle().regular.copyWith(
                  fontSize: 16,
                  color: Colors.black54,
                ),
        isDense: false,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black26,
            width: 1,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
      ),
    );
  }
}
