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
  String _erroMsg = "";

  String nomeMetodo="";
  var _metodos =['Dinheiro','Cartão','Transferência'];
  var _metodoSelecionado = 'Dinheiro';

  TextEditingController _nomeController = TextEditingController();
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
          backgroundColor: Colors.red,
          actions: <Widget>[
          ],
        ),

        body: ListView(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 5, left: 3, right: 3, top: 5),
              height: 90,
                child: Column(
                    children: <Widget>[
                      const Text('Nome', style: TextStyle(color: Colors.black, fontSize: 18)),
                      TextField(
                        cursorColor: Colors.black,
                        textAlign: TextAlign.center,
                        controller: _nomeController,
                        decoration: InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(50.0),
                              ),
                            ),
                        ),
                      )
                    ]
                )
            ),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                margin: const EdgeInsets.only(bottom: 5, left: 3, right: 3),
                height: 50,
                child: Column(
                  children: <Widget>[
                    const Text('Rua', style: TextStyle(color: Colors.black, fontSize: 18)),
                    Text(_ruaController, style: TextStyle(color: Colors.black, fontSize: 20)),
                  ]
                )
            ),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                margin: const EdgeInsets.only(bottom: 5, left: 3, right: 3),
                height: 50,
                child: Column(
                    children: <Widget>[
                      const Text('Número', style: TextStyle(color: Colors.black, fontSize: 18)),
                      Text(_numeroController, style: TextStyle(color: Colors.black, fontSize: 20))
                    ],
              )
            ),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                margin: const EdgeInsets.only(bottom: 5, left: 3, right: 3),
                height: 50,
                child: Column(
                  children: <Widget>[
                    const Text('Bairro', style: TextStyle(color: Colors.black, fontSize: 18)),
                    Text(_bairroController, style: TextStyle(color: Colors.black, fontSize: 20))
                  ],
                )
            ),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                margin: const EdgeInsets.only(bottom: 5, left: 3, right: 3),
                height: 50,
                child: Column(
                    children: <Widget>[
                      const Text('Cidade', style: TextStyle(color: Colors.black, fontSize: 18)),
                      Text(_cidadeController, style: TextStyle(color: Colors.black, fontSize: 20))
                    ]
                )
            ),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                margin: const EdgeInsets.only(bottom: 5, left: 3, right: 3),
                height: 50,
                child: Column(
                    children: <Widget>[
                      const Text('CEP', style: TextStyle(color: Colors.black, fontSize: 18)),
                      Text(_cepController, style: TextStyle(color: Colors.black, fontSize: 20))
                    ]
                )
            ),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                margin: const EdgeInsets.only(bottom: 5, left: 3, right: 3),
                height: 50,
                child: Column(
                    children: <Widget>[
                    const Text('Estado', style: TextStyle(color: Colors.black, fontSize: 18)),
                    Text(_estadoController, style: TextStyle(color: Colors.black, fontSize: 20))
                  ]
                )
              ),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                margin: const EdgeInsets.only(bottom: 5, left: 3, right: 3),
                height: 117,
                child: Column(
                  children: <Widget>[
                  const Text('Método de pagamento', style: TextStyle(color: Colors.black, fontSize: 18)),
                    DropdownButton<String>(
                        items : _metodos.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem, style: TextStyle(color: Colors.black, fontSize: 20)),
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
                    style: TextStyle(fontSize: 18), textAlign: TextAlign.center,
                )
                  ]
                )
             ),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                margin: const EdgeInsets.only(bottom: 5, left: 3, right: 3),
                height: 80,
                child: Column(
                    children: <Widget>[
                      BasicDateField(),
                    ]
                )
            ),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                margin: const EdgeInsets.only(bottom: 5, left: 3, right: 3),
                height: 80,
                child: Column(
                    children: <Widget>[
                      Clock24Example(),
                    ]
                )
            ),
            Container( //Total da compra
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                margin: const EdgeInsets.only(top: 5, bottom: 5, left: 3, right: 3),
                height: 30,
                child: new Text('Total: R\$$value', style: TextStyle(color: Colors.black, fontSize: 20), textAlign: TextAlign.center,)
            ),
            Padding(padding: EdgeInsets.only(top: 20, left: 30, right: 30),
              child: Text(
                _erroMsg,
                style: TextStyle(color: Colors.red, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),

        bottomNavigationBar: new Container(
          color: Colors.white,
          child: Row(
              children: <Widget>[
                  Expanded(
                    child: Material(  //Wrap with Material
                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20.0) ),
                    color: Colors.amberAccent,
                    clipBehavior: Clip.antiAlias, // Add This
                    child: new MaterialButton(//puxa endereço de locator.dart e seta nos containeres acima (mantem na tela)
                        onPressed: (){ _getCurrentLocation();},
                        child: new Text("Atualizar endereço", style: TextStyle(color: Colors.black),),
                    )
          ),
                  ),

                Expanded(
                  child: Material(  //Wrap with Material
                  shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20.0) ),
                  color: Colors.redAccent,
                  clipBehavior: Clip.antiAlias, // Add This
                  child: new MaterialButton(//vai pra tela de end (enviar hora q se espera chegar como parametro)
                    onPressed: (){
                      if(_nomeController.toString().isNotEmpty && _ruaController.isNotEmpty && _cidadeController.isNotEmpty && setime && setdat){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> new Timer(time: DateTimeField.combine(dia, hora).toString())));
                      }else{
                        setState(() {
                        _erroMsg = "Insira seus dados!";
                        });
                      }
                    },
                    child: new Text("Check Out", style: TextStyle(color: Colors.black),),
                  )
                ),
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
          _ruaController = place.thoroughfare;
          _numeroController = place.name;
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
bool setime = false;
bool setdat = false;

class BasicDateField extends StatelessWidget {
  final format = DateFormat("dd-MM-yyyy");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Data de entrega'),
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
          setdat = true;
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
      Text('Hora de entrega'),
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
          setime = true;
          return DateTimeField.convert(time);
        },
      ),
    ]);
  }
}