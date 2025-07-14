import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(varName: 'KAKAO_REST_API_KEY')
  static const String kakaoRestApiKey = _Env.kakaoRestApiKey;
  @EnviedField(varName: 'KAKAO_JAVASCRIPT_KEY')
  static const String kakaoJavascriptKey = _Env.kakaoJavascriptKey;
}
