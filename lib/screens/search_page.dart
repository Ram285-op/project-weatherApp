import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'result_page.dart';
import 'package:demo1/screens/loading_screen.dart';
import 'package:demo1/services/networking.dart';



class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController inputController = TextEditingController();
  String input;
  var weatherData;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }
  @override
  void dispose() {
    super.dispose();
    inputController.dispose();
  }

  void getCurrentUser() async
  {
    try{
      final user = await _auth.currentUser();
      if(user!=null)
      {
        loggedInUser = user;
        print("Current User sign in : ${loggedInUser.email}");
      }
    }
    catch(e)
    {
      print("Exception Occurs in returning the current user");
      print(e);
    }
  }

  void getCityWeather(String cityName) async
  {
    NetworkHelper networkHelper = NetworkHelper(url: '$openWeatherMapUrl?q=$cityName&appid=$apiKey');
    weatherData = await networkHelper.getData();

    Navigator.push(context , MaterialPageRoute(builder: (context){
      return Report(weatherData: weatherData,);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App" , style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
          onPressed: ()async{
            await _auth.signOut();
            print("${loggedInUser.email} sign out");
            loggedInUser = null;
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 40),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      "Search Weather",
                      style: TextStyle(color: Colors.blueGrey[700] , fontSize: 40 , fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Instantly",
                      style: TextStyle(color: Colors.blueGrey[600] , fontSize: 40 ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Form(
                      key: formkey,
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.7,
                        child: TextFormField(
                          controller: inputController,
                          decoration: InputDecoration(
                              prefixIcon: IconButton(
                                onPressed: () {
                                  if(!formkey.currentState.validate())
                                  {
                                    print("Not Validate");
                                  }
                                  else{
                                    print("City Name : $input");
                                    Navigator.push(context , MaterialPageRoute(builder: (context) {
                                      return LoadingScreen(cityName: input);
                                    }));
                                  }
                                  inputController.clear();
                                },
                                icon: Icon(Icons.search),
                              ),
                              hintText: "Enter City Name" ,
                              hintStyle: TextStyle(color: Colors.blueGrey[700])
                          ),
                          validator: (value) {
                            if(value.isEmpty)
                            {
                              String space = "                 " ;
                              return "${space}City Name is Required" ;
                            }
                            else{
                              input = value;
                              return null;
                            }
                          },
                          //autofocus: true,
                          //keyboardType: TextInputType.text,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
