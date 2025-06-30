class SpacingTokens {
  SpacingTokens._();

  /// 1. 기본 간격
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 40.0;
  static const double xxxl = 48.0;
  static const double huge = 64.0;

  /// 2. 컴포넌트 내부 간격
  /// (1) Button
  static const double buttonHorizontal = 24.0; // 버튼 내부 가로 여백
  static const double buttonVertical = 16.0; // 버튼 내부 가로 여백

  static const double componentXs = 4.0; // 버튼 내부 여백
  static const double componentSm = 8.0; // 카드 내부 여백
  static const double componentMd = 16.0; // 모달 내부 여백
  static const double componentLg = 24.0; // 페이지 내부 여백

  /// 3. 레이아웃 간격
  static const double layoutXs = 8.0; // 인접 요소 간격
  static const double layoutSm = 16.0; // 섹션 내 요소 간격
  static const double layoutMd = 24.0; // 섹션 간 간격
  static const double layoutLg = 32.0; // 큰 섹션 간격
  static const double layoutXl = 48.0; // 페이지 섹션 간격

  /// 4. 화면 마진
  static const double screenXs = 16.0; // 모바일 기본 여백
  static const double screenSm = 20.0; // 모바일 큰 여백
  static const double screenMd = 24.0; // 태블릿 여백
  static const double screenLg = 32.0; // 데스크톱 여백

  /// 5. 리스트 아이템 간격
  static const double listItemVertical = 12.0;
  static const double listItemHorizontal = 16.0;
  static const double listSectionGap = 24.0;
}
