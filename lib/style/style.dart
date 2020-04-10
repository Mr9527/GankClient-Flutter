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
  static const Color label = Color(0xFF448ef6);
  static const Color normalBackground = Color(0xFFF4F1F4);
  static const Color darkNormalBackground = Color(0xFF131313);
  static const Color mainTitleBackground = Color(0xFF262a36);
  static const Color darkCardBackground = Color(0xFF1d2021);
  static const Color lightCardBackground = Color(0xFFFFFFFF);
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
  static bigTextSize() => 23.0;

  static lagerTextSize() =>  30.0;

  static normalTextSize() => 18.0;

  static middleTextWhiteSize() =>16.0;

  static smallTextSize() => 14.0;

  static minTextSize() => 12.0;

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
  static const String HOME_AUTHOR_LABEL_ICON_URL = 'https://gank.io/images/8edfa6bca6c643b3ba3f7cec56780377';

  static const IconData home =
      const IconData(0xe6b8, fontFamily: GankIcons.FONT_FAMILY);
  static const IconData homeFill =
      const IconData(0xe6bb, fontFamily: GankIcons.FONT_FAMILY);

  static const IconData news =
      const IconData(0xe7e8, fontFamily: GankIcons.FONT_FAMILY);
  static const IconData newsFill =
      const IconData(0xe7e7, fontFamily: GankIcons.FONT_FAMILY);

  static const IconData search =
      const IconData(0xe647, fontFamily: GankIcons.FONT_FAMILY);
  static const IconData searchFill =
      const IconData(0xe64e, fontFamily: GankIcons.FONT_FAMILY);

  static const IconData girl =
      const IconData(0xe609, fontFamily: GankIcons.FONT_FAMILY);
  static const IconData girlFill =
      const IconData(0xe60f, fontFamily: GankIcons.FONT_FAMILY);

  static const IconData my =
      const IconData(0xe7d5, fontFamily: GankIcons.FONT_FAMILY);
  static const IconData myFill =
      const IconData(0xe7d9, fontFamily: GankIcons.FONT_FAMILY);


}
