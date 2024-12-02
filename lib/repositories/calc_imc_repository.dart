import '../../model/imc.dart';

class ImcRepository {
  String resultado = "";
  final List<Imc> _imcs = [];

  Future<void> adicionar(Imc imc) async {
    await Future.delayed(Duration(milliseconds: 100));
    _imcs.add(imc);
  }


  Future<List<Imc>> listar() async {
    await Future.delayed(Duration(milliseconds: 100));
    return _imcs;
  }



  Future<void> remover(String id) async {
    await Future.delayed(Duration(milliseconds: 100));
    _imcs.remove(_imcs.where((imc) => imc.id == id).first);
  }

  String? calculoIMC(double peso, double altura) {
    double imc = peso / (altura * altura);
    String imcStr = imc.toStringAsFixed(2);

    if (imc < 16) {
      resultado = "Calculo IMC: $imcStr \nDiagnóstico: Magreza Grave";
    } else if (imc >= 16 && imc < 17) {
      resultado = "Calculo IMC: $imcStr \nDiagnóstico: Magreza Moderada";
    } else if (imc >= 17 && imc < 18.5) {
      resultado = "Calculo IMC: $imcStr \nDiagnóstico: Magreza leve";
    } else if (imc >= 18.5 && imc < 25) {
      resultado = "Calculo IMC: $imcStr \nDiagnóstico: Saudável";
    } else if (imc >= 25 && imc < 30) {
      resultado = "Calculo IMC: $imcStr \nDiagnóstico: Sobrepeso";
    } else if (imc >= 30 && imc < 35) {
      resultado = "Calculo IMC: $imcStr \nDiagnóstico: Obesidade Grau 1";
    } else if (imc >= 35 && imc < 40) {
      resultado =
          "Calculo IMC: $imcStr \nDiagnóstico: Obesidade Grau 2 - Severa";
      return resultado;
    } else if (imc >= 40) {
      resultado =
          "Calculo IMC: $imcStr\nDiagnóstico: Obesidade Grau 3 - Mórbida!";
    }
    return resultado;
  }
}
