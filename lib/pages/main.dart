import 'package:appcalculoimc/pages/imc_page.dart';
import 'package:appcalculoimc/pages/imc_splash_screen_page.dart';
import 'package:appcalculoimc/pages/opening_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.interTextTheme()),
      home: const SplashScreenPage(),
    );
  }
}
