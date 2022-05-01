//A page to test whatever widget you want to see
// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gampah_app/main.dart';

class TestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestPageState();
  }
}

class TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    // change the build content to whatever
    // return MaterialApp(
    //   title: "Gampah",
    //   home: HomePage(),
    // );
    return MyApp();
  }
}

//this file might not be needed to be commited in the future.
