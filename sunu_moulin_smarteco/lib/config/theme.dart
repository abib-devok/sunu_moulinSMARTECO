import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Ce fichier définit les thèmes clair et sombre pour l'application.

class AppTheme {
  // Thème clair
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: const Color(0xFF13EC37),
      scaffoldBackgroundColor: const Color(0xFFF6F8F6),
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF13EC37),
        secondary: Color(0xFFE8772E), // Orange pour certains accents
        background: Color(0xFFF6F8F6),
        surface: Colors.white,
        onPrimary: Colors.black,
        onSecondary: Colors.white,
        onBackground: Color(0xFF102213),
        onSurface: Color(0xFF102213),
        error: Color(0xFFE74C3C),
      ),
      textTheme: GoogleFonts.interTextTheme(),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Color(0xFFF6F8F6),
        iconTheme: IconThemeData(color: Color(0xFF102213)),
        titleTextStyle: TextStyle(
          color: Color(0xFF102213),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  // Thème sombre
  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: const Color(0xFF13EC37),
      scaffoldBackgroundColor: const Color(0xFF102213),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF13EC37),
        secondary: Color(0xFFE8772E),
        background: Color(0xFF102213),
        surface: Color(0xFF1A2C1D),
        onPrimary: Colors.black,
        onSecondary: Colors.white,
        onBackground: Colors.white,
        onSurface: Colors.white,
        error: Color(0xFFE74C3C),
      ),
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.dark().textTheme,
      ).apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Color(0xFF102213),
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
