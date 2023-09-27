import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weatherthree/city_card.dart';
import 'package:weatherthree/location_page.dart';


class HomeScreen extends StatelessWidget{

  double fontsize = 45;
  @override
  Widget build(BuildContext context) {
    print("build method of home_screen.dart has been called");
    bool light = true;
    return Material(
       //color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("The Weather App", style: TextStyle(fontSize: fontsize, fontFamily: "Georgia",),  ),
          //Image.asset('assets/images/swipe_gif.gif', width:fontsize*2 ),

        ],
      ),


    );
  }

}


/*
// ElevatedButton.icon(onPressed: (){
          //     Navigator.pushNamed(context, "/location_screen");
          //   },
          //     icon: Icon(Icons.navigate_next_rounded),
          //     label: Text("Get Started")),
 */