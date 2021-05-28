import 'package:demo1/screens/forgot_password_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:demo1/screens/search_page.dart';
import 'package:demo1/screens/sign_up_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  String _email;
  String _password;
  bool passwordVisibility = false;
  bool showSpinner = false;

  final _auth = FirebaseAuth.instance;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App" , style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blueGrey,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.cloud , size: 100, color: Colors.lightBlueAccent,),
                        Text(
                          "CLOUDIFY" ,
                          style: TextStyle(fontSize: 25 ,color: Colors.grey[600] , fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Your Email",
                            prefixIcon: Icon(Icons.email),
                            //border: InputBorder.none
                          ),
                          onChanged: (value) {
                            _email = value ;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Your Password",
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: (){
                                setState(() {
                                  passwordVisibility = !passwordVisibility;
                                });
                              },
                              icon: passwordVisibility ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                            )
                          ),
                          obscureText: !passwordVisibility,
                          onChanged: (value){
                            _password = value;
                          },
                        ),
                        SizedBox(height: 15,),
                        Container(
                          alignment: Alignment(1.0, 0.0),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return ForgotPassword();
                              }));
                            },
                            child: Text("Forgot Password" ,
                              style: TextStyle(
                                //letterSpacing: 1.0,
                                color: Colors.lightBlue ,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: double.infinity,
                          child: RaisedButton(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              color: Colors.lightBlueAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(30.0))
                              ),
                              onPressed: () async {
                                setState(() {
                                  showSpinner = true;
                                });
                                try{
                                  final user = await _auth.signInWithEmailAndPassword(email: _email, password: _password);
                                  setState(() {
                                    showSpinner = false;
                                  });
                                  print("Email : $_email");
                                  print("Password : $_password");
                                  if(user != null)
                                    {
                                      Navigator.push(context, MaterialPageRoute(builder: (context){
                                        return SearchPage();
                                      }));
                                    }
                                  else{
                                    print("signing in returning null value");
                                  }
                                }
                                catch(e)
                                {
                                  setState(() {
                                    showSpinner = false;
                                  });
                                  print("Error Occurs in signing in");
                                  print(e);
                                  //print(e.message);
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
                                  "Sign in",
                                style: TextStyle(fontSize: 20, color: Colors.white),
                              )
                          ),
                        ),
                        SizedBox(
                          height: 90,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "New User ?",
                              style: TextStyle(
                                  fontSize: 20
                              ),
                            ),
                            SizedBox(width: 10,),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return Signup();
                                  }
                                ));
                              },
                              child: Text(
                                "Sign up" ,
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 20,
                                    color: Colors.lightBlue
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
