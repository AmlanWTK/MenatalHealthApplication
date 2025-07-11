import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'package:mental_health_ai/HomePageDesign/SleepSection/sleepai.dart';
import 'package:mental_health_ai/HomePageDesign/SleepSection/sleepexercise.dart';
import 'package:mental_health_ai/HomePageDesign/SleepSection/sleeptabsection.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SleepSection extends StatefulWidget {
  const SleepSection({super.key});

  @override
  State<SleepSection> createState() => _SleepSectionState();
}

class _SleepSectionState extends State<SleepSection> {

bool _isHeroVisible = false;
bool _isCalmParagraphVisible = false;
bool _istypewriting = false;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
          Color(0xFFF8F5FF), // Almost white with a hint of lavender
Color(0xFFEDE8FF), // Very pale lavender with white mix
Color(0xFFD9D0FF), // Light lilac with soft white tone



          ])
        ),

        child: SingleChildScrollView(
          child: Column(
            children: [


              //Hero Section
            VisibilityDetector(
              key: Key('hero_section'),
              onVisibilityChanged: (info){
                if(info.visibleFraction >0.3 && !_isHeroVisible){
                  setState(() {
                    _isHeroVisible=true;
                  });
                }
              },
                child: Container(
                  height: 600,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors:
                    [
                         Colors.purple.shade200,
                    Colors.white70,         // soft white
                          Colors.blue.withOpacity(0.1),  // soft neutral background instead of transparent
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight
                        
                    )
                  ),
                        
                  child: Row(
                    children: [
                      //left side 
                      Expanded(
                        flex: 1,
                        child:Padding(padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                           SizedBox(
                            height: 180,
                            child: DefaultTextStyle(
                              style:GoogleFonts.playfairDisplay(
                                fontSize: 38,
                                color: const Color(0xFF7B4B42),
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none
                
                                ), 
                              child: _isHeroVisible?
                              
                              
                               AnimatedTextKit(
                                isRepeatingAnimation: false,
                                animatedTexts: [
                                      TypewriterAnimatedText(
                                        'Sleep Stories, sleep meditations, music and soundscapes for your dreamiest sleep yet',
                                        speed: Duration(milliseconds: 100),
                                        cursor: '|'
                                      )  
                                ]
                                ):SizedBox()
                              ),
                            
                            ),
                
                            _isHeroVisible?

                            ClipRRect(
                              child: Text('''You're in the right place. Sleep offers you the tools to unwind your mind and prepare your body for deep, restful rest. From calming sleep stories to relaxing soundscapes and gentle breathing exercises, everything is designed to ease you into slumber naturally. Whether you're struggling with sleep or just want to improve your bedtime routine, there's something for every night. Let go of the day, slow your thoughts, and drift into peaceful sleep—starting right here.''',
                              style: GoogleFonts.dancingScript(
                                fontSize: 24,
                                 color: Colors.blueGrey,
                                 fontWeight: FontWeight.bold
                                ),
                              )
                              .animate()
                              .fadeIn(duration: 800.ms)
                              .slideY(begin: 0.4,end: 0,duration: 800.ms,curve: Curves.easeOut),
                            ):SizedBox(),
                            SizedBox(height: 20,),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                border: Border.all(color: Colors.white,width: 2),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                              child: Text("Sleep More",
                              style: GoogleFonts.playfairDisplay(fontSize: 18,color: Colors.black),
                              ),
                            )
                          ],
                        ),
                        
                        )
                        ),
                       Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                color: Colors.black12,
                blurRadius: 20,
                offset: Offset(0, 10),
                            )
                          ],
                        ),
                        clipBehavior: Clip.antiAlias, // Clip rounded corners
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: Lottie.asset(
                            'assets/animations/sleeping.json',
                            fit: BoxFit.cover,
                          ),
                        ),
                            ),
                          ),
                        ),
                        
                    ],
                  ),
                ),
              ),
        
              SizedBox(height: 50,),
              Center(
                child: Text("Breathe, Relax, and Surrender: The Path to Better Sleep Begins Here",
                style: GoogleFonts.playfairDisplay(
                  fontSize: 38,
                   color: const Color(0xFF7B4B42),
                   fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(height: 50,),
        
       SleepTabSection(),
         SizedBox(height: 40,),
       SleepAi(),
        
             SizedBox(height: 40,),

             VisibilityDetector(
              key: Key("typewriting_key"),
              onVisibilityChanged: (info){
                if(info.visibleFraction>0.3 && !_istypewriting){
                  setState(() {
                    _istypewriting=true;
                  });
                }
              },
               child: SizedBox(
                height: 60,
                child: DefaultTextStyle(
                  style: GoogleFonts.playfairDisplay(
                    color: const Color(0xFF7B4B42),
                    fontWeight: FontWeight.bold,
                     decoration: TextDecoration.none,
                     fontSize: 38
                  ), 
               
                  
                  child:_istypewriting?
                  
                   AnimatedTextKit(
                    isRepeatingAnimation: false,
                    animatedTexts: [
                         TypewriterAnimatedText('Whispering Dreams: Unlock the Secrets to a Peaceful Night’s Rest',
                         speed: Duration(milliseconds: 100),
                         cursor: '|'
                         )
                  ]):Text('Whispering Dreams: Unlock the Secrets to a Peaceful Night’s Rest')

                  ),
               ),
             ),
           
        
             SizedBox(height: 16,),
             Text("Explore these calming meditation videos to relax your body and soothe your mind.",
             style: GoogleFonts.dancingScript(fontSize: 29,
             color: Colors.blueGrey,
             fontWeight: FontWeight.bold,
             decoration: TextDecoration.none
             ),
             ),
             SizedBox(height: 16,)
        ,
            Sleepexercise()
        
            ],
        
            
          ),
        ),
      ),
    );
  }
}