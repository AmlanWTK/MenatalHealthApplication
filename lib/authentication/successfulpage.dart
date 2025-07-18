import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mental_health_ai/HomePageDesign/homepage1.dart';

class LoginSuccess extends StatefulWidget {
  const LoginSuccess({super.key});

  @override
  State<LoginSuccess> createState() => _LoginSuccessState();
}

class _LoginSuccessState extends State<LoginSuccess> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 5), (){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Homepage1()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          height: 600,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 30),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.cyan.shade100, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.cyanAccent.withOpacity(0.3),
                offset: const Offset(3, 3),
                blurRadius: 5,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Colors.white.withOpacity(0.8),
                offset: const Offset(-3, -3),
                blurRadius: 5,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            children: [
              // Left side: Lottie animation
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 12,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Lottie.asset(
                    'assets/animations/loginsuccess.json',
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Right side: Title, description, buttons
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                   SizedBox(
                    height: 60,
                    child: DefaultTextStyle(
                      style:GoogleFonts.playfairDisplay(
                        fontSize: 38,color: const Color(0xFF7B4B42),
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none
                ) , 
                      child: AnimatedTextKit(animatedTexts: [
                        TypewriterAnimatedText('You are Successfully Logged In',
                        speed: Duration(milliseconds: 100),
                        cursor: "|"
                        )
                      ])
                      ),
                   ),


                    
                     
                     
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  
  }
}