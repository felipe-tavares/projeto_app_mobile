import 'package:flutter/material.dart';
import '../model/Produto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:baitadelivery/pages/cart_page.dart';
import 'package:baitadelivery/pages/perfil.dart';
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
  String _mercadoController = "";
  String _volumeController = "";
  num _counterController = 0;
  num soma = 0;

  _validacao() {
    String nome = _nomeController;
    String imagem = _imagemController;
    String marca = _marcaController;
    String preco = _precoController;
    String mercado = _mercadoController;
    String volume = _volumeController;
    num quantidade = _counterController;

    if (nome.isNotEmpty && imagem.isNotEmpty && marca.isNotEmpty && preco.isNotEmpty && mercado.isNotEmpty && volume.isNotEmpty && !(quantidade.isNaN)) {
      _addcart();
    }
    else {
      print("Esta faltando");
      if(nome.isEmpty){
        print(" Nome!");
      }
      if(imagem.isEmpty){
        print(" Imagem!");
      }
      if(marca.isEmpty){
        print(" Marca!");
      }
      if(preco.isEmpty){
        print(" Preco!");
      }
      if(mercado.isEmpty){
        print(" Mercado!");
      }
      if(volume.isEmpty){
        print(" Volume!");
      }
      if(quantidade.isNaN){
        print(" Quantidade!");
      }
    }
  }

  Future _addcart() async {
    String nome = _nomeController;
    String imagem = _imagemController;
    String marca = _marcaController;
    String preco = _precoController;
    String mercado = _mercadoController;
    String volume = _volumeController;
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
      "mercado": mercado,
      "preco": preco,
      "volume": volume,
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
        backgroundColor: Colors.red,
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

                            Produto produto = Produto(dados["nome"], dados["imagem"], dados["marca"], dados["mercado"], dados["preco"], dados["volume"], dados["quantidade"]);

                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(produto.imagem),
                              ),
                              title: Text( produto.nome ),
                              subtitle: Text( produto.marca + ", R\$ " + produto.preco),
                              trailing: IconButton(icon: Icon(Icons.plus_one),
                                  onPressed: () {//bolar algum esquema pra usar a quantidade do produto efetivamente, sem repeti-lo no carrinho

                                    setState(() {
                                      _nomeController = produto.nome;
                                      _imagemController = produto.imagem;
                                      _marcaController = produto.marca;
                                      _precoController = produto.preco;
                                      _mercadoController = produto.mercado;
                                      _volumeController = produto.volume;
                                      _counterController += 1;
                                      soma += (double.parse(produto.preco));
                                    });
                                    _validacao();

                                    setState(() {
                                      _counterController = 0;
                                    });

                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("+1 " + produto.nome + " " + produto.marca + " adicionado ao carrinho"),
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

      bottomNavigationBar: BottomAppBar(
        //shape: const CircularNotchedRectangle(),
        color: Colors.red,
        child: Container(
          height: 50.0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                  padding: EdgeInsets.only(right: 20.0, left: 20.0),
                  color: Colors.white,
                  icon: Icon(Icons.home),
                  tooltip: ("Home"),
                  onPressed: () {/* */}
              ),

              IconButton(
                padding: EdgeInsets.only(right: 50.0, left: 50.0),
                color: Colors.white,
                icon: Icon(Icons.person),
                tooltip: ("Perfil"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> new Perfil()));
                },
              ),

              IconButton(
                padding: EdgeInsets.only(right: 30.0, left: 30.0),
                color: Colors.white,
                icon: Icon(Icons.shopping_cart),
                tooltip: ("Meu Carrinho"),
                onPressed: () {
                  _awaitReturnValueFromSecondScreen(context);
                },
              ),
            ],
          ),
        ),
      ),

    );
  }

  void _awaitReturnValueFromSecondScreen(BuildContext context) async {

    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Cart(soma: soma),
        ));

    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      soma = result;
    });
  }

  }