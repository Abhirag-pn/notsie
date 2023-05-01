import 'dart:async';

import 'package:bloc_test/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
   Timer(const Duration(seconds: 2), () { 
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      return const HomeScreen();
    }));
   });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body:  Center(child: Text("Notesie",style: Theme.of(context).textTheme.titleLarge,)),
    );
  }
}