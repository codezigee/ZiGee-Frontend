class SpacingTokens {
  SpacingTokens._();

  /// 1. 기본 spacing scale (8pt grid 기반)
  static const double none = 0.0;
  static const double space4 = 4.0;
  static const double space8 = 8.0;
  static const double space16 = 16.0;
  static const double space24 = 24.0;
  static const double space32 = 32.0;
  static const double space40 = 40.0;
  static const double space48 = 48.0;
  static const double space56 = 56.0;
  static const double space64 = 64.0;
  static const double space72 = 72.0;
  static const double space80 = 80.0;

  static const double xs = space4;
  static const double sm = space8;
  static const double md = space16;
  static const double lg = space24;
  static const double xl = space32;

  /// 2. 컨텍스트별 spacing scale
  static const double screenPadding = md; // 화면 기본 여백 (16px)
  static const double cardPadding = lg; // 카드 내부 여백 (24px)
  static const double itemGap = sm; // 리스트 아이템 간격 (8px)
  static const double sectionGap = xl; // 섹션 간격 (32px)

  static const double buttonVerticalPadding = space16; // 버튼 내부 세로 여백 (16px)
  static const double buttonHorizontalPadding = space24; // 버튼 내부  가로 여백 (24px)

  static const double bookingCardVerticalPadding =
      space8; // 예약 회의실 카드 내부 가로 여백 (8px)
  static const double bookingCardHorizontalPadding =
      space16; // 예약 회의실 카드 내부 가로 여백 (16px)
}
