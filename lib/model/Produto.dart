class Produto{
  String _nome;
  String _imagem;
  String _marca;
  String _preco;
  String _mercado;
  String _volume;
  num _quantidade;

  Produto(this._nome, this._imagem, this._marca, this._preco, this._mercado,
      this._volume, this._quantidade);

  num get quantidade => _quantidade;

  set quantidade(num value) {
    _quantidade = value;
  }

  String get mercado => _mercado;

  set mercado(String value) {
    _mercado = value;
  }

  String get preco => _preco;

  set preco(String value) {
    _preco = value;
  }

  String get marca => _marca;

  set marca(String value) {
    _marca = value;
  }

  String get imagem => _imagem;

  set imagem(String value) {
    _imagem = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get volume => _volume;

  set volume(String value) {
    _volume = value;
  }
}

