import 'package:baitadelivery/pages/cart_page.dart';
import 'package:baitadelivery/pages/perfil.dart';
import 'package:flutter/material.dart';

class MenuInferior extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      //shape: const CircularNotchedRectangle(),
      child: Container(
        height: 50.0,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: <Widget>[
            IconButton(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                color: Colors.blue,
                icon: Icon(Icons.home),
                tooltip: ("Home"),
                onPressed: () {/* */}
            ),

            IconButton(
                padding: EdgeInsets.only(right: 50.0, left: 50.0),
                color: Colors.blue,
                icon: Icon(Icons.person),
                tooltip: ("Perfil"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> new Perfil()));
                },
            ),

            IconButton(
                padding: EdgeInsets.only(right: 30.0, left: 30.0),
                color: Colors.blue,
                icon: Icon(Icons.shopping_cart),
                tooltip: ("Meu Carrinho"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> new Cart()));
                },
            ),
          ],
        ),
      ),
    );
  }
}