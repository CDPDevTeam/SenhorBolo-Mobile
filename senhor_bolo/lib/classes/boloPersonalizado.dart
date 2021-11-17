class BoloPersonalizado{
  String _massa;
  String? _recheio;
  String? _cobertura;
  String? _confeito;


  BoloPersonalizado(this._massa, this._recheio,
      this._cobertura, this._confeito);

  set massa(String value) {
    _massa = value;
  }

  set recheio(String value) {
    _recheio = value;
  }

  set cobertura(String value) {
    _cobertura = value;
  }

  set confeito(String value) {
    _confeito = value;
  }
}