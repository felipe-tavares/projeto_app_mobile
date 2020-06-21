import 'package:baitadelivery/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:baitadelivery/pages/end.dart';

void main() {
  runApp(
      MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Login()
      )
  );
}

