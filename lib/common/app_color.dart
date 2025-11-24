import 'package:flutter/material.dart';

/// ملف يحتوي على جميع ألوان التطبيق المستخدمة
/// App Colors File - Contains all application colors
class AppColor {
  AppColor._(); // Private constructor to prevent instantiation

  // ==================== Primary Colors ====================
  /// اللون الأساسي للتطبيق
  /// Primary color of the application
  static const Color primary = Color(0xFF0046FF);

  /// اللون الثانوي للتطبيق
  /// Secondary color of the application
  static const Color secondary = Color(0xFF0046FF);

  /// لون التمييز
  /// Accent color
  static const Color accent = Color(0xFF0046FF);

  // ==================== Background Colors ====================
  /// لون خلفية الواجهة في الوضع الفاتح
  /// Scaffold background color in light mode
  static const Color scaffoldBackgroundLight = Colors.white;

  /// لون خلفية الواجهة في الوضع الداكن
  /// Scaffold background color in dark mode
  static const Color scaffoldBackgroundDark = Color(0xFF2C2C2C);

  /// لون الخلفية الأساسي في الوضع الداكن
  /// Primary background color in dark mode
  static const Color primaryBackgroundDark = Color(0xFF252525);

  /// لون خلفية شريط التنقل السفلي
  /// Bottom navigation bar background color
  static const Color bottomNavBackground = Color(0xFFE2E7F2);

  /// لون خلفية شفاف
  /// Transparent background
  static const Color transparent = Colors.transparent;

  // ==================== Text Colors ====================
  /// لون النص الأساسي
  /// Primary text color
  static const Color textPrimary = Color(0xFF0046FF);

  /// لون النص الثانوي
  /// Secondary text color
  static const Color textSecondary = Color(0xFF0046FF);

  /// لون النص التوضيحي
  /// Hint text color
  static const Color textHint = Color(0xFF0046FF);

  /// لون النص في الوضع الداكن
  /// Text color in dark mode
  static const Color textDark = Color(0xFF2C2C2C);

  /// لون النص الأبيض
  /// White text color
  static const Color textWhite = Colors.white;

  /// لون النص الأسود
  /// Black text color
  static const Color textBlack = Colors.black87;

  // ==================== Status Colors ====================
  /// لون النجاح
  /// Success color
  static const Color success = Colors.green;

  /// لون النجاح مع شفافية
  /// Success color with opacity
  static Color successWithOpacity([double opacity = 0.2]) =>
      Colors.green.withOpacity(opacity);

  /// لون الخطأ
  /// Error color
  static const Color error = Colors.redAccent;

  /// لون التحذير
  /// Warning color
  static const Color warning = Colors.orange;

  /// لون المعلومات
  /// Info color
  static const Color info = Colors.blue;

  // ==================== Star Rating Colors ====================
  /// لون النجوم
  /// Star rating color
  static const Color star = Color(0xFFFFB24D);

  /// لون النجوم الفارغة
  /// Empty star color
  static const Color starEmpty = Color(0xFFFFB24D);

  // ==================== Neutral Colors ====================
  /// لون رمادي
  /// Grey color
  static const Color grey = Colors.grey;

  /// لون رمادي مع شفافية
  /// Grey color with opacity
  static Color greyWithOpacity([double opacity = 0.1]) =>
      Colors.grey.withOpacity(opacity);

  /// لون رمادي فاتح
  /// Light grey color
  static Color greyLight = Colors.grey[200]!;

  /// لون رمادي فاتح مع شفافية
  /// Light grey color with opacity
  static Color greyLightWithOpacity([double opacity = 0.1]) =>
      Colors.grey[200]!.withOpacity(opacity);

  /// لون رمادي متوسط
  /// Medium grey color
  static Color greyMedium = Colors.grey.withOpacity(0.6);

  /// لون رمادي متوسط مع شفافية
  /// Medium grey color with opacity
  static Color greyMediumWithOpacity([double opacity = 0.2]) =>
      Colors.grey.withOpacity(opacity);

  /// لون رمادي داكن
  /// Dark grey color
  static Color greyDark = Colors.grey.withOpacity(0.15);

  /// لون أبيض
  /// White color
  static const Color white = Colors.white;

  /// لون أبيض مع شفافية
  /// White color with opacity
  static Color whiteWithOpacity([double opacity = 0.24]) =>
      Colors.white.withOpacity(opacity);

  /// لون أسود
  /// Black color
  static const Color black = Colors.black;

  /// لون افتراضي عند فشل التحويل
  /// Default fallback color
  static const Color defaultColor = Color(0xFFCCCCCC);

  // ==================== UI Element Colors ====================
  /// لون التركيز
  /// Focus color
  static const Color focus = Color(0xFF0046FF);

  /// لون التركيز مع شفافية
  /// Focus color with opacity
  static Color focusWithOpacity([double opacity = 0.1]) =>
      const Color(0xFF0046FF).withOpacity(opacity);

  /// لون الفاصل
  /// Divider color
  static Color divider = const Color(0xFF0046FF).withOpacity(0.1);

  /// لون الحدود
  /// Border color
  static Color border = const Color(0xFF0046FF).withOpacity(0.05);

  /// لون الظل
  /// Shadow color
  static Color shadow = const Color(0xFF0046FF).withOpacity(0.1);

  // ==================== Bottom Navigation Colors ====================
  /// لون شريط التنقل السفلي الأساسي
  /// Primary bottom navigation color
  static const Color bottomNavPrimary = Colors.blueAccent;

  // ==================== Helper Methods ====================
  /// تحويل hex string إلى Color
  /// Convert hex string to Color
  static Color parseColor(String? hexCode, {double? opacity}) {
    try {
      return Color(int.tryParse(hexCode!.replaceAll("#", "0xFF")) ?? 0)
          .withOpacity(opacity ?? 1);
    } catch (e) {
      return defaultColor.withOpacity(opacity ?? 1);
    }
  }

  /// الحصول على لون من Theme
  /// Get color from Theme
  static Color getPrimaryColor(BuildContext context) {
    return Theme.of(context).primaryColor;
  }

  static Color getSecondaryColor(BuildContext context) {
    return Theme.of(context).colorScheme.secondary;
  }

  static Color getHintColor(BuildContext context) {
    return Theme.of(context).hintColor;
  }

  static Color getFocusColor(BuildContext context) {
    return Theme.of(context).focusColor;
  }

  static Color getScaffoldBackgroundColor(BuildContext context) {
    return Theme.of(context).scaffoldBackgroundColor;
  }
}
