
import 'package:flutter/material.dart';
import 'Mapping.dart';
import 'Authentication.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ปันสุข',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MappingPage(auth: Auth(),), 

    );
  }
}


