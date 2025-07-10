import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zigee_app/common/widgets/custom_dialog.dart';

void main() {
  testWidgets('CustomDialog가 렌더링되고, 버튼이 동작한다.', (tester) async {
    bool confirmed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder:
              (context) => Scaffold(
                body: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder:
                          (_) => CustomDialog(
                            title: 'Test Title',
                            content: 'Test Content',
                            onConfirm: () => confirmed = true,
                          ),
                    );
                  },
                  child: const Text('Test CustomDialog'),
                ),
              ),
        ),
      ),
    );

    await tester.tap(find.text('Test CustomDialog'));
    await tester.pumpAndSettle();
    expect(find.text('Test Title'), findsOneWidget);
    expect(find.text('Test Content'), findsOneWidget);
  });
}
