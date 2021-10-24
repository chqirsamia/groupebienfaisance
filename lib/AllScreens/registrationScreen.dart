import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:groupe_bienfaisance/AllScreens/loginScreen.dart';
import 'package:groupe_bienfaisance/AllScreens/mainscreen.dart';
import 'package:groupe_bienfaisance/main.dart';

class RegistrationScreen extends StatelessWidget {
  static const String idScreen = "registration";
  TextEditingController nom = TextEditingController();
  TextEditingController prenom = TextEditingController();
  TextEditingController emailec = TextEditingController();
  TextEditingController telephone = TextEditingController();
  TextEditingController passwordec = TextEditingController();
  TextEditingController datenaissance = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
                children: [
                  SizedBox(height: 35.0,),
                  Image(
                    image: AssetImage("images/logo.png"),
                    width: 390.0,
                    height: 250.0,
                    alignment: Alignment.center,
                  ),
                  SizedBox(height: 1.0,),
                  Text(
                    "créer un compte",
                    style: TextStyle(fontSize: 24.0, fontFamily: "Brand Bold"),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        SizedBox(height: 1.0,),
                        TextField(
                          controller: nom,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "nom",
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
                        SizedBox(height: 1.0,),
                        TextField(
                          controller: prenom,

                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Prénom",
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
                        SizedBox(height: 1.0,),
                        TextField(
                          controller: telephone,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: "téléphone",
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
                        SizedBox(height: 1.0,),
                        TextField(
                          controller: datenaissance,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            labelText: "date de naissance",
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
                        SizedBox(height: 1.0,),
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
                        SizedBox(height: 1.0,),
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
                              child: Text("créer un compte",
                                style: TextStyle(
                                    fontSize: 18.0, fontFamily: "Brand Bold"),

                              ),
                            ),
                          ),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(24.0)
                          ),
                          onPressed: () {
                            if(nom.text.length<2)
                              {
                                displayToastMessage("le nom doit au moins comporter 3 lettres", context);
                              }
                            else if(!emailec.text.contains("@"))
                              displayToastMessage("s'il vous plait entrez une adresse email valide", context);
                            else if(telephone.text.isEmpty)
                              displayToastMessage("s'il vous plait entrez un numéro de téléphone", context);
                            else
                            createNewUser(context);
                          },
                        ),

                      ],
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, LoginScreen.idScreen, (route) => false);
                    },
                    child: Text("se connecter"),
                  )

                ]
            ),
          ),
        ));
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  void createNewUser(BuildContext context) async {
    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: emailec.text, password: passwordec.text).catchError((onError)
    {
      displayToastMessage("ERREUR:"+onError.toString(),context);
    });
       final User firebaseUser = result.user;
       if (firebaseUser != null)
         {
           Users.child(firebaseUser.uid);
           Map userDataMap={
             "nom":nom.text.trim(),
             "prenom":prenom.text.trim(),
             "telephone":telephone.text.trim(),
             "email":emailec.text.trim(),
             "password":passwordec.text.trim(),
             "datenaissance":datenaissance.text.trim()
           };
           Users.child(firebaseUser.uid).set(userDataMap);
           Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
       }
         else {
         displayToastMessage("une erreur est survenue veuillez ressayer",context);

       }
  }
  displayToastMessage(String message,BuildContext context)
  {
    Fluttertoast.showToast(msg: message);

  }
}