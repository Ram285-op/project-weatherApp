import 'package:flutter/material.dart';

class Report extends StatefulWidget {
  Report({this.weatherData});
  final weatherData;

  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  var weatherData ;
  double temperature;
  String weather;
  int humidity;
  double windSpeed;
  double maxTemperature;
  double minTemperature;
  String cityName;

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    weatherData = widget.weatherData;
    update(weatherData);
  }

  void update(dynamic weatherData)
  {
    setState(() {
      temperature = weatherData['main']['temp'];
      weather = weatherData['weather'][0]['main'];
      humidity = weatherData['main']['humidity'];
      windSpeed = weatherData['wind']['speed'];
      maxTemperature = weatherData['main']['temp_max'];
      minTemperature = weatherData['main']['temp_min'];
      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
        title: Text("Weather App" , style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Container(
          //height: MediaQuery.of(context).size.height*0.55,
          margin: EdgeInsets.only(top: 50),
          //padding: EdgeInsets.all(20),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Currently in $cityName" ,
                style: TextStyle(fontSize: 30 , color: Colors.blueGrey[600] , fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "$temperature°F" ,
                style: TextStyle(fontSize: 28, color: Colors.grey[600]),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InsertRow(icon: Icons.wb_sunny , colour: Colors.yellow[600], content: "Temperature", result: "$temperature°F",),
                    SizedBox(height: 20,),
                    InsertRow(icon: Icons.cloud, colour: Colors.grey[400] , content: "Weather", result: "$weather",),
                    SizedBox(height: 20,),
                    InsertRow(icon: Icons.grain_rounded,colour: Colors.blue , content: "Humidity", result: "$humidity%",),
                    SizedBox(height: 20,),
                    InsertRow(icon: Icons.assistant_photo_sharp ,colour: Colors.blue, content: "Wind Speed", result: "${windSpeed}m/s",),
                    SizedBox(height: 20,),
                    InsertRow(icon: Icons.brightness_7,colour: Colors.yellow[600] ,  content: "Temp Max", result: "$maxTemperature°F",),
                    SizedBox(height: 20,),
                    InsertRow(icon: Icons.brightness_5 , colour: Colors.yellow[600], content: "Temp Min", result: "$minTemperature°F",),
                    //SizedBox(height: 20,)

                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}

class InsertRow extends StatelessWidget {
  final IconData icon;
  final String content;
  final String result;
  final Color colour ;

  InsertRow({@required this.icon,@required this.content,@required this.result ,@required this.colour });

  @override
  Widget build(BuildContext context) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.start,
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 40,),
        Icon( icon , color: colour, size: 25,),
        SizedBox(width: 40,),
        Text(
          content ,
          style: TextStyle(fontSize: 22,color: Colors.grey[600] , fontWeight: FontWeight.w600),
        ),
        //SizedBox(width: 40,),
        Spacer(),
        Text(
          result ,
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 22, color: Colors.grey[600],),
        ),
        SizedBox(
          width: 30,
        )
      ],
    );
  }
}
