/// App-wide spacing constants following a 4px grid system.
///
/// This provides consistent spacing throughout the app and makes it easy
/// to maintain visual rhythm and hierarchy.
class AppSpacing {
  // Base spacing unit (4px)
  static const double _unit = 4.0;

  // Spacing scale
  static const double xs = _unit; // 4px
  static const double sm = _unit * 2; // 8px
  static const double md = _unit * 4; // 16px
  static const double lg = _unit * 6; // 24px
  static const double xl = _unit * 8; // 32px
  static const double xxl = _unit * 12; // 48px
  static const double xxxl = _unit * 16; // 64px

  // Semantic spacing for common use cases
  static const double buttonPaddingVertical = md; // 16px
  static const double buttonPaddingHorizontal = lg; // 24px
  static const double cardPadding = md; // 16px
  static const double screenPaddingHorizontal = lg; // 24px
  static const double screenPaddingVertical = md; // 16px
  static const double sectionSpacing = xl; // 32px
  static const double itemSpacing = md; // 16px
  static const double tinySpacing = xs; // 4px
  static const double smallSpacing = sm; // 8px

  // Border radius constants
  static const double radiusSmall = sm; // 8px
  static const double radiusMedium = sm + xs; // 12px
  static const double radiusLarge = md; // 16px
  static const double radiusCircular = 9999.0; // Fully circular

  // Component-specific spacing
  static const double listItemPadding = md; // 16px
  static const double dialogPadding = lg; // 24px
  static const double chipSpacing = sm; // 8px
  static const double iconTextGap = sm; // 8px

  // Touch targets (minimum recommended size)
  static const double minTouchTarget = 44.0;

  // Prevent instantiation
  AppSpacing._();
}
