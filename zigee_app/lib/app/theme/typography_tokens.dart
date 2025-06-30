import 'package:flutter/material.dart';

class TypographyTokens {
  TypographyTokens._();

  /// 1. Font Family
  static const String fontFamily = 'Pretendard';

  /// 2. Font Weights
  static const FontWeight thin = FontWeight.w100; // Pretendard-Thin
  static const FontWeight extraLight = FontWeight.w200; // Pretendard-ExtraLight
  static const FontWeight light = FontWeight.w300; // Pretendard-Light
  static const FontWeight regular = FontWeight.w400; // Pretendard-Regular (기본)
  static const FontWeight medium = FontWeight.w500; // Pretendard-Medium
  static const FontWeight semiBold = FontWeight.w600; // Pretendard-SemiBold
  static const FontWeight bold = FontWeight.w700; // Pretendard-Bold
  static const FontWeight extraBold = FontWeight.w800; // Pretendard-ExtraBold
  static const FontWeight black = FontWeight.w900; // Pretendard-Black

  /// 3. Font Sizes
  /// (1) Display
  static const double displayLarge = 57.0; // 메인 랜딩 제목
  static const double displayMedium = 45.0; // 섹션 대제목
  static const double displaySmall = 36.0; // 페이지 제목

  /// (2) Headline
  static const double headlineLarge = 32.0; // 주요 제목
  static const double headlineMedium = 28.0; // 섹션 제목
  static const double headlineSmall = 24.0; // 소제목

  /// (3) Title
  static const double titleLarge = 22.0; // 카드 제목, 모달 제목
  static const double titleMedium = 16.0; // 리스트 아이템 제목
  static const double titleSmall = 14.0; // 작은 제목

  /// (4) Body
  static const double bodyLarge = 16.0; // 메인 본문
  static const double bodyMedium = 14.0; // 일반 본문
  static const double bodySmall = 12.0; // 작은 본문

  /// (5) Label
  static const double labelLarge = 14.0; // 버튼 텍스트
  static const double labelMedium = 12.0; // 폼 라벨
  static const double labelSmall = 11.0; // 캡션, 힌트

  /// (6) etc
  static const double caption = 10.0; // 캡션

  /// 4. Line Heights
  static const double lineHeightTight = 1.25; // 제목용
  static const double lineHeightNormal = 1.5; // 본문용 (기본)
  static const double lineHeightLoose = 1.7; // 긴 글용

  /// 5. Letter Spacings
  static const double letterSpacingNone = 0.0; // 기본
  static const double letterSpacingTight = -0.25; // 빽빽한 제목용
  static const double letterSpacingWide = 0.25; // 영문 제목용
  static const double letterSpacingVeryWide = 1.25; // 오버라인용
}
