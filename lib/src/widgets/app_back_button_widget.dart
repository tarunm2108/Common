import 'package:flutter/material.dart';

class AppBackButtonWidget extends StatelessWidget {
  final Widget? icon;
  const AppBackButtonWidget({
    this.icon,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(0.7, 0),
      width: 36,
      height: 36,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 3, spreadRadius: 2)
          ]),
      child: icon ??
          const Icon(
            Icons.arrow_back_ios,
            color: Color(0xff043645),
            size: 21,
          ),
    );
  }
}
