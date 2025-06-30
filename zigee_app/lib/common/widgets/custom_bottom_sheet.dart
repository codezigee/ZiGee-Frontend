import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/size_tokens.dart';
import 'package:zigee_app/app/theme/spacing_tokens.dart';
import 'package:zigee_app/app/theme/typography_styles.dart';

class CustomBottomSheet {
  static void show(BuildContext context, {required Widget body}) {
    Get.bottomSheet(
      BottomSheet(
        onClosing: () => Navigator.of(context).pop(),
        builder: (context) {
          return Container(
            decoration: const BoxDecoration(
              color: ColorTokens.backgroundSecondary,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(SizingTokens.radiusXxl),
              ),
            ),
            padding: const EdgeInsets.all(SpacingTokens.sm),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  body,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
