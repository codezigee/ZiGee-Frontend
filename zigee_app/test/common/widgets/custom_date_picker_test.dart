import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zigee_app/common/widgets/custom_date_picker.dart';

void main() {
  testWidgets('CustomDatePicker가 렌더링된다.', (tester) async {
    DateTime? selected;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomDatePicker(
            selectedDate: selected,
            onChanged: (val) => selected = val,
            label: 'Test CustomDatePicker',
          ),
        ),
      ),
    );

    expect(find.text('Test CustomDatePicker'), findsOneWidget);
    expect(find.byType(OutlinedButton), findsOneWidget);
  });
}
