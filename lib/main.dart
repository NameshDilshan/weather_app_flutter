

import 'package:flutter/material.dart';
import 'package:weatherapp/services/flutter_api_client.dart';
import 'package:weatherapp/views/additional_information.dart';
import 'package:weatherapp/views/current_weather.dart';

import 'model/weather_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  WeatherApiClient client = WeatherApiClient();
  Weather? data ;



  Future<void> getData() async {

    // Location? location  = Location();
    // var servicesEnabled = await location!.serviceEnabled();
    //
    // if(!servicesEnabled){
    //   servicesEnabled = await location!.requestService();
    //   if(!servicesEnabled){
    //     return;
    //   }
    // }
    //
    // var _permissionGranted = await location!.hasPermission();
    // if(_permissionGranted == PermissionStatus.denied){
    //   _permissionGranted = await location!.requestPermission();
    // }
    // if(_permissionGranted != PermissionStatus.granted){
    //   return;
    // }
    //
    //
    // LocationData? currentLocation = await location!.getLocation();
    // var address = await Geocoder.local.findAddressesFromCoordinates(Coordinates(currentLocation.latitude, currentLocation.longitude));
    // String yourCityName = address.first.locality;

    data = await client.getCurrentWeather("Ja-Ela");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf9f9f9),
      appBar: AppBar(
        backgroundColor: Color(0xFFf9f9f9),
        elevation: 0.0,
        title: const Text(
          "Weather App",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu), color: Colors.black,),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                currentWeather(Icons.wb_sunny_rounded, "${data!.temp}\u1d3cF", "Namesh's City : ${data!.cityName} 😋"),
                SizedBox(height: 60.0,
                ),
                Text(
                  "Additional Information",
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Color(0xdd212121),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(),
                SizedBox(
                  height: 20.0,
                ),
                additionalInformatoin("${data!.wind}", "${data!.humidity}", "${data!.pressure}", "${data!.feels_like}")
              ],
            );
          }else if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
            child: CircularProgressIndicator(),
            );
          }
          return Container();
        },

      ),
    );
  }
}

