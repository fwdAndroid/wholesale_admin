import 'package:flutter/material.dart';
import 'package:wholesale_admin/utils/dimenions.dart';

import 'colors.dart';

class AppStyles {
  static var addressBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimensions.radius),
    borderSide: BorderSide(color: background),
  );
  static var underLineBorder = const UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  );

  static var focusedTransparentBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimensions.radius),
    borderSide: const BorderSide(color: Colors.transparent),
  );
  static var energyBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimensions.radius),
    borderSide: const BorderSide(color: Colors.transparent),
  );

  static var focusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimensions.radius),
    borderSide: BorderSide(color: background, width: 0.3),
  );
  static var focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimensions.radius),
    borderSide: BorderSide(color: primary, width: 0.3),
  );

  static var focusErrorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimensions.radius),
    borderSide: BorderSide(color: Colors.grey),
  );
}

errorTextStyle(context) =>
    TextStyle(fontSize: 10, fontWeight: FontWeight.w500, height: 1.4);
