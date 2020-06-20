import 'package:baitadelivery/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:baitadelivery/pages/end.dart';
import 'file:///C:/Users/samuk_000/AndroidStudioProjects/projeto_app_mobile/lib/components/locator.dart';

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

