
class ImcSqfliteModel {
  // ignore: prefer_final_fields
  int _id = 0;
  String _nome = "";
  double _altura = 0;
  double _peso = 0;
  // ignore: unused_field
  final double _imc = 0;

  ImcSqfliteModel(this._id, this._nome, this._altura, this._peso);

  int get id => _id;

  set nome(String nome) {
    _nome = nome;
  }

  // ignore: unnecessary_getters_setters
  String get nome => _nome;

  set altura(double altura) {
    _altura = altura;
  }

  // ignore: unnecessary_getters_setters
  double get altura => _altura;

  set peso(double peso) {
    _peso = peso;
  }

  // ignore: unnecessary_getters_setters
  double get peso => _peso;
}
