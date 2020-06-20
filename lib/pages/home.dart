import 'package:baitadelivery/components/menu_inferior.dart';
import 'package:flutter/material.dart';
import '../model/Produto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Firestore db = Firestore.instance;
  String _nomeController = "";
  String _imagemController = "";
  String _marcaController = "";
  String _precoController = "";
  num _counterController = 0;
  num soma = 0;
  //enviar soma ao cart.... alternativas: criar classe so pra isso, ou adicionar na database e ler de la

  Future _addcart() async {
    String nome = _nomeController;
    String imagem = _imagemController;
    String marca = _marcaController;
    String preco = _precoController;
    num quantidade = _counterController;

    String new_product;
    FirebaseUser user;

    await FirebaseAuth.instance.currentUser().then((currentUser) => {
      if(currentUser != null){
        user = currentUser
      }
    });

    await Firestore.instance
        .collection(user.uid)
        .document("produtos")
        .collection("produtos")
        .add({
      "nome": nome,
      "imagem": imagem,
      "marca": marca,
      "preco": preco,
      "quantidade": quantidade,
    }).then((value){
      new_product = value.documentID;
    });
    print("ID DOC: "+new_product);

  }

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

      body: StreamBuilder(
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

                            Produto produto = Produto(dados["nome"], dados["imagem"], dados["marca"], dados["preco"], dados["mercado"], dados["volume"], dados["quantidade"]);

                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(produto.imagem),
                              ),
                              title: Text( produto.nome ),
                              subtitle: Text( produto.marca + ", R\$ " + produto.preco),
                              trailing: IconButton(icon: Icon(Icons.plus_one),
                                  onPressed: () {//counter?

                                    setState(() {
                                      _nomeController = produto.nome;
                                      _imagemController = produto.imagem;
                                      _marcaController = produto.imagem;
                                      _precoController = produto.preco;
                                      _counterController += 1;
                                      soma += (double.parse(produto.preco));
                                    });
                                    _addcart();

                                    setState(() {
                                      _counterController = 0;
                                    });

                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("+1 " + produto.nome + " " + produto.marca + " adicionado ao carrinho"),
                                      action: SnackBarAction(
                                        label: 'Undo',
                                        onPressed: () {
                                          // ADICIONAR AQUI O QUE FAZER QUANDO CLICAR NO BOTÃO PARA REMOVER O PRODUTO DO CARRINHO "UNDO"

                                          //remover da data base criada, ou criar alguma função de tempo, pra só adicionar se n clicar no undo
                                        },
                                      ),
                                    )
                                    );


                                  }),

                            );

                          }
                      )


                  );
                }
            }

          }

      ),

      bottomNavigationBar: MenuInferior(),

    );
  }

  }