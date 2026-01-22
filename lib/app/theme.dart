import 'package:flutter/material.dart';

class AppTheme{
  AppTheme._();

  static ThemeData get lightTheme => ThemeData(
    fontFamily: 'Inter',
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF42B4CA), // birincil renk
      secondary: Color(0xFFD5E9ED), // ikincil renk
      surface: Colors.white, // arkaplan
      onSurface: Color(0xFF414A4C), // arkaplanin onundeki yazilarin vs rengi
      error: Color(0xFFEA7979), // hata rengi
      tertiary: Color(0xFFB5C4C7), // ucuncul renk
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: Color(0xFF42B4CA)
      )
    ),
  );

}

