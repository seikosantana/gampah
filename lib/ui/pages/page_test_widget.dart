//A page to test whatever widget you want to see
import 'package:flutter/cupertino.dart';
import 'package:gampah_app/ui/pages/page_get_started.dart';

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
    return GetStartedPage();
  }
}

//this file might not be needed to be commited in the future.