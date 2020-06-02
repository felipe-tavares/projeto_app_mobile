import '../pages/cadastro.dart';
import '../pages/home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 80, left: 30, right: 30),
              child:
                Image.asset("assets/images/logo.png"
              ),
            ),
      Padding(
        padding: EdgeInsets.only(top: 40, left: 30, right: 30),
        child:
            TextField(
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(50.0),
                  ),
                ),
                contentPadding: new EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),

                filled:true,
                fillColor: Colors.white,

                alignLabelWithHint: true,
                labelText: 'E-mail'
              ),
                  keyboardType: TextInputType.emailAddress,
            ),
      ),

      Padding(
        padding: EdgeInsets.only(top: 10, left: 30, right: 30),
        child:
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(50.0),
                    ),
                  ),
                  contentPadding: new EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),

                  filled:true,
                  fillColor: Colors.white,

                  alignLabelWithHint: true,
                  labelText: 'Senha'
              ),
              keyboardType: TextInputType.text,
            ),
      ),

      Padding(
        padding: EdgeInsets.only(top: 20, left: 30, right: 30),
        child:
            ButtonBar(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 130,
                  child:
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.white),
                      ),
                      child: Text('LOGIN',
                        style: TextStyle(
                          fontFamily: 'Oswald',
                            color: Colors.white
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) => Home()),
                            (Route<dynamic> route) => false,
                        );
                      },
                    ),
                   ),

                Container(
                  width:130,
                  child:
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.blue),
                      ),
                      child: Text('CADASTRE-SE',
                      style: TextStyle(
                        fontFamily: 'Oswald',
                        color: Colors.white,
                      ),
                      ),
                      color: Colors.blue,
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder:(context) => Cadastro()
                            )
                        );
                      },
                    ),
                  ),
              ]
            ),
      ),

            Container(
              width:150,
              child:
                FlatButton(
                  child: Text('Esqueci a senha',
                  style: TextStyle(
                  fontFamily: 'Oswald',
                  color: Colors.white,
                  ),
                  ),
                  onPressed: () {/** */},
            ),
           ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 30, bottom: 30),
                child: Align(
                  alignment: FractionalOffset.bottomRight,
                  child: Container(
                    child: Text(
                      "Compre \ncom\n eficiência!",
                      textAlign: TextAlign.right,

                      style: TextStyle(
                        fontFamily: 'Oswald',
                        fontSize: 25,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    )
                  ),
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}
