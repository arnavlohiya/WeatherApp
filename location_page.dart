import "dart:convert";

import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:geolocator/geolocator.dart";
import 'package:http/http.dart' as http;
import "package:shared_preferences/shared_preferences.dart";
import "package:weatherthree/city_card.dart";

import "all_locations_page.dart";
import "home_screen.dart";

class LocationWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> _LocationWidget();
}

class _LocationWidget extends State<LocationWidget>{
  List<List<double>> detailsOfAllLocations = [[17.3850,78.4867], [12.9716,77.5946],[34.2268,77.5619],[13.0827,80.2707]];
  String units = "metric";
  Position? position; //not important
  LocationPermission? permission; //need not change
  static double? currentWeather;
  static String? currentLocationName;
  double? currentLatitude;  //imp
  double? currentLongitude; //impt

  CityCard? currentLocCard = CityCard({}) ;
  bool trackLocation= false;

  void initState(){
    super.initState();
    Fluttertoast.showToast(msg: "Tap on the card for more details");
    _loadCard();
  }

  _loadCard()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.get('weather') != null) { // not opening app for the first time
      print("\n\n\n\nI'm not coming here for the first time ${prefs.getString('cityName')}\n\n\n\n");
      currentLocCard = CityCard.fromPlayer(weather: prefs.getDouble('weather'), cityName: prefs.getString('cityName'));
    }
    setState(() {

    });
  }

  fetchPermission ()async{
    print("fetchPermission() called");
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    print("await 1 done");
    if(!isServiceEnabled){
      print("0");

      Fluttertoast.showToast(msg: "Location Service has been disabled :(");
    }
    permission = await Geolocator.checkPermission();
    print("await 2 done");

    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied || permission == LocationPermission.deniedForever){
        Fluttertoast.showToast(msg: "Location permissions have been denied");
      }
    }
    position = await Geolocator.getCurrentPosition();
    currentLatitude = position?.latitude;
    currentLongitude = position?.longitude;
  }

  Future<CityCard> getWeather(double? latitude, double? longitude, bool isItForCurrentLocation)async{//,
    print("100");
    String? lat = latitude.toString();
    String? long = longitude.toString();
    print("101");
    String query = "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=e1ced62bd87a7f6909980c5016abcdee&units=$units";
    http.Response response = await http.get(Uri.parse(query));
    print("102");
    Map decodedVal = jsonDecode(response.body);
    double? temparature = decodedVal["main"]["temp"] as double;
    String? nameOfPlace = decodedVal["name"];
    if(isItForCurrentLocation) {
      currentWeather = temparature;
      currentLocationName = nameOfPlace;
    }
    // List<dynamic> weatherDetails = [currentWeather, currentLocationName];
    return CityCard(decodedVal);

    // print("103");
    // return weatherDetails;
  }

  Future<List<CityCard>?> createAllCities()async{
    List<CityCard>? listOfCityCards = [];
    print("the length of array is: "+detailsOfAllLocations.length.toString());
    for(int i=0; i< detailsOfAllLocations.length;i++){
      listOfCityCards.add(await getWeather(detailsOfAllLocations[i][0], detailsOfAllLocations[i][1], false));
    }
    print("the length of created aray is:" +listOfCityCards.length.toString() );
    return listOfCityCards;
  }

  bool light = false;
  @override
  Widget build(BuildContext context){
    final PageController controller = PageController();
    Future<List<CityCard>?> tmp =  createAllCities();
    print("build method of LocationWidget has been called");
    return PageView(
      controller: controller,

      children: [
        Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: Text("Location Page"),
            centerTitle: true,
            actions: [
              ElevatedButton.icon(
                icon: Icon(Icons.all_inbox_rounded),
                label: Text("All Cities"),// Replace with your desired icon
                onPressed: () async {
                  Future<List<CityCard>?> tmp =  createAllCities();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> AllLocationsPage( listOfCityCards: tmp) ));
                },
              ),
            ]
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                currentLocCard!,
                ElevatedButton(onPressed: () async {
                  print("button has been pressed");
                  await fetchPermission();
                  CityCard tmp = await getWeather(currentLatitude, currentLongitude, true);
                  setState((){
                    _saveData();
                    currentLocCard = tmp;
                  });
                }, child: Text("Get Weather update")),
                SwitchListTile(
                  title: Text(light==true?'Farenheit':'Celsius'),
                  value: light,
                  onChanged: (bool value) {
                    setState(() {
                      light = value;
                      units = light==true?'imperial':'metric';
                    });
                  },
                  secondary: const Icon(Icons.lightbulb_outline),
                )




              ]
          ),
        ),
      ),
        AllLocationsPage( listOfCityCards: tmp)
      ],
    );

  }

  _saveData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('weather', currentWeather!);
    prefs.setString('cityName', currentLocationName!);
    var tempWeather = prefs.get('weather');
    print('dispose method called, and weather saved as:  $tempWeather');

  }
}//_LocationWidget
