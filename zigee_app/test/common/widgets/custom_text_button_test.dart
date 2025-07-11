import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zigee_app/common/widgets/custom_text_button.dart';

void main() {
  testWidgets('label이 보이고, 버튼을 탭하면 onPressed가 호출된다.', (
    WidgetTester tester,
  ) async {
    bool pressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomTextButton.primary(
            label: 'Test CustomTextButton',
            onPressed: () => pressed = true,
          ),
        ),
      ),
    );

    // label이 화면에 보이는지 확인
    expect(find.text('Test CustomTextButton'), findsOneWidget);

    // 버튼을 탭하면 onPressed가 호출되는지 확인
    await tester.tap(find.byType(CustomTextButton));
    await tester.pump();
    expect(pressed, isTrue); // pressed == true여야 테스트는 통과
  });

  testWidgets('onPressed가 null이면 버튼을 탭해도 동작하지 않는다.', (
    WidgetTester tester,
  ) async {
    bool pressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomTextButton.primary(
            label: 'Test CustomTextButton',
            onPressed: null,
          ),
        ),
      ),
    );

    // 버튼을 탭해도 pressed 값이 변하지 않아야 한다
    await tester.tap(find.byType(CustomTextButton));
    await tester.pump();
    expect(pressed, isFalse); // pressed == false여야 테트 통과
  });
}
