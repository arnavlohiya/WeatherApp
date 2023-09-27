import "package:flutter/material.dart";
import "package:weatherthree/single_card_details_screen.dart";

class CityCard extends StatefulWidget{
  Map allDetails = {};
  double ?weather = 0.0;
  String ?cityName="";
  String iconUrl="";
  String description="";
  double feelsLike=0.0;
  double minTemp=0.0;
  double maxTemp=0.0;
  bool fromStoreData= false;
  String ?lastUpdated;
  //double longitude;

  CityCard(Map allDetails){
    if(!allDetails.isEmpty) {
      print("inside constructor of cityCard");

      this.allDetails = allDetails;
      cityName = allDetails['name'];
      weather = allDetails["main"]["temp"];
      description = allDetails["weather"][0]['description'];

      iconUrl = allDetails["weather"][0]["icon"];
      feelsLike = allDetails["main"]['feels_like'];
      minTemp = allDetails["main"]["temp_min"];
      maxTemp = allDetails["main"]["temp_max"];
    }
  }
  CityCard.fromPlayer({required this.weather, required this.cityName}){
    fromStoreData = true;
    print("CityCard.fromPlayer constructor called");
  }


  @override
  State<CityCard> createState() => _CityCardState();
}

class _CityCardState extends State<CityCard> {
  bool light = true;
  bool showFrontSide = true;
  @override
  Widget build(BuildContext context) {
    Container frontSide = Container(

      child: Text(
        "${widget.cityName}\n ${widget.weather}",
        style: TextStyle(fontSize: 25),
      ),
      height: (MediaQuery.of(context).size.height) / 4,
      width: (MediaQuery.of(context).size.height) - 40,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: (widget.weather==null || widget.weather == 0)?
        Colors.grey[300]:
        widget.weather!>36.0?
        Colors.red:
        widget.weather!>32.0?
        Colors.deepOrangeAccent:
        widget.weather!>28.0?
        Colors.blueAccent:
        widget.weather!>24.0?
        Colors.lightBlueAccent:
        widget.weather!>15.0?
        Colors.lightBlueAccent[200]:
        widget.weather!>5.0?
        Colors.lightBlueAccent[100]:
        Colors.lightBlueAccent[50],
        borderRadius: BorderRadius.circular(15), // Rounded corners
      ),
      // color: Colors.blue,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    );
    Container backSide = Container(
      height: (MediaQuery.of(context).size.height) / 4,
      width: (MediaQuery.of(context).size.height) - 40,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: (widget.weather==null || widget.weather == 0)?
        Colors.grey[300]:
        widget.weather!>36.0?
        Colors.red:
        widget.weather!>32.0?
        Colors.deepOrangeAccent:
        widget.weather!>28.0?
        Colors.blueAccent:
        widget.weather!>24.0?
        Colors.lightBlueAccent:
        widget.weather!>15.0?
        Colors.lightBlueAccent[200]:
        widget.weather!>5.0?
        Colors.lightBlueAccent[100]:
        Colors.lightBlueAccent[50],
        borderRadius: BorderRadius.circular(15), // Rounded corners
      ),
      // color: Colors.blue,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${widget.cityName}\n ${widget.weather}",
            style: TextStyle(fontSize: 25),
          ),
          !widget.fromStoreData?
            Row(
              children: [
                Text("${widget.description}"),
                widget.iconUrl != "" ? Image.network(
                  'http://openweathermap.org/img/w/${widget.iconUrl}.png',
                  height: 25,) : CircularProgressIndicator(strokeWidth: 1,)
              ],
            ): Text("notLoaded"),
            !widget.fromStoreData?
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Feels like ${widget.feelsLike}"),
                Text("Max Temp: ${widget.maxTemp}"),
                Text("Min Temp: ${widget.minTemp}"),
              ],
            ):Text("notLoaded")
        ],
      ),
    );
    return GestureDetector(
      onTap: (){
        print("card has been tapped");
        setState(() {
          showFrontSide= !showFrontSide;
        });
      },
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: Container(
          key: ValueKey<bool>(showFrontSide),
          child:showFrontSide?frontSide : backSide,
        )


      ),
    );

  }


}
/*
        weather!>28?
        Colors.blueAccent:
        weather!>24?
        Colors.lightBlueAccent:
        weather!>15?
        Colors.lightBlueAccent[200]:
        weather!>5?
        Colors.lightBlueAccent[100]:

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SingleCardDetails(),
              settings: RouteSettings(
              arguments: widget.allDetails,
          )
          )
        );


 */

//TODO: figure out what the 'int not type double?' error is on the all cities page
//TODO: make notes on passing route data
//TODO: practice passing functions as arguments and make notes for it