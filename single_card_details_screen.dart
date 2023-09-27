import "package:flutter/material.dart";

class SingleCardDetails extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final allDetails = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(title: Text("Passing route data")),
      body: Text(""),
    );
  }
}

//This page is not required anymore