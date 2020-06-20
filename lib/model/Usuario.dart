class Usuario {
  String _nome;
  String _email;
  String _senha;
  String _endereco;
  String _telefone;
  String _foto;

  Usuario();

  String get senha => _senha;

  set senha(String value) {
    _senha = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get foto => _foto;

  set foto(String value) {
    _foto = value;
  }

  String get telefone => _telefone;

  set telefone(String value) {
    _telefone = value;
  }

  String get endereco => _endereco;

  set endereco(String value) {
    _endereco = value;
  }
}
