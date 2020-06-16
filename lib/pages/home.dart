import 'package:baitadelivery/components/menu_inferior.dart';
import 'package:flutter/material.dart';
import '../model/Produto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Firestore db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Produtos"),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
            onPressed: (){/*showSearch(context: context, delegate:  ProductSearch));*/},
          )],
      ),

      body: _body(),

      bottomNavigationBar: MenuInferior(),

    );
  }

  _body() {
    return StreamBuilder(
        stream: db.collection("Produtos").snapshots(),
// ignore: missing_return
        builder: (context, snapshot) {
          switch( snapshot.connectionState ) {
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

              if(snapshot.hasError) {
                return Container(
                  child: Text("Ocorreram erros ao carregar os dados!"),
                );
              }
              else {
                print("DADOS CARREGADOS: "+snapshot.data.toString());

                return Container(
                    child: ListView.builder(
                        itemCount: querySnapshot.documents.length,
                        itemBuilder: (context, index) {
                          //recupera os produtos
                          List<DocumentSnapshot> produtos = querySnapshot.documents.toList();
                          DocumentSnapshot dados = produtos[index];

                          Produto produto = Produto(dados["nome"], dados["imagem"], dados["marca"], dados["preco"], dados["mercado"], dados["volume"]);

                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(produto.imagem),
                            ),
                            title: Text( produto.nome ),
                            subtitle: Text( produto.marca + ", R\$ " + produto.preco),
                          );
                        }
                    )


                );
              }
          }

        }

    );



  }

}

