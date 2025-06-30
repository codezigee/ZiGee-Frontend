import 'package:flutter/material.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final double size;

  const CustomLoadingIndicator({this.size = 32.0, super.key});

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
