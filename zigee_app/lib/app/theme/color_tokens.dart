import 'package:flutter/material.dart';

class ColorTokens {
  ColorTokens._();

  /// 1. 기본 색상
  static const Color gray50 = Color(0xFFFAFAFA);
  static const Color gray100 = Color(0xFFF7F6F3);
  static const Color gray200 = Color(0xFFEBEAE7);
  static const Color gray300 = Color(0xFFE0DEDB);
  static const Color gray400 = Color(0xFFCDCBC7);
  static const Color gray500 = Color(0xFF9B9A97);
  static const Color gray600 = Color(0xFF787774);
  static const Color gray700 = Color(0xFF5A5856);
  static const Color gray800 = Color(0xFF454441);
  static const Color gray900 = Color(0xFF37352F);

  /// 2. Pure White / Black
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  /// 3. Semantic Status
  static const Color red = Color(0xFFEB5757); // 에러, 삭제
  static const Color orange = Color(0xFFF2994A); // 경고
  static const Color yellow = Color(0xFFF2C94C); // 주의
  static const Color green = Color(0xFF27AE60); // 성공
  static const Color blue = Color(0xFF2F80ED); // 정보, 링크

  /// 4. Background
  static const Color backgroundPrimary = white; // 메인 배경
  static const Color backgroundSecondary = gray50; // 카드, 섹션 배경
  static const Color backgroundTertiary = gray100; // 입력 필드 배경
  static const Color backgroundElevated = white; // 모달, 드롭다운 배경

  /// 5. UI State Backgrounds
  static const Color backgroundHover = gray100; // 호버 상태
  static const Color backgroundPressed = gray200; // 눌린 상태
  static const Color backgroundSelected = gray200; // 선택 상태
  static const Color backgroundFocused = gray100; // 포커스 상태

  /// 6. Text
  static const Color textPrimary = gray900; // 제목·중요 텍스트
  static const Color textSecondary = gray700; // 본문 텍스트
  static const Color textTertiary = gray500; // 보조 텍스트
  static const Color textPlaceholder = gray400; // Placeholder 텍스트
  static const Color textDisabled = gray300; // 비활성 텍스트
  static const Color textOnDark = white; // 다크 배경 위 텍스트

  /// 7. Border
  static const Color borderPrimary = gray200; // 기본 테두리
  static const Color borderSecondary = gray300; // 강조 테두리
  static const Color borderFocus = gray800; // 포커스 테두리
  static const Color borderError = red; // 에러 테두리
  static const Color borderSuccess = green; // 성공 테두리

  /// 8. Button
  static const Color buttonPrimary = gray900; // 주요 버튼
  static const Color buttonSecondary = gray600; // 보조 버튼
  static const Color buttonPressed = gray700; // 버튼 눌렸을 때
  static const Color buttonDisabled = gray400; // 버튼 비활성화
  static Color buttonOverlayOpacity = white.withAlpha(25); // 버튼 비활성화

  /// 9. Links
  static const Color linkPrimary = blue; // 기본 링크
  static const Color linkHover = Color(0xFF1565C0); // 링크 호버
  static const Color linkVisited = Color(0xFF7B1FA2); // 방문 링크

  /// 10. Status
  static const Color statusError = red;
  static const Color statusWarning = orange;
  static const Color statusSuccess = green;
  static const Color statusInfo = blue;
}
