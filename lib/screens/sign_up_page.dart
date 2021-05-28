import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:demo1/screens/search_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String _email;
  String _password;
  bool passwordVisibility = false;
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance ;


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
                          height: 20,
                        ),
                        Container(
                          child: Text(
                              "Create Your Account" ,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[600]
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
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
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          width: double.infinity,
                          child: RaisedButton(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              color: Colors.lightBlueAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(30.0))
                              ),
                              onPressed: () async{
                                setState(() {
                                  showSpinner = true;
                                });
                                try{
                                  final newUser = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
                                  setState(() {
                                    showSpinner = false;
                                  });
                                  print("Email : $_email");
                                  print("Password : $_password");
                                  if(newUser != null)
                                    {
                                      Navigator.push(context, MaterialPageRoute(builder: (context){
                                        return SearchPage();
                                      }));
                                    }
                                  else{
                                    print("newUser returning Null Value");
                                  }
                                }
                                catch(e)
                                {
                                  setState(() {
                                    showSpinner = false;
                                  });
                                  print("Exception Occurs in entering email and password");
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
                                "Sign up",
                                style: TextStyle(fontSize: 20, color: Colors.white),
                              )
                          ),
                        ),
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
