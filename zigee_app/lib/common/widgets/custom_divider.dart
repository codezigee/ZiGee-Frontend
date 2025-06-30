import 'package:flutter/material.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/spacing_tokens.dart';

class CustomDivider extends StatelessWidget {
  final Axis direction;
  final double thickness; // 굵기
  final double length; // 공간의 크기
  final double indent; // Divider의 시작 부분 내부 여백
  final double endIndent; // 끝 부분 내부 여백
  final Color color;

  const CustomDivider({
    this.direction = Axis.horizontal,
    this.thickness = 1.0,
    this.length = 0.0,
    this.indent = 0.0,
    this.endIndent = 0.0,
    this.color = ColorTokens.borderPrimary,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (direction == Axis.horizontal) {
      return Divider(
        thickness: thickness,
        indent: indent,
        endIndent: endIndent,
        color: color,
        height: SpacingTokens.sm,
      );
    } else {
      return VerticalDivider(
        thickness: thickness,
        width: length > 0 ? length : null,
        indent: indent,
        endIndent: endIndent,
        color: color,
      );
    }
  }
}
