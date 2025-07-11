import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zigee_app/common/widgets/custom_text_field.dart';

void main() {
  testWidgets('CustomTextField가 렌더링되고, onChanged가 호출된다.', (tester) async {
    String value = '';

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomTextField(
            labelText: 'Test CustomTextField Label Text',
            onChanged: (val) => value = val,
          ),
        ),
      ),
    );
    expect(find.text('Test CustomTextField Label Text'), findsOneWidget);

    await tester.enterText(find.byType(CustomTextField), 'hello');
    expect(value, 'hello');
  });
}
