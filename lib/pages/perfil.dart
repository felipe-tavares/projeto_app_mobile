import 'package:flutter/material.dart';

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}
//informações do usuário, como nome, endereço, telefone, foto
//poderão ser alteradas pelo usuário, incluindo alteração de senha
class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu Perfil"),
        actions: <Widget>[],
      ),
    );
  }
}
