import 'package:flutter/material.dart';
import 'package:banking/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context,snapshot){
      if(snapshot.hasError) {
        print("Something went Wrong");
      }
      if(snapshot.connectionState == ConnectionState.done) {
        return MaterialApp(
          title: 'BANKING-APP',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        );
      }
      return CircularProgressIndicator();
    },
    );
  }
}


