import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

final theme = ThemeData(
  useMaterial3: false,
  fontFamily: 'w700',
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.main,
  // primarySwatch: Colors.grey,
  // textSelectionTheme: const TextSelectionThemeData(
  //   cursorColor: AppColors.main,
  //   selectionColor: AppColors.main,
  //   selectionHandleColor: AppColors.main,
  // ),
  // colorScheme: ColorScheme.fromSwatch(
  //   accentColor: AppColors.main, // overscroll indicator color
  // ),
  dialogTheme: const DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(24)),
    ),
  ),
);

const cupertinoTheme = CupertinoThemeData(
  textTheme: CupertinoTextThemeData(
    dateTimePickerTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontFamily: 'w500',
    ),
  ),
);
