import 'dart:convert';
import 'package:http/http.dart';

class worker{
  late String location;

  worker({required this.location})
  {
    location = this.location;
  }

  late String temp;
  late String humidity;
  late String air_speed;
  late String description;
  late String main;
  late String icon;


  Future<void>  getData() async
  {
    try
    {
      //Response response= await get("https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=77b6453f34f0c7998ad58c001cfc4fdb" as Uri);
      Response response = await get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$location&appid=77b6453f34f0c7998ad58c001cfc4fdb"));
      Map data = jsonDecode(response.body);

      //Getting Temp, humidity
      Map temp_data = data['main'];
      double getTemp = temp_data['temp']-273.15;
      String  getHumidity= temp_data['humidity'].toString();

      //Getting AirSpeed
      Map wind = data['wind'];
      double getAir_speed = wind['speed']/0.2777777778;



//Getting Description.....
      List weather_data = data['weather'];
      Map weather_main_data = weather_data[0];
      String getMain_des = weather_main_data['main'];
      String getDesc = weather_main_data['description'];





      // Assigning the values to the class variables
      temp = getTemp.toStringAsFixed(1);//c
      humidity = getHumidity.toString();//%
      air_speed = getAir_speed.toStringAsFixed(1);//km/h
      description = getDesc;
      main = getMain_des;
      icon = weather_main_data['icon'].toString();
    }
    catch(e)
    {
      temp = "NA";
      humidity ="NA";
      air_speed = "NA";
      description ="Can't Find Data";
      main = "NA";
      icon = "09d";
    }



  }




}


