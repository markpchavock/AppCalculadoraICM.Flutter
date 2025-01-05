import 'package:appcalculoimc/repositories/sqflite/sqflite_database.dart';

import '../../model/imc_sqflite_model.dart';

class ImcSQLiteRepository {
  Future<List<ImcSqfliteModel>> obterDados() async {
    // ignore: non_constant_identifier_names
    List<ImcSqfliteModel> lista_imcs = [];

    var db = await SQFLiteDataBase().obterDataBase();
    var result =
        await db.rawQuery('SELECT id, nome, altura, peso, imc FROM imcscript');

    for (var element in result) {
      lista_imcs.add(ImcSqfliteModel(
        (int.tryParse(element["id"]?.toString() ?? '0') ?? 0),
        element["nome"]?.toString() ?? '',
        double.tryParse(element["altura"]?.toString() ?? '0') ?? 0.0,
        double.tryParse(element["peso"]?.toString() ?? '0') ?? 0.0,
      ));
    }
    return lista_imcs;
  }

  Future<void> salvar(ImcSqfliteModel imcSqfliteModel) async {
    var db = await SQFLiteDataBase().obterDataBase();
    double imc = imcSqfliteModel.peso /
        (imcSqfliteModel.altura * imcSqfliteModel.altura);
    String? resultadoDiagnostico =
        calculoIMC(imcSqfliteModel.peso, imcSqfliteModel.altura);
    await db.rawInsert(
        'INSERT INTO imcscript (nome, altura, peso, imc, resultado) values(?,?,?,?,?)',
        [
          imcSqfliteModel.nome,
          imcSqfliteModel.altura,
          imcSqfliteModel.peso,
          imc,
          resultadoDiagnostico
        ]);
  }

  Future<void> atualizar(ImcSqfliteModel imcSqfliteModel) async {
    var db = await SQFLiteDataBase().obterDataBase();
    await db.rawInsert(
        'UPDATE imcscript SET nome = ?, altura = ?, peso = ? WHERE id = ? ', [
      imcSqfliteModel.nome,
      imcSqfliteModel.altura,
      imcSqfliteModel.peso,
      imcSqfliteModel.id
    ]);
  }

  Future<void> remover(int id) async {
    var db = await SQFLiteDataBase().obterDataBase();
    await db.rawInsert('DELETE FROM imcscript  WHERE id = ? ', [id]);
  }

  String? calculoIMC(double peso, double altura) {
    double imc = peso / (altura * altura);
    String imcStr = imc.toStringAsFixed(2);
    String resultado = "";

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
