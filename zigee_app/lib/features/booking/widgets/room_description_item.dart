import 'package:flutter/cupertino.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/spacing_tokens.dart';
import 'package:zigee_app/app/theme/typography_styles.dart';

class RoomDescriptionItem extends StatelessWidget {
  final IconData icon;
  final String content;

  const RoomDescriptionItem({
    super.key,
    required this.icon,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: ColorTokens.gray600),
        const SizedBox(width: SpacingTokens.xs),
        Text(
          content,
          style: TypographyStyles.bodySmall.copyWith(
            color: ColorTokens.gray600,
          ),
        ),
      ],
    );
  }
}
