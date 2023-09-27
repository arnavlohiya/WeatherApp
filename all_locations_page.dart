import "package:flutter/material.dart";
import "package:weatherthree/city_card.dart";
import "package:weatherthree/location_page.dart" as loc;
import 'package:shimmer/shimmer.dart';

class AllLocationsPage extends StatelessWidget {
  Future<List<CityCard>?> listOfCityCards;

  AllLocationsPage({required this.listOfCityCards});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<CityCard>?>(
        future: listOfCityCards,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.blue!,
              child: Container(
                width: double.infinity,
                height: 200, // Adjust the height as needed
                color: Colors.white,
              ),
            ); // Show a loading indicator while waiting
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return Text('No data available');
          }

          // The future has completed, now you can access the list of CityCard widgets
          List<CityCard> ?cityCards = snapshot.data;

          return ListView.builder(
            itemCount: cityCards?.length,
            itemBuilder: (context, index) {
              return Dismissible(
                  key: ValueKey<int>(index),
                  child: cityCards![index],

              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {},child: Icon(Icons.add)),
    );

  }

  void dispose(){

  }
}








/*
class AllLocationsPage extends StatelessWidget{
  List<List<double>> detailsOfAllLocations = [[17.3850,78.4867], [12.9716,77.5946],[34.2268,77.5619]];
  Future<List<CityCard>?> listOfCityCards;
  AllLocationsPage({required this.listOfCityCards})
  @override
  Widget build(BuildContext context){
    return ListView.builder(
      itemCount: detailsOfAllLocations.length,
      itemBuilder: (context, index) {

        return listOfCityCards[index];
      },
    )
  }
}

*/