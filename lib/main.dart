import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:groupe_bienfaisance/AllScreens/mainscreen.dart';
import 'package:groupe_bienfaisance/AllScreens/loginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:groupe_bienfaisance/AllScreens/registrationScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
DatabaseReference Users=FirebaseDatabase.instance.reference().child("users");
class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'groupe de bienfaisance',
      theme: ThemeData(
        fontFamily:'Signatra' ,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: LoginScreen(),
      initialRoute: RegistrationScreen.idScreen,
      routes: {
        RegistrationScreen.idScreen:(context)=> RegistrationScreen(),
        LoginScreen.idScreen:(context)=> LoginScreen(),
        MainScreen.idScreen:(context)=>MainScreen() ,


      },
      debugShowCheckedModeBanner: false,
    );
  }
}


