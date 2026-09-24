import 'package:flutter/material.dart';

/// Buddy System — الألوان والثيم الموحَّد
/// 
/// - البرتقالي: هوية سوناطراك (الطاقة، الثقة)
/// - الأخضر: الراحة النفسية (الهدوء، الشفاء)
class AppColors {
  // 🟠 برتقالي سوناطراك
  static const Color primaryOrange = Color(0xFFF58220);
  static const Color primaryOrangeLight = Color(0xFFFFA94D);
  static const Color primaryOrangeDark = Color(0xFFD96A0A);

  // 🟢 أخضر الراحة النفسية
  static const Color sageGreen = Color(0xFF5FA974);
  static const Color sageGreenLight = Color(0xFF8FC9A0);
  static const Color sageGreenDark = Color(0xFF3E7D52);

  // 🎨 الخلفيات
  static const Color darkBg = Color(0xFF0A1F2E);
  static const Color darkCard = Color(0xFF15293D);
  static const Color lightBg = Color(0xFFF7F4EE);
  static const Color lightCard = Color(0xFFFFFFFF);

  // 📝 النصوص
  static const Color inkDark = Color(0xFF1A2733);
  static const Color inkSoft = Color(0xFF5B6570);
  static const Color inkLight = Color(0xFFB0BEC5);

  // 🚦 حالات
  static const Color dangerRed = Color(0xFFC0392B);
  static const Color warningYellow = Color(0xFFF39C12);
  static const Color successGreen = Color(0xFF27AE60);

  // 🎨 ألوان BPRS
  static const Color bprsGreen = Color(0xFF5FA974);
  static const Color bprsYellow = Color(0xFFF39C12);
  static const Color bprsOrange = Color(0xFFF58220);
  static const Color bprsRed = Color(0xFFC0392B);
}

class AppTheme {
  static ThemeData get dark => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBg,
    primaryColor: AppColors.primaryOrange,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryOrange,
      secondary: AppColors.sageGreen,
      surface: AppColors.darkCard,
      error: AppColors.dangerRed,
    ),
    fontFamily: 'Tajawal',
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBg,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkCard,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.inkLight.withOpacity(0.2)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.inkLight.withOpacity(0.2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryOrange, width: 2),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryOrange,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
