import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu Carrinho"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: (){/*showSearch(context: context, delegate:  ProductSearch));*/},
          )],
      ),
      
      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(child: ListTile(
              title: new Text("Total: "),
              subtitle: new Text("R\$"),
            )),

            Expanded(
              child: new MaterialButton(onPressed: (){/* COLOCAR PRA ONDE VAI DEPOIS DE FAZER CHECKOUT */},
              child: new Text("Check Out", style: TextStyle(color: Colors.black),),
              color: Colors.grey,
              )
            )
          ],
        )
      ),
    );
  }
}
