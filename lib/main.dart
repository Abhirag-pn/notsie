import 'package:bloc_test/db/notedb.dart';

import 'package:bloc_test/screens/splashscreen.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (NoteDb.instance.notedb == null) {
    await NoteDb.instance.initDb();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Notesie',
        theme: ThemeData(
          
            textTheme:  TextTheme(
              titleLarge:  const TextStyle(fontSize: 45, fontFamily: 'Jost',color: Colors.white),
                titleMedium:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                bodyMedium:const  TextStyle(fontSize: 13),
                bodySmall:
                    TextStyle(fontSize: 10, fontWeight: FontWeight.bold,color: Colors.grey.shade700)),
            primaryColor: Colors.black,
            fontFamily: 'Poppins',
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.black),
            appBarTheme: const AppBarTheme(
                color: Colors.black,
                titleTextStyle: TextStyle(fontFamily: "Jost", fontSize: 23))),
        home: const SplashScreen());
  }
}
