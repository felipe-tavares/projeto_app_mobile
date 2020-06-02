import 'package:flutter/material.dart';
import '../model/Animal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future<List<Animal>> _getAnimais() async {
    Firestore db = Firestore.instance;

    QuerySnapshot querySnapshot = await db.collection("animais")
        .getDocuments();

    List<Animal> listaAnimais = List();
    for(DocumentSnapshot item in querySnapshot.documents){
      var dados = item.data;

      Animal animal = Animal(
          dados["nome"],
          dados["idade"],
          dados["raca"],
          dados["foto"]
      );

      listaAnimais.add(animal);
    }

    print("Quantidade de animais: " + listaAnimais.length.toString());

    return listaAnimais;
  }

  _body(){
    return FutureBuilder<List<Animal>>(
        future: _getAnimais(),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){

            case ConnectionState.none: print("Conexão em estado nulo."); break;

            case ConnectionState.waiting :
              return Center(
                child: Column(
                  children: <Widget>[
                    Text("Carregando animais..."),
                    CircularProgressIndicator()
                  ],
                ),
              );
              break;

            case ConnectionState.active: print("Conexão em estado ativo (útil em streaming)."); break;

            case ConnectionState.done:
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    List<Animal> animais = snapshot.data;
                    Animal animal = animais[index];

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(animal.foto),
                      ),
                      title: Text(animal.nome),
                      subtitle: Text(animal.raca + ", " + animal.idade + " anos"),
                    );
                  }
              );
              break;
          }

          return null;
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seus Pets"),
        centerTitle: true,
      ),

      body: _body(),

      floatingActionButton:
      FloatingActionButton(child: Icon(Icons.add), onPressed: null),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.home,
                    color: Colors.blue,
                  ),
                  onPressed: null),
              IconButton(
                  icon: Icon(
                    Icons.pets,
                    color: Colors.blue,
                  ),
                  onPressed: null),
              IconButton(
                  icon: Icon(
                    Icons.people,
                    color: Colors.blue,
                  ),
                  onPressed: null),
              IconButton(
                  icon: Icon(
                    Icons.calendar_today,
                    color: Colors.blue,
                  ),
                  onPressed: null),
            ],
          ),
        ),
      ),
    );
  }
}