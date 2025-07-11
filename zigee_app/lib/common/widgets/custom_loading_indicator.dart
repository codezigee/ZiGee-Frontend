import 'package:flutter/material.dart';
import 'package:zigee_app/app/theme/size_tokens.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final double size;

  const CustomLoadingIndicator({this.size = SizingTokens.iconXl, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
