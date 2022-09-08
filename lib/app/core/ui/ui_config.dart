import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UiConfig {
  const UiConfig._();

  static String get title => 'Regina Pratas';

  static ThemeData get theme => ThemeData(
        textTheme: GoogleFonts.nunitoTextTheme(),
        primaryColor: const Color(0xFFA8CE4B),
        primaryColorDark: const Color(0xFF689F38),
        primaryColorLight: const Color(0xFFDDE9C7),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFA8CE4B)),
      );
}
