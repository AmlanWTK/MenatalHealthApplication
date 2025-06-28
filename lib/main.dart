import 'package:flutter/material.dart';
import 'package:mental_health_ai/Notepad/intropage.dart';
import 'package:mental_health_ai/authentication/authselectionpage.dart';
import 'package:mental_health_ai/authentication/signuppage.dart';
import 'package:mental_health_ai/homepage.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mental_health_ai/mooddetection/moodquizpage.dart';
import 'package:mental_health_ai/onboardingscreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {

//loading my env variables
await dotenv.load();

//initialize supbase
await Supabase.initialize(
   url: dotenv.env['SUPABASE_URL']!,
   anonKey: dotenv.env['SUPABASE_ANON_KEY']!
);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final supabase=Supabase.instance.client;
    final user=supabase.auth.currentUser;//check if the user session exists
   return MaterialApp(
    debugShowCheckedModeBanner: false,
  //  home: user!=null? Homepage():Authselectionpage(),
  home: IntroPage(),
   );
  }
}

