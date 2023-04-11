import 'package:flutter/material.dart';
import 'package:my_code/app_consts/app_colors.dart';
import 'package:my_code/app_consts/extension/text_style_extension.dart';

class AppTextButton extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final Color? buttonColor;
  final VoidCallback onPressed;

  ///for full width button set Alignment.center
  final Alignment? alignment;
  final EdgeInsets? padding;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final Size? minimumSize;
  final Widget? icon;
  final bool? showLoader;
  final double? width;

  const AppTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.showLoader,
    this.textStyle,
    this.width,
    this.buttonColor,
    this.alignment,
    this.padding,
    this.border,
    this.icon,
    this.minimumSize,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return showLoader ?? false
        ? Container(
            height: 54,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          )
        : TextButton(
            style: TextButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: EdgeInsets.zero,
            ),
            onPressed: onPressed,
            child: Container(
              width: width ?? double.infinity,
              padding: padding ??
                  const EdgeInsets.symmetric(
                    vertical: 12,
                  ),
              decoration: BoxDecoration(
                  border: border,
                  borderRadius: borderRadius ?? BorderRadius.circular(10),
                  color: buttonColor ?? AppColors.purpleColor),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: textStyle ??
                    const TextStyle().bold.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                        ),
              ),
            ),
          );
  }
}
