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
                onPressed: () {/* */}
            ),

            IconButton(
                padding: EdgeInsets.only(right: 50.0, left: 50.0),
                color: Colors.blue,
                icon: Icon(Icons.pets),
                onPressed: () {/* */}
            ),

            IconButton(
                padding: EdgeInsets.only(right: 30.0, left: 30.0),
                color: Colors.blue,
                icon: Icon(Icons.person),
                onPressed: () {/* */}
            ),

            IconButton(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                color: Colors.blue,
                icon: Icon(Icons.event),
                onPressed: () {/* */}
            ),
          ],
        ),
      ),
    );
  }
}