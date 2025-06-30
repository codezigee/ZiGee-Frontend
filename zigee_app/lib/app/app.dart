import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zigee_app/app/routes/app_pages.dart';
import 'package:zigee_app/app/routes/app_routes.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';

class ZigeeApp extends StatelessWidget {
  const ZigeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'zigee',
      // initialRoute: AppRoutes.main,
      initialRoute: AppRoutes.initial,
      theme: ThemeData(
        fontFamily: 'Pretendard',
        scaffoldBackgroundColor: ColorTokens.backgroundPrimary,
        primaryColor: ColorTokens.gray900,

        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: ColorTokens.gray900,
          onPrimary: ColorTokens.white,
          secondary: ColorTokens.gray600,
          onSecondary: ColorTokens.white,
          error: ColorTokens.red,
          onError: ColorTokens.white,
          background: ColorTokens.backgroundPrimary,
          onBackground: ColorTokens.textPrimary,
          surface: ColorTokens.backgroundSecondary,
          onSurface: ColorTokens.textPrimary,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: ColorTokens.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: ColorTokens.borderPrimary),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: ColorTokens.borderPrimary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: ColorTokens.borderFocus, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: ColorTokens.borderError),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: ColorTokens.borderSecondary),
          ),
          hintStyle: const TextStyle(color: ColorTokens.textPlaceholder),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: ColorTokens.textPrimary),
          bodyMedium: TextStyle(color: ColorTokens.textSecondary),
          bodySmall: TextStyle(color: ColorTokens.textTertiary),
          labelLarge: TextStyle(color: ColorTokens.textSecondary),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: ColorTokens.backgroundPrimary,
          elevation: 0,
          iconTheme: IconThemeData(color: ColorTokens.gray900),
          titleTextStyle: TextStyle(
            color: ColorTokens.gray900,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        dividerColor: ColorTokens.borderPrimary,
        iconTheme: const IconThemeData(color: ColorTokens.gray700),
        disabledColor: ColorTokens.textDisabled,
        dialogBackgroundColor: ColorTokens.backgroundElevated,
        cardColor: ColorTokens.backgroundSecondary,
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide.none,
          ),
          contentTextStyle: TextStyle(color: Colors.black),
          behavior: SnackBarBehavior.floating,
        ),
      ),
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
    );
  }
}
