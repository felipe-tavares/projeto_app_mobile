import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../pages/home.dart';

class Cadastro extends StatelessWidget {

  TextEditingController _nomeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 70, left: 70, right: 70),
                child:
                Image.asset("assets/images/logo.png"
              ),
            ),

            Padding(
                padding: EdgeInsets.only(top: 40, left: 30, right: 30),
                child: TextField(
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(50.0),
                      ),
                    ),
                    contentPadding:
                      new EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                      filled: true,
                      fillColor: Colors.white,
                      alignLabelWithHint: true,
                      hintText: 'Nome Completo',
                  ),
                  keyboardType: TextInputType.text,
                ),
            ),

            Padding(
                padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                child: TextField(
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(50.0),
                      ),
                    ),
                    contentPadding:
                    new EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                    filled: true,
                    fillColor: Colors.white,
                    alignLabelWithHint: true,
                    hintText: 'E-mail',
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
            ),

            Padding(
                padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue, width: 0.0),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(50.0),
                      ),
                    ),
                    contentPadding:
                    new EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                    filled: true,
                    fillColor: Colors.white,
                    alignLabelWithHint: true,
                    hintText: 'Senha',
                  ),
                  keyboardType: TextInputType.text,
                ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 10, left: 30, right: 30),
              child: TextField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(11),
                  WhitelistingTextInputFormatter(RegExp("[0-9]")),
                ],
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue, width: 0.0),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(50.0),
                    ),
                  ),
                  contentPadding:
                  new EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                  filled: true,
                  fillColor: Colors.white,
                  alignLabelWithHint: true,
                  hintText: 'Telefone',
                ),
                keyboardType: TextInputType.number,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 10, left: 30, right: 30),
              child: TextField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(8),
                  WhitelistingTextInputFormatter(RegExp("[0-9]")),
                ],
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue, width: 0.0),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(50.0),
                    ),
                  ),
                  contentPadding:
                  new EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                  filled: true,
                  fillColor: Colors.white,
                  alignLabelWithHint: true,
                  hintText: 'CEP',
                  //errorText: 'Digite um CEP válido',
                ),
                keyboardType: TextInputType.number,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 10, left: 30, right: 30),
              child: TextField(
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue, width: 0.0),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(50.0),
                    ),
                  ),
                  contentPadding:
                  new EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                  filled: true,
                  fillColor: Colors.white,
                  alignLabelWithHint: true,
                  hintText: 'Endereço',

                ),
                keyboardType: TextInputType.text,
              ),
            ),

            Padding(
                padding: EdgeInsets.only(top: 20, left: 30, right: 30),
                child: ButtonBar(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: 130,
                      child:
                      FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.blue),
                        ),
                        child: Text('CADASTRAR',
                          style: TextStyle(
                              fontFamily: 'Oswald',
                              color: Colors.white
                          ),
                        ),
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                              (Route<dynamic> route) => false,
                          );
                        },
                      ),
                    ),

                    Container(
                      width: 130,
                      child:
                      FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white),
                        ),
                        child: Text('VOLTAR',
                          style: TextStyle(
                              fontFamily: 'Oswald',
                              color: Colors.white
                          ),
                        ),
                        onPressed: () {
                        Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}
