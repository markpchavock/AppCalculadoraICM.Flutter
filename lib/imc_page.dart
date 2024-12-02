import 'package:appcalculoimc/model/imc.dart';
import 'package:appcalculoimc/shared/widgets/text_label.dart';
import 'package:flutter/material.dart';
import 'repositories/calc_imc_repository.dart';

class ImcPage extends StatefulWidget {
  const ImcPage({super.key});

  @override
  State<ImcPage> createState() => _TarefaPageState();
}

class _TarefaPageState extends State<ImcPage> {
  var _calculosIMC = <Imc>[];
  var imcRepository = ImcRepository();
  var nomeController = TextEditingController();
  var pesoController = TextEditingController();
  var alturaController = TextEditingController();
  var resultadoCalculo = "";

  @override
  void initState() {
    super.initState();
    obterTarefas();
  }

  void obterTarefas() async {
    _calculosIMC = await imcRepository.listar();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 157, 240, 159),
          title: Text(
            "Indice de Massa Corporal",
          ),
        ),
        floatingActionButton: Transform.translate(
          offset: Offset(0, -20),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: FloatingActionButton(
                onPressed: () {
                  nomeController.text = "";
                  pesoController.text = "";
                  alturaController.text = "";
                  showDialog(
                      context: context,
                      builder: (BuildContext bc) {
                        return AlertDialog(
                          title: Text(
                            "Adicionar Calculo IMC",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w900),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              TextLabel(texto: "Nome:"),
                              TextField(controller: nomeController),
                              SizedBox(
                                height: 20,
                              ),
                              TextLabel(texto: "Peso(kg):"),
                              TextField(
                                controller: pesoController,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextLabel(texto: "Altura(m):"),
                              TextField(
                                controller: alturaController,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Cancelar",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w900),
                                )),
                            TextButton(
                                onPressed: () async {
                                  String? pesoSTR;
                                  pesoSTR = pesoController.text;
                                  double? pesoDBL = double.tryParse(pesoSTR);
                                  String? alturaSTR;
                                  alturaSTR = alturaController.text;
                                  double? alturaDBL =
                                      double.tryParse(alturaSTR);
                                  resultadoCalculo = imcRepository.calculoIMC(
                                      pesoDBL!, alturaDBL!)!;
                                  await imcRepository.adicionar(Imc(
                                      nomeController.text, alturaDBL, pesoDBL));
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                  Divider();
                                  setState(() {});
                                },
                                child: const Text("Salvar",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w900)))
                          ],
                        );
                      });
                },
                child: const Icon(Icons.add)),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('lib/images/page2.jpg'),
                  fit: BoxFit.cover)),
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: _calculosIMC.length,
                    itemBuilder: (BuildContext bc, int index) {
                      var imc = _calculosIMC[index];
                      return Dismissible(
                        onDismissed: (DismissDirection dismissDirection) async {
                          await imcRepository.remover(imc.id);
                          obterTarefas();
                        },
                        key: Key(imc.id),
                        child: Card(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          elevation: 8,
                          surfaceTintColor:
                              const Color.fromARGB(255, 252, 251, 251),
                          child: ListTile(
                            title: Text(imc.nome),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Altura: ${alturaController.text} m"),
                                Text("Peso: ${pesoController.text} Kgs"),
                                Text(resultadoCalculo.toString())
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
