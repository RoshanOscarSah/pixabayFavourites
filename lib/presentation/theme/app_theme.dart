import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class AppTheme {
  static ThemeData getMaterialTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    );
  }

  static CupertinoThemeData getCupertinoTheme() {
    return const CupertinoThemeData(
      primaryColor: CupertinoColors.systemPurple,
      brightness: Brightness.light,
    );
  }

  static bool get isIOS => Platform.isIOS;
}


