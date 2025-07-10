import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zigee_app/common/widgets/custom_loading_indicator.dart';

void main() {
  testWidgets('CustomLoadingIndicator가 렌더링된다.', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: CustomLoadingIndicator())),
    );

    expect(find.byType(CustomLoadingIndicator), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
