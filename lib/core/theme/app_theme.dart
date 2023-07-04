import 'package:flutter/material.dart';
import 'package:rick_and_morty_challenge/core/constants/dimens.dart';

abstract class Palette {
  static const primaryColor = Color(0xFF5CAD4A);
  static const secondaryColor = Color(0xFFa6eee6);
  static const disabledButtonColor = Colors.transparent;
  static const fontColor = Colors.white;
}

final lightThemeData = ThemeData.light().copyWith(
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Palette.primaryColor),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Spacers.medium),
        ),
      ),
    ),
  ),
  snackBarTheme: ThemeData.light().snackBarTheme.copyWith(
        contentTextStyle: TextStyle(color: ThemeData.dark().errorColor),
      ),
  primaryColor: Palette.primaryColor,
  textTheme: ThemeData.dark()
      .textTheme
      .copyWith(button: const TextStyle(color: Palette.fontColor)),
);

final darkThemeData = ThemeData.dark().copyWith(
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Palette.primaryColor),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Spacers.medium),
        ),
      ),
    ),
  ),
  snackBarTheme: ThemeData.dark().snackBarTheme.copyWith(
        backgroundColor: const Color(0xff212121),
        contentTextStyle: TextStyle(color: ThemeData.dark().errorColor),
      ),
  primaryColor: Palette.primaryColor,
  textTheme: ThemeData.dark()
      .textTheme
      .copyWith(button: const TextStyle(color: Palette.fontColor)),
);
