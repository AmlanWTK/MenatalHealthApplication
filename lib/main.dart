import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mental_health_ai/Emergency/emergencypage.dart';
import 'package:mental_health_ai/GratitudeWall/gratitideentrypage.dart';
import 'package:mental_health_ai/GratitudeWall/gratitudeopeningsection.dart';
import 'package:mental_health_ai/GratitudeWall/gratitudewall.dart';
import 'package:mental_health_ai/HomePageDesign/InnerCompass/innercompassai.dart';
import 'package:mental_health_ai/HomePageDesign/InnerCompass/innercompassexercise.dart';
import 'package:mental_health_ai/HomePageDesign/InnerCompass/innercompasssection.dart';
import 'package:mental_health_ai/HomePageDesign/MoodSection/dailymood.dart';
import 'package:mental_health_ai/HomePageDesign/MoodSection/moodsectionopening.dart';
import 'package:mental_health_ai/HomePageDesign/MoodSection/selectionscreen.dart';
import 'package:mental_health_ai/HomePageDesign/SleepSection/sleepai.dart';
import 'package:mental_health_ai/HomePageDesign/SleepSection/sleepsection.dart';
import 'package:mental_health_ai/HomePageDesign/SleepSection/sleeptabsection.dart';
import 'package:mental_health_ai/HomePageDesign/wellnesssection.dart';
import 'package:mental_health_ai/Notepad/intropage.dart';
import 'package:mental_health_ai/Notepad/journalpage.dart';
import 'package:mental_health_ai/Notepad/notepadsection.dart';
//import 'package:mental_health_ai/appbar/aranyakappbar.dart';
import 'package:mental_health_ai/authentication/authselectionpage.dart';
import 'package:mental_health_ai/authentication/loginpage.dart';
import 'package:mental_health_ai/authentication/signuppage.dart';
import 'package:mental_health_ai/authentication/successfulpage.dart';
import 'package:mental_health_ai/homepage.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mental_health_ai/HomePageDesign/homepage1.dart';
import 'package:mental_health_ai/mooddetection/moodquizpage.dart';
import 'package:mental_health_ai/onboardingscreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {

//loading my env variables
await dotenv.load();
await Hive.initFlutter();
await Hive.openBox('mood_history');

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
    home: user!=null? Homepage1(): AuthSelectionPage(),

  //home:Homepage1(),
  
  // home: Gratitudeopeningsection(),
    //home: LoginSuccess(),
  // home: GratitudeEntryPage(),
  //home: Gratitudeopeningsection(),
 //home: AuthSelectionPage(),
//home: InnerCompassSection(),
 //home: Innercompassexercise(),
 //home: Emergencypage(),
//  home: IntroPage(),
//home: SleepTabSection()

//home: SleepSection(),


//home:NotePadSection(),

//home: Emergencypage(),
//home: GratitudeWall(),
//home: GratitudeInputTest(),




//home: SelectionScreen(),
//home: DailyMood(),
   );
  }
}

