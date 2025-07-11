import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zigee_app/common/widgets/custom_switch.dart';

void main() {
  testWidgets('CustomSwitch가 렌더링되고, onChanged가 호출된다.', (tester) async {
    final switched = ValueNotifier(false);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ValueListenableBuilder<bool>(
            valueListenable: switched,
            builder: (context, value, child) {
              return CustomSwitch(
                value: value,
                onChanged: (val) => switched.value = val,
                label: 'Test CustomSwitch',
              );
            },
          ),
        ),
      ),
    );

    expect(find.text('Test CustomSwitch'), findsOneWidget);
    await tester.tap(find.byType(Switch));
    await tester.pump();

    expect(switched.value, isTrue);
  });
}
