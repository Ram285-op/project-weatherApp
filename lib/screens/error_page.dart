import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
        title: Text("Weather App" , style: TextStyle(color: Colors.white),),
    backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Some Error Occured, Invalid City Name!" ,
              style: TextStyle(fontSize: 20 , color: Colors.red),
            ),
            Image(height: 25,image: AssetImage('images/blue_emoji.jpeg'))
          ],
        ),
      ),
    );
  }
}
