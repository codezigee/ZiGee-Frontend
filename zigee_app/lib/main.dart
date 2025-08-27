import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:zigee_app/app/app.dart';
import 'package:zigee_app/app/config/env.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  KakaoSdk.init(
    nativeAppKey: 'dfa6adb877d20a9dfe8ed06a1769d636',
    javaScriptAppKey: Env.kakaoJavascriptKey,
  );

  runApp(const ZigeeApp());
}
