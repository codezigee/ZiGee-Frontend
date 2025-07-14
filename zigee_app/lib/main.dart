import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:zigee_app/app/app.dart';
import 'package:zigee_app/app/config/env.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  KakaoSdk.init(
    nativeAppKey: '65649053097626958171b85d2ad5251e',
    javaScriptAppKey: Env.kakaoJavascriptKey,
  );

  initialize();

  runApp(const ZigeeApp());
}

void initialize() async {
  final result = await UserApi.instance.loginWithKakaoAccount();
}
