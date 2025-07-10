import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zigee_app/common/widgets/custom_checkbox.dart';

void main() {
  testWidgets('CustomCheckbox가 렌더링되고, onChanged가 호출된다.', (tester) async {
    final checked = ValueNotifier(false);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ValueListenableBuilder<bool>(
            valueListenable: checked,

            builder: (context, value, child) {
              return CustomCheckbox(
                value: value,
                onChanged: (val) => checked.value = val ?? false,
                label: 'Test CustomCheckbox',
              );
            },
          ),
        ),
      ),
    );

    expect(find.text('Test CustomCheckbox'), findsOneWidget);

    await tester.tap(find.byType(Checkbox));
    await tester.pump();
    expect(checked.value, isTrue);
  });
}
