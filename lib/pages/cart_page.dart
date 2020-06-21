import 'package:flutter/material.dart';
import '../pages/buy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/Produto.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  Firestore db = Firestore.instance;
  String user;
  //num _soma = 0;//valor total da compra, sera atualizada conforme a listagem de produtos (e quantidade) no carrinho do usuario
  //var myDouble = double.parse('123.45');
  //var myInt = int.parse('12345');
  String _getUser() {
    FirebaseAuth.instance.currentUser().then((currentUser) => {
      if(currentUser != "") {
        user = currentUser.uid,
      }
    });
    print("USERID: "+user);
    return user;
  }

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
/*
      //nesta tela falta atualizar o valor total
      body: StreamBuilder(
          stream: db.collection(_getUser()).document("produtos").collection("produtos").snapshots(),

          //ignore: missing_return
          builder: (context, snapshot) {
            switch( snapshot.connectionState ){
              case ConnectionState.none :
              case ConnectionState.done :
              case ConnectionState.waiting :
                return Center(
                  child: Column(
                    children: <Widget>[
                      Text("Carregando produtos..."),
                      CircularProgressIndicator()
                    ],
                  ),
                );
                break;

              case ConnectionState.active :

                QuerySnapshot querySnapshot = snapshot.data;

                if(snapshot.hasError){
                  return Container(
                    child: Text("Ocorreram erros ao carregar os dados"),
                  );
                }else{
                  print("DADOS CARREGADOS: "+snapshot.data.toString());

                  return Container(
                    child: ListView.builder(
                        itemCount: querySnapshot.documents.length,
                        itemBuilder: (context, index){
                          //recupera os produtos
                          List<DocumentSnapshot> produtos = querySnapshot.documents.toList();
                          DocumentSnapshot dados = produtos[index];

                          Produto produto = Produto(dados["nome"], dados["imagem"], dados["marca"], dados["mercado"], dados["preco"], dados["volume"], dados["quantidade"]);

                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(produto.imagem),
                            ),
                            title: Text(produto.nome),
                            subtitle: Text( produto.quantidade.toString() + "x R\$" + produto.preco),
                          );
                        }
                    ),
                  );
                }
                break;
            }
          }
      ),*/

      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(child: ListTile(
              title: new Text("Total: "),
              //subtitle: new Text("R\$" + _soma.toString()),
            )),

            Expanded(
              child: new MaterialButton(onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=> Buy())); },
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
