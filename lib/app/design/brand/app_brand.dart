import 'package:flutter/material.dart';
import 'package:flutter_design_extension/flutter_design_extension.dart';
import 'package:bhagavat_geeta/app/design/color_set.dart';

class AppBrand extends Brand {
  @override
  ColorTokens getColorTokens(bool isDarkMode) {
    return ColorTokens(
      brand: ColorBrand(
        main: AppColorSetLight.primary,
        dark: AppColorSetLight.primary,
        secondary:
            isDarkMode ? const Color(0xFF070A17) : const Color(0xFF070A17),
        background:
            isDarkMode ? const Color(0xFFFFFFFF) : const Color(0xFFFFFFFF),
      ),
      interaction: ColorInteraction(
        main: AppColorSetLight.primary,
        hover: AppColorSetLight.primary.withOpacity(0.5),
        pressed: AppColorSetLight.primary.withOpacity(0.5),
      ),
      neutral: isDarkMode ? ColorNeutralDark() : ColorNeutralLight(),
      messaging: isDarkMode ? ColorMessagingDark() : ColorMessagingLight(),
    );
  }
}
