import 'package:flutter/material.dart';

extension TextStyles on TextStyle {
  TextStyle get medium => const TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontFamily: 'Medium',
  );

  TextStyle get bold => const TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontFamily: 'Bold',
    fontWeight: FontWeight.w700,
  );

  TextStyle get regular => const TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontFamily: 'Regular',
  );

  TextStyle get light => const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w300,
    fontSize: 16,
    fontFamily: 'Regular',
  );

  TextStyle get italic => const TextStyle(
    color: Colors.black,
    fontStyle: FontStyle.italic,
    fontSize: 16,
    fontFamily: 'Regular',
  );

  TextStyle get semiBold => const TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontFamily: 'SemiBold',
  );
}