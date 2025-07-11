import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zigee_app/common/widgets/error_state_notice.dart';

void main() {
  testWidgets('ErrorStateNotice가 렌더링되고, 버튼이 동작한다.', (tester) async {
    bool retried = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ErrorStateNotice(
            message: 'Test ErrorStateNotice Message',
            buttonText: 'Test ErrorStateNotice Button Text',
            onRetry: () => retried = true,
          ),
        ),
      ),
    );

    expect(find.text('Test ErrorStateNotice Message'), findsOneWidget);
    expect(find.text('Test ErrorStateNotice Button Text'), findsOneWidget);

    await tester.tap(find.text('Test ErrorStateNotice Button Text'));
    await tester.pump();
    expect(retried, isTrue);
  });
}
