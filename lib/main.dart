import 'package:flutter/material.dart';
import 'package:peliculas/widgets/home.dart';

import 'package:peliculas/utils/conecction.dart';

//final internetChecker = CheckInternetConnection();  

void main() async {
  //final internetChecker = CheckInternetConnection(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
     
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const home(),
    );
  }
}
