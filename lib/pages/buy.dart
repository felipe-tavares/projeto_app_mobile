import 'package:flutter/material.dart';
import '../pages/end.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class Buy extends StatefulWidget {
  final num tot;

  const Buy({Key key, this.tot}) : super(key: key);

  @override
  _BuyState createState() => _BuyState();
}

class _BuyState extends State<Buy> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position _currentPosition;
  String _currentAddress;

  String nomeMetodo="";
  var _metodos =['Dinheiro','Cartão','Transferência'];
  var _metodoSelecionado = 'Dinheiro';

  String _ruaController = "";
  String _numeroController = "";
  String _cidadeController = "";
  String _estadoController = "";
  String _bairroController = "";
  String _cepController = "";
  String _paisController = "";

  num value = 0;
  
  @override
  Widget build(BuildContext context) {
    setState(() {
      value = widget.tot;
    });
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
                child: Column(
                  children: <Widget>[
                    const Text('Rua', style: TextStyle(color: Colors.black, fontSize: 20), textAlign: TextAlign.left,),
                    Text(_ruaController)
                  ]
                )
            ),
            Container(
                margin: const EdgeInsets.only(bottom: 5, left: 3, right: 3),
                height: 50,
                color: Colors.grey[500],//numero da casa do individuo
                child: Column(
                    children: <Widget>[
                      const Text('Número', style: TextStyle(color: Colors.black, fontSize: 20), textAlign: TextAlign.left,),
                      Text(_numeroController)
                    ],
              )
            ),
            Container(
                margin: const EdgeInsets.only(bottom: 5, left: 3, right: 3),
                height: 50,
                color: Colors.grey[500],//bairro do individuo
                child: Column(
                  children: <Widget>[
                    const Text('Bairro', style: TextStyle(color: Colors.black, fontSize: 20), textAlign: TextAlign.left,),
                    Text(_bairroController)
                  ],
                )
            ),
            Container(
                margin: const EdgeInsets.only(bottom: 5, left: 3, right: 3),
                height: 50,
                color: Colors.grey[500],//cidade do individuo
                child: Column(
                    children: <Widget>[
                      const Text('Cidade', style: TextStyle(color: Colors.black, fontSize: 20), textAlign: TextAlign.left,),
                      Text(_cidadeController)
                    ]
                )
            ),
            Container(
                margin: const EdgeInsets.only(bottom: 5, left: 3, right: 3),
                height: 50,
                color: Colors.grey[500],//CEP do individuo
                child: Column(
                    children: <Widget>[
                      const Text('CEP', style: TextStyle(color: Colors.black, fontSize: 20), textAlign: TextAlign.left,),
                      Text(_cepController)
                    ]
                )
            ),
            Container(
                margin: const EdgeInsets.only(bottom: 5, left: 3, right: 3),
                height: 50,
                color: Colors.grey[500],//estado do individuo
                child: Column(
                    children: <Widget>[
                    const Text('Estado', style: TextStyle(color: Colors.black, fontSize: 20), textAlign: TextAlign.left,),
                    Text(_estadoController)
                  ]
                )
              ),
            Container(
                margin: const EdgeInsets.only(bottom: 5, left: 3, right: 3),
                height: 117,
                color: Colors.grey[500],//select : Dinheiro, cartao...
                child: Column(
                  children: <Widget>[
                  const Text('Método de pagamento', style: TextStyle(color: Colors.black, fontSize: 20), textAlign: TextAlign.left,),
                    DropdownButton<String>(
                        items : _metodos.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem),
                          );
                        }).toList(),
                        onChanged: ( String novoItemSelecionado) {
                          _dropDownItemSelected(novoItemSelecionado);
                          setState(() {
                            this._metodoSelecionado =  novoItemSelecionado;
                          });
                        },
                        value: _metodoSelecionado
                    ),
                Text("O método $_metodoSelecionado foi selecionado",
                    style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center,
                )
                  ]
                )
             ),
            BasicDateField(),
            SizedBox(height: 24),
            Clock24Example(),
            SizedBox(height: 24),
            Container(
                margin: const EdgeInsets.only(bottom: 5, left: 3, right: 3),
                height: 50,
                color: Colors.grey[500],//valor somado dos itens adicionados à lista do cliente
                child: new Text('Total: R\$$value', style: TextStyle(color: Colors.black, fontSize: 20), textAlign: TextAlign.left,)
            ),
          ],
        ),

        bottomNavigationBar: new Container(
          color: Colors.white,
          child: Row(
              children: <Widget>[
                  Expanded(
                    child: new MaterialButton(//puxa endereço de locator.dart e seta nos containeres acima (mantem na tela)
                        onPressed: (){ _getCurrentLocation();},
                        child: new Text("Atualizar endereco", style: TextStyle(color: Colors.black),),
                        color: Colors.yellow,
                    )
                  ),

                Expanded(
                  child: new MaterialButton(//vai pra tela de end (enviar hora q se espera chegar como parametro)
                    onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=> new Timer(time: DateTimeField.combine(dia, hora).toString())));  },
                    child: new Text("Check Out", style: TextStyle(color: Colors.black),),
                    color: Colors.amber[100],
                  )
                )
            ],
        )
      ),
    );
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {/*rua, numero, cidade, estado, bairro, cep, paíz*/
        _currentAddress =
        "${place.thoroughfare}, ${place.name}, ${place.subLocality}, ${place.subAdministrativeArea} - ${place.administrativeArea}, ${place.postalCode}, ${place.country}";

        setState(() {
          _numeroController = place.name;
          _ruaController = place.thoroughfare;
          _cidadeController = place.subAdministrativeArea;
          _estadoController = place.administrativeArea;
          _bairroController = place.subLocality;
          _cepController = place.postalCode;
          _paisController = place.country;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  void _dropDownItemSelected(String novoMetodo){
    setState(() {
      this._metodoSelecionado = novoMetodo;
    });
  }
}

TimeOfDay hora;
DateTime dia;

class BasicDateField extends StatelessWidget {
  final format = DateFormat("dd-MM-yyyy");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Data'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: DateTime.now(),
            lastDate: DateTime(2100),
            builder: (context, child) => Localizations.override(
              context: context,
              locale: Locale('pt'),
              child: child,
            ),
          );
          dia = date;
          return date;
        },
      ),
    ]);
  }
}


class Clock24Example extends StatelessWidget {
  final format = DateFormat("HH:mm");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Hora'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(alwaysUse24HourFormat: true),
              child: child,
            ),
          );
          hora = time;
          return DateTimeField.convert(time);
        },
      ),
    ]);
  }
}