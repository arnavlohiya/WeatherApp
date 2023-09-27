import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'home_screen.dart';
import 'location_page.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    print("build of main.dart has been called");
    return  MaterialApp(
      home: PageView(
        /// [PageView.scrollDirection] defaults to [Axis.horizontal].
        /// Use [Axis.vertical] to scroll vertically.
        controller: controller,
        children: [
          HomeScreen(),
          LocationWidget(),

        ],
      ),
    );

  }
  
}


// MaterialApp(
//   initialRoute: "/home_screen",
//   title: "Home pg title",
//   routes: {
//     '/home_screen': (context) => HomeScreen(),
//     "/location_screen": (context) => LocationWidget()
//   },
//   // home: Center(
//   //     child:LocationWidget()
//   // ),
// );