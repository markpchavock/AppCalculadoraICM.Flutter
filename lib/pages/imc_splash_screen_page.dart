import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:appcalculoimc/pages/opening_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 127, 221, 119),
            Color.fromARGB(255, 122, 194, 115)
          ],
        )),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.calculator, size: 50),
              AnimatedTextKit(
                onFinished: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => OpeningPage()));
                },
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Calculadora IMC',
                    textStyle: GoogleFonts.bagelFatOne().copyWith(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w900,
                    ),
                    speed: const Duration(milliseconds: 80),
                  ),
                ],
                totalRepeatCount: 1,
                pause: const Duration(milliseconds: 200),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
