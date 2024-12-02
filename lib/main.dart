
import 'package:appcalculoimc/imc_page.dart';
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
      home: const OpeningPage(),
    );
  }
}

class OpeningPage extends StatefulWidget {
  const OpeningPage({super.key});

  @override
  State<OpeningPage> createState() => _OpeningPageState();
}

class _OpeningPageState extends State<OpeningPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controleAnimacao;
  late Animation<double> _animacao;

  @override
  void initState() {
    super.initState();
    _controleAnimacao = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      reverseDuration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animacao = Tween<double>(begin: 0, end: 20).animate(
        CurvedAnimation(parent: _controleAnimacao, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controleAnimacao.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('lib/images/principal.jpg'),
                fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: AlignmentDirectional(0, 0.2),
              width: double.infinity,
              height: 190,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 157, 240, 159),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )),
              child: Text("CALCULADORA IMC",
                  style: GoogleFonts.bagelFatOne().copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  )),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 180, 228, 240),
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(1), // Cor da sombra com opacidade
                      offset: const Offset(4,
                          4), // Deslocamento da sombra (horizontal, vertical)
                      blurRadius: 10, // Raio de desfoque da sombra
                      spreadRadius: 2, // Raio de espalhamento da sombra
                    ),
                  ]),
              child: const Text(
                "O IMC (indice de massa corporal é importante para avaliar os riscos de obesidade e desnutrição. Descubra a importância desse protocolo na avaliação física. Manter o peso adequado é fundamental para garantir uma boa qualidade de vida.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w900,
                    fontSize: 16),
              ),
            ),
            const SizedBox(height: 30),
            AnimatedBuilder(
              animation: _controleAnimacao,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _animacao.value),
                  child: child,
                );
              },
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ImcPage()));
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 105),
                  width: double.infinity,
                  child: const Text(
                    "Clique aqui!",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
