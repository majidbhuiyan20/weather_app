import 'package:flutter/material.dart';
import 'package:weather_app/worker/worker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  late String city = "Rajshahi";
  late String temp;
  late String hum;
  late String air_speed;
  late String des;
  late String main;
  late String icon;



  void startApp(String city) async
  {
    worker instance = worker(location: city);
    await instance.getData();

    temp = instance.temp;
    air_speed = instance.air_speed;
    hum = instance.humidity;
    des = instance.description;
    main = instance.main;
    icon = instance.icon;
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        "temp_value": temp,
        "hum_value": hum,
        "air_speed_value": air_speed,
        "des_value": des,
        "main_value": main,
        "icon_value": icon,
        "city_value": city,
      });
    });


  }

  @override
  void initState() {

    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {

    final routeArgs = ModalRoute.of(context)?.settings.arguments;
    if (routeArgs != null && routeArgs is Map) {
      final Map search = routeArgs as Map;
      city = search['searchText'];
    } else {
      // Handle the case where arguments are null or not a Map
      city = 'City'; // Provide a default value or handle the error accordingly
    }
    startApp(city);

    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 30,),
        Image(image: AssetImage('assets/weather.png'), height: 240, width: 240,),
            Text("Weather App",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            ),
            SizedBox(height: 4,),
            Text("Made by Majid",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w400,
              color: Colors.white
            ),
            ),

      SizedBox(height: 20,),
      SpinKitWave(
        color: Colors.white,
        size: 50.0,
      ),
          ],
        ),
      ),
      backgroundColor: Colors.blue,
    );
  }
}
