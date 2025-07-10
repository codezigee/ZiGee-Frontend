import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:zigee_app/common/widgets/custom_bottom_sheet.dart';

void main() {
  testWidgets('CustomBottomSheet.show가 호출되고, 정상적으로 닫힌다.', (tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        home: Builder(
          builder:
              (context) => Scaffold(
                body: ElevatedButton(
                  onPressed: () {
                    CustomBottomSheet.show(
                      context,
                      body: const Text('Test BottomSheet Body'),
                    );
                  },
                  child: const Text('Test BottomSheet'),
                ),
              ),
        ),
      ),
    );

    await tester.tap(find.text('Test BottomSheet'));
    await tester.pumpAndSettle(); // 바텀시트가 완전히 열린 후

    expect(find.text('Test BottomSheet Body'), findsOneWidget); // 바텀시트가 열렸는지 확인

    await tester.tap(find.byIcon(Icons.close)); // 닫기 버튼을 찾아서 탭
    await tester.pumpAndSettle(); // 닫히는 애니메이션까지 대기

    expect(find.text('Test BottomSheet Body'), findsNothing); // 바텀시트가 닫혔는지 확인
  });
}
