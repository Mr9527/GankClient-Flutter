import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///颜色
class ThemeColors {

  static const int primaryIntValue = 0xFFFDCF00;

  static const MaterialColor primarySwatch = const MaterialColor(
    primaryIntValue,
    const <int, Color>{
      50: const Color(primaryIntValue),
      100: const Color(primaryIntValue),
      200: const Color(primaryIntValue),
      300: const Color(primaryIntValue),
      400: const Color(primaryIntValue),
      500: const Color(primaryIntValue),
      600: const Color(primaryIntValue),
      700: const Color(primaryIntValue),
      800: const Color(primaryIntValue),
      900: const Color(primaryIntValue),
    },
  );


  static const Color primaryValue = Color(0xFF24292E);
  static const Color primaryLightValue = Color(0xFF42464b);
  static const Color primaryDarkValue = Color(0xFF121917);

  static const Color divider = Color(0xFFEEEEEE);
  static const Color normalBackground = Color(0xFFF4F1F4);
  static const Color mainTitleBackground = Color(0xFF262a36);
  static const Color enableNormal = Color(0xFFD2D2D2);
  static const Color unused = Color(0xFFD2D2D2);
  static const Color white = Color(0xFFFFFFFF);
  static const Color subTextColor = Color(0xff999999);
  static const Color subLightTextColor = Color(0xffc4c4c4);
  static const Color mainTextColor = Color(0xFF121917);
  static const Color textColorWhite = white;

  static Color hexToColor(String s) {
    // 如果传入的十六进制颜色值不符合要求，返回默认值
    if (s == null ||
        s.length != 7 ||
        int.tryParse(s.substring(1, 7), radix: 16) == null) {
      s = '#999999';
    }

    return new Color(int.parse(s.substring(1, 7), radix: 16) + 0xFF000000);
  }
}

///文本样式
class GankTextStyle {

  static bigTextSize() => 36.sp;

  static lagerTextSize() => 32.sp;

  static normalTextSize() => 30.sp;

  static middleTextWhiteSize() => 28.sp;

  static smallTextSize() => 24.sp;

  static minTextSize() => 22.sp;

  static TextStyle minText = TextStyle(
    color: ThemeColors.subLightTextColor,
    fontSize: minTextSize(),
  );

  static TextStyle smallTextWhite = TextStyle(
    color: ThemeColors.textColorWhite,
    fontSize: smallTextSize(),
  );

  static TextStyle smallText = TextStyle(
    color: ThemeColors.mainTextColor,
    fontSize: smallTextSize(),
  );

  static TextStyle smallTextBold = TextStyle(
    color: ThemeColors.mainTextColor,
    fontSize: smallTextSize(),
    fontWeight: FontWeight.bold,
  );

  static TextStyle smallSubLightText = TextStyle(
    color: ThemeColors.subLightTextColor,
    fontSize: smallTextSize(),
  );

  static TextStyle smallMiLightText = TextStyle(
    color: ThemeColors.textColorWhite,
    fontSize: smallTextSize(),
  );

  static TextStyle smallSubText = TextStyle(
    color: ThemeColors.subTextColor,
    fontSize: smallTextSize(),
  );

  static TextStyle middleText = TextStyle(
    color: ThemeColors.mainTextColor,
    fontSize: middleTextWhiteSize(),
  );

  static TextStyle middleTextWhite = TextStyle(
    color: ThemeColors.textColorWhite,
    fontSize: middleTextWhiteSize(),
  );

  static TextStyle middleSubText = TextStyle(
    color: ThemeColors.subTextColor,
    fontSize: middleTextWhiteSize(),
  );

  static TextStyle middleSubLightText = TextStyle(
    color: ThemeColors.subLightTextColor,
    fontSize: middleTextWhiteSize(),
  );

  static TextStyle middleTextBold = TextStyle(
    color: ThemeColors.mainTextColor,
    fontSize: middleTextWhiteSize(),
    fontWeight: FontWeight.bold,
  );

  static TextStyle middleTextWhiteBold = TextStyle(
    color: ThemeColors.textColorWhite,
    fontSize: middleTextWhiteSize(),
    fontWeight: FontWeight.bold,
  );

  static TextStyle middleSubTextBold = TextStyle(
    color: ThemeColors.subTextColor,
    fontSize: middleTextWhiteSize(),
    fontWeight: FontWeight.bold,
  );

  static TextStyle normalText = TextStyle(
    color: ThemeColors.mainTextColor,
    fontSize: normalTextSize(),
  );

  static TextStyle normalTextBold = TextStyle(
    color: ThemeColors.mainTextColor,
    fontSize: normalTextSize(),
    fontWeight: FontWeight.bold,
  );

  static TextStyle normalSubText = TextStyle(
    color: ThemeColors.subTextColor,
    fontSize: normalTextSize(),
  );

  static TextStyle normalTextWhite = TextStyle(
    color: ThemeColors.textColorWhite,
    fontSize: normalTextSize(),
  );

  static TextStyle normalTextMitWhiteBold = TextStyle(
    color: ThemeColors.textColorWhite,
    fontSize: normalTextSize(),
    fontWeight: FontWeight.bold,
  );


  static TextStyle normalTextLight = TextStyle(
    color: ThemeColors.primaryLightValue,
    fontSize: normalTextSize(),
  );

  static TextStyle largeText = TextStyle(
    color: ThemeColors.mainTextColor,
    fontSize: bigTextSize(),
  );

  static TextStyle largeTextBold = TextStyle(
    color: ThemeColors.mainTextColor,
    fontSize: bigTextSize(),
    fontWeight: FontWeight.bold,
  );

  static TextStyle largeTextWhite = TextStyle(
    color: ThemeColors.textColorWhite,
    fontSize: bigTextSize(),
  );

  static TextStyle largeTextWhiteBold = TextStyle(
    color: ThemeColors.textColorWhite,
    fontSize: bigTextSize(),
    fontWeight: FontWeight.bold,
  );

  static TextStyle largeLargeTextWhite = TextStyle(
    color: ThemeColors.textColorWhite,
    fontSize: lagerTextSize(),
    fontWeight: FontWeight.bold,
  );

  static TextStyle largeLargeText = TextStyle(
    color: ThemeColors.primaryValue,
    fontSize: lagerTextSize(),
    fontWeight: FontWeight.bold,
  );
}

class GankIcons {
  static const String FONT_FAMILY = 'common';
  static const IconData enter = const IconData(0xe6f8, fontFamily: GankIcons.FONT_FAMILY);
  static const IconData back = const IconData(0xe720, fontFamily: GankIcons.FONT_FAMILY);
}