import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zigee_app/common/widgets/custom_snackbar.dart';

void main() {
  testWidgets('CustomSnackbar.show가 호출된다.', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder:
              (context) => Scaffold(
                body: ElevatedButton(
                  onPressed: () {
                    CustomSnackbar.show(
                      context,
                      title: 'Test Snackbar Title',
                      message: 'Test Snackbar Message',
                      duration: const Duration(milliseconds: 100),
                    );
                  },
                  child: const Text('Test Snackbar'),
                ),
              ),
        ),
      ),
    );

    await tester.tap(find.text('Test Snackbar'));
    await tester.pumpAndSettle();
  });
}
