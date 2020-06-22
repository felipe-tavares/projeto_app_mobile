import '../pages/cadastro.dart';
import '../pages/home.dart';
import 'package:flutter/material.dart';
import '../model/Usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();

  // state var
  String _erroMsg = "";

  _entrar(Usuario usuario){
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.signInWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha
    ).then((firebaseUser) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Home()),
            (Route<dynamic> route) => false,
      );
    }).catchError((error){
      print("Error from Firebase: "+error.toString());
      setState(() {
        _erroMsg = "Error on login!";
      });
    });
  }

  _validacao(){
    String email = _emailController.text;
    String senha = _senhaController.text;

    if(email.isNotEmpty || senha.isNotEmpty){
      if(!email.contains("@")){
        setState(() {
          _erroMsg = "Inform a valid email!";
        });
      }else if(senha.length < 8){
        setState(() {
          _erroMsg = "Password must contain at least 8 characters!";
        });
      }else{
        setState(() {
          _erroMsg = "";
        });

        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.senha = senha;

        _entrar(usuario);
      }
    }else{
      setState(() {
        _erroMsg = "Fill in all the data fields!";
      });
    }
  }
  
  Future _UserLogado() async {
	  FirebaseAuth auth = FirebaseAuth.instance;
	  FirebaseUser userlogado = await auth.currentUser();
	  
	  if(userlogado != null) {
		  Navigator.pushAndRemoveUntil(
			context,
			MaterialPageRoute(builder: (context) => Home()),
				(Route<dynamic> route) => false,
		  );
	  }
  }
  
  @override
  void initState() {
	  _UserLogado();
	  super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
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
                controller: _emailController,
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
                    labelText: 'Password'
                ),
                controller: _senhaController,
                keyboardType: TextInputType.visiblePassword,
              ),
            ),

            Padding(padding: EdgeInsets.only(top: 20, left: 30, right: 30),
              child: Text(
                _erroMsg,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 20, left: 30, right: 30),
              child:
              ButtonBar(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: 110,
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
                          _validacao();
                        },
                      ),
                    ),

                    Container(
                      width:130,
                      child:
                      FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white),
                        ),
                        child: Text('SIGN UP',
                          style: TextStyle(
                            fontFamily: 'Oswald',
                            color: Colors.white,
                          ),
                        ),
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

            OutlineButton(
              child: Text('I forgot my password',
                style: TextStyle(
                    fontFamily: 'Oswald',
                    color: Colors.white
                ),
              ),
              color: Colors.blue,
              onPressed: () {/** */},
            ),

            Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 40, bottom: 30),
                  child: Align(
                    alignment: FractionalOffset.bottomRight,
                    child: Container(
                        child: Text(
                          "Go market \nat home.",
                          textAlign: TextAlign.right,

                          style: TextStyle(
                            fontFamily: 'Oswald',
                            fontSize: 15,
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
