import 'package:flutter/cupertino.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/size_tokens.dart';
import 'package:zigee_app/app/theme/typography_styles.dart';

class CardStyles {
  static BoxDecoration roomCardDecoration(bool isSelected) {
    return BoxDecoration(
      color: ColorTokens.white,
      borderRadius: BorderRadius.circular(SizingTokens.radiusMd),
      border: Border.all(
        color: isSelected ? ColorTokens.borderFocus : ColorTokens.borderPrimary,
      ),
    );
  }
}
