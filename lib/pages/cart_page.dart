import 'package:flutter/material.dart';
import '../pages/buy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/Produto.dart';

class Cart extends StatefulWidget {
  final num soma;

  const Cart({Key key, this.soma}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}
//cada vez q entra aki, recebe valor
//quando remove e volta, ele reseta oq tava antes de chegar
//alternativa 1: salvar esse dado numa db e se basear nela ao invez de passagem de parametro
//alternativa 2: enviar o valor atual ao voltar
class _CartState extends State<Cart> {
  Firestore db = Firestore.instance;
  num total = 0;
  bool passou = false;
  String _userID = "";
  
  Future _getUser() async {
    //String user = "3Sef58VOM0gRQ9TlBEK89HAxBOq1";
	FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
	setState((){
		_userID = currentUser.uid;
	});
    print("USER::" +_userID);
    //return user;
  }

  void atualizaTotal(value){
    setState(() {
      total -= value;
      print("quando subtrai");
      print(total);//ta subtraindo mas n ta mudando la em baixo
    });
  }
  
  @override
  void initState() {
	  _getUser();
	  super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(passou == false){
      setState(() {
        total = widget.soma;
        print("quando incia");
        print(total);//sera q ta resetando o valor aki?
      });
      passou = true;
    }

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () { Navigator.pop(context, total); },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
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

      //nesta tela falta atualizar o valor total
      body: _loadBody(),

      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
                child: ListTile(
                  title: new Text("Total: "),
                  subtitle: new Text("R\$$total"),
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
  
  _loadBody() {
	  return _userID == ""
		? Center(
			child: Column(
                    children: <Widget>[
                      Text("Carregando produtos..."),
                      CircularProgressIndicator()
                    ],
                  ),
		)
		: _body();
  }
  
  _body() {
	  return StreamBuilder(
          stream: db.collection(_userID).document("produtos").collection("produtos").snapshots(),

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
                            trailing: IconButton(icon: Icon(Icons.remove_circle),
                              color: Colors.red,
                              onPressed: (){
                                  atualizaTotal(double.parse(produto.preco));

                                  Firestore.instance.runTransaction((Transaction myTransaction) async {
                                    await myTransaction.delete(snapshot.data.documents[index].reference);
                                  });
                              }

                            )

                          );
                        }
                    ),
                  );
                }
                break;
            }
          }
      );
  }
}
