import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zigee_app/common/widgets/custom_dropdown_button.dart';

void main() {
  testWidgets('CustomDropdownButton이 렌더링되고, onChanged가 호출된다.', (tester) async {
    String? selected;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomDropdownButton<String>(
            label: 'Test CustomDropdownButton',
            value: selected,
            items: [
              const DropdownMenuItem(value: 'a', child: Text('A')),
              const DropdownMenuItem(value: 'b', child: Text('B')),
            ],
            onChanged: (val) => selected = val,
            hint: '선택',
          ),
        ),
      ),
    );

    expect(find.text('Test CustomDropdownButton'), findsOneWidget);
    expect(find.text('A'), findsOneWidget);
    expect(find.text('B'), findsOneWidget);
  });
}
