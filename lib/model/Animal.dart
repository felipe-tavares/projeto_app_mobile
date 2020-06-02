class Animal{

    String _nome;
    String _idade;
    String _raca;
    String _foto;

    Animal(this._nome, this._idade, this._raca, this._foto);

    String get nome => _nome;

    set nome(String value) {
      _nome = value;
    }

    String get idade => _idade;

    set idade(String value) {
      _idade = value;
    }

    String get foto => _foto;

    set foto(String value) {
      _foto = value;
    }

    String get raca => _raca;

    set raca(String value) {
      _raca = value;
    }




}