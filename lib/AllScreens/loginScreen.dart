import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:groupe_bienfaisance/AllScreens/registrationScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:groupe_bienfaisance/AllScreens/mainscreen.dart';
import 'package:groupe_bienfaisance/main.dart';

class LoginScreen extends StatelessWidget {
  static const String idScreen="login";
  TextEditingController passwordec = TextEditingController();
  TextEditingController emailec = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body:SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(8.0),
          child: Column(
            children:[
              SizedBox(height:35.0,),
              Image(
                image:AssetImage("images/logo.png"),
                width: 390.0,
                height: 250.0,
                alignment: Alignment.center,
              ),
              SizedBox(height:1.0,),
              Text(
                "login",
                style: TextStyle(fontSize:24.0,fontFamily: "Brand Bold"),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child:Column(
                  children: [
                    SizedBox(height:1.0,),
                    TextField(
                      controller: emailec,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 10.0,
                        ),

                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(height:1.0,),
                    TextField(
                      controller: passwordec,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 10.0,
                        ),

                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(height: 15.0,),
                    RaisedButton(
                      color: Colors.purple,
                      textColor: Colors.white,
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text("se connecter",
                            style: TextStyle(fontSize: 18.0,fontFamily: "Brand Bold"),

                          ),
                        ),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(24.0)
                      ),
                      onPressed: ()
                      {
                       login(context);

                      },
                    ),

                  ],
                ),
              ),
              FlatButton(
                onPressed: ()
                {
                  Navigator.pushNamedAndRemoveUntil(context, RegistrationScreen.idScreen, (route) => false);
                },
                child: Text("créer un compte"),
              )

]
          ),
        ),
      ));
  }
  final FirebaseAuth auth = FirebaseAuth.instance;
  void login(BuildContext context) async {
    UserCredential result = await auth.signInWithEmailAndPassword(email:emailec.text, password: passwordec.text)
        .catchError((onError){
      {
        displayToastMessage("ERREUR:"+onError.toString(),context);
      }});
    final User firebaseUser = result.user;
    if (firebaseUser != null)
    {
     Users.child(firebaseUser.uid).once().then( (DataSnapshot snap){
       if (snap.value != null)
         {
           Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen,(route)=> false);
           displayToastMessage("vous étes connectés avec succés",context);
         }
     });
    }
    else {
      auth.signOut();
      displayToastMessage("une erreur est survenue veuillez ressayer",context);

    }

  }
  displayToastMessage(String message,BuildContext context)
  {
    Fluttertoast.showToast(msg: message);

  }
}
