import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _auth = FirebaseAuth.instance;
  String _email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App" , style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(25),
          padding: EdgeInsets.all(10),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.lightBlue[50],
                  radius: 70,
                  child: Icon(Icons.lock , size: 80, color: Colors.lightGreen,)
              ),
              SizedBox(height: 20,),
              Text(
                  "Forgot Your Password?" ,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Enter Your email and we'll send you a link to reset your password." ,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                ),
              ),
              SizedBox(
                height: 60,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter Your Email" ,
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Icon(Icons.email),
                  ),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _email = value;
                },
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                  onPressed: () async {
                    try{
                      await _auth.sendPasswordResetEmail(email: _email);
                    }
                    catch(e)
                    {
                      print("Exception occurs in reset password");
                      print(e);
                      AlertDialog alert =AlertDialog(
                        title: Text("Error"),
                        titleTextStyle: TextStyle(color: Colors.red , fontSize: 20),
                        content: Text(
                            e.message
                        ),
                        actions: [
                          OutlineButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: Text('Close'),
                            textColor: Colors.red,
                            disabledTextColor: Colors.red,
                            highlightedBorderColor: Colors.red,
                          ),
                        ],
                      );
                      showDialog(context: context , builder: (context) {
                        return alert;
                      });
                    }

                  },
                  child: Text(
                      "Send Recovery Email" ,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                    ),
                  ),
                  color: Colors.green,
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Back to Login" ,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    ),
                  ),
                  color: Colors.lightBlueAccent,
                ),
              ),
            ],

          ),
        ),
      ),
    );
  }
}
