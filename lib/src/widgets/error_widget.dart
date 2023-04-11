import 'package:flutter/material.dart';
import 'package:my_code/app_consts/extension/text_style_extension.dart';

class ErrorWidgetView extends StatelessWidget {
  final String errorMsg;

  const ErrorWidgetView({required this.errorMsg, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          const Icon(
            Icons.error_outline,
            size: 50,
          ),
          Text(
            errorMsg,
            style: const TextStyle().bold,
          ),
        ],
      ),
    );
  }
}
