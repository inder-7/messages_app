import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messages_app/services/auth/auth_gate.dart';
import 'package:messages_app/firebase_options.dart';
import 'package:messages_app/themes/light_mode.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      home: const AuthGate(),
    );
  }
}