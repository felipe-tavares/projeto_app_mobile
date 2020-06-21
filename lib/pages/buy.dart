import 'package:flutter/material.dart';
import '../pages/end.dart';

class Buy extends StatefulWidget {
  @override
  _BuyState createState() => _BuyState();
}

class _BuyState extends State<Buy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Minha Compra"),
          actions: <Widget>[
          ],
        ),

        body: ListView(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 5, left: 3, right: 3, top: 5),
              height: 50,
              color: Colors.grey[500],//nome do individuo
              child: const Text('Nome', style: TextStyle(color: Colors.black, fontSize: 20), textAlign: TextAlign.left),
            ),
            Container(
                margin: const EdgeInsets.only(bottom: 5, left: 3, right: 3),
                height: 50,
                color: Colors.grey[500],//rua do individuo
                child: const Text('Rua', style: TextStyle(color: Colors.black, fontSize: 20), textAlign: TextAlign.left,)
            ),
            Container(
                margin: const EdgeInsets.only(bottom: 5, left: 3, right: 3),
                height: 50,
                color: Colors.grey[500],//numero da casa do individuo
                child: const Text('Número', style: TextStyle(color: Colors.black, fontSize: 20), textAlign: TextAlign.left,)
            ),
            Container(
                margin: const EdgeInsets.only(bottom: 5, left: 3, right: 3),
                height: 50,
                color: Colors.grey[500],//distrito do individuo
                child: const Text('Distrito', style: TextStyle(color: Colors.black, fontSize: 20), textAlign: TextAlign.left,)
            ),
            Container(
                margin: const EdgeInsets.only(bottom: 5, left: 3, right: 3),
                height: 50,
                color: Colors.grey[500],//cidade do individuo
                child: const Text('Cidade', style: TextStyle(color: Colors.black, fontSize: 20), textAlign: TextAlign.left,)
            ),
            Container(
                margin: const EdgeInsets.only(bottom: 5, left: 3, right: 3),
                height: 50,
                color: Colors.grey[500],//select : Dinheiro, cartao...
                child: const Text('Método de pagamento', style: TextStyle(color: Colors.black, fontSize: 20), textAlign: TextAlign.left,)
            ),
            Container(
                margin: const EdgeInsets.only(bottom: 5, left: 3, right: 3),
                height: 50,
                color: Colors.grey[500],//data a ser entregue, formato DD/MM
                child: const Text('Data', style: TextStyle(color: Colors.black, fontSize: 20), textAlign: TextAlign.left,)
            ),
            Container(
                margin: const EdgeInsets.only(bottom: 5, left: 3, right: 3),
                height: 50,
                color: Colors.grey[500],//Hora a ser entregue, formato HH:MM:SS (essa hora é enviada como paramentro para a próxima tela)
                child: const Text('Hora', style: TextStyle(color: Colors.black, fontSize: 20), textAlign: TextAlign.left,)
            ),
            Container(
                margin: const EdgeInsets.only(bottom: 5, left: 3, right: 3),
                height: 50,
                color: Colors.grey[500],//valor somado dos itens adicionados à lista do cliente
                child: const Text('Total: R\$', style: TextStyle(color: Colors.black, fontSize: 20), textAlign: TextAlign.left,)
            ),
          ],
        ),

        bottomNavigationBar: new Container(
          color: Colors.white,
          child: Row(
              children: <Widget>[
                  Expanded(
                    child: new MaterialButton(//puxa endereço de locator.dart e seta nos containeres acima (mantem na tela)
                        onPressed: (){ /** */},
                        child: new Text("Atualizar endereco", style: TextStyle(color: Colors.black),),
                        color: Colors.yellow,
                    )
                  ),

                Expanded(
                  child: new MaterialButton(//vai pra tela de end (enviar hora q se espera chegar como parametro)
                    onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=> new Timer())); },
                    child: new Text("Check Out", style: TextStyle(color: Colors.black),),
                    color: Colors.amber[100],
                  )
                )
            ],
        )
      ),
    );
  }
}