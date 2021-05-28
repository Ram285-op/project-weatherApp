import 'package:flutter/material.dart';
import 'package:demo1/services/networking.dart';
import 'package:demo1/screens/result_page.dart';
import 'package:demo1/screens/error_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = "b11450d7dafa9a27f9ca239c8e1763c8" ;
const openWeatherMapUrl = 'https://api.openweathermap.org/data/2.5/weather';


class LoadingScreen extends StatefulWidget {

  LoadingScreen({this.cityName});
  final String cityName;
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  var weatherData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCityWeather(widget.cityName);
  }



  Future getCityWeather(String cityName) async
  {
    try{
      NetworkHelper networkHelper = NetworkHelper(url: '$openWeatherMapUrl?q=$cityName&appid=$apiKey');
      weatherData = await networkHelper.getData();
      print("Weather Data returning : $weatherData");
      if(weatherData == null)
      {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Error();
        }));
      }
      else{
        Navigator.push(context , MaterialPageRoute(builder: (context){
          return Report(weatherData: weatherData,);
        }));
      }
    }
    catch(e)
    {
      print(e);
      print("Exception Occurs");
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          size: 50,
          color: Colors.blue,
        ),

      )
    );
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }
}
