import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zigee_app/common/widgets/empty_state_notice.dart';

void main() {
  testWidgets('EmptyStateNotice가 렌더링되고, 버튼이 동작한다.', (tester) async {
    bool pressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EmptyStateNotice(
            message: 'Test EmptyStateNotice Message',
            buttonText: 'Test EmptyStateNotice Button Text',
            onButtonPressed: () => pressed = true,
          ),
        ),
      ),
    );

    expect(find.text('Test EmptyStateNotice Message'), findsOneWidget);
    expect(find.text('Test EmptyStateNotice Button Text'), findsOneWidget);

    await tester.tap(find.text('Test EmptyStateNotice Button Text'));
    await tester.pump();
    expect(pressed, isTrue);
  });
}
