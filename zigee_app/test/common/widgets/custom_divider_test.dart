import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zigee_app/common/widgets/custom_divider.dart';

void main() {
  testWidgets('CustomDivider가 렌더링된다.', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: CustomDivider())),
    );

    expect(find.byType(CustomDivider), findsOneWidget);
    expect(find.byType(Divider), findsOneWidget);
  });
}
