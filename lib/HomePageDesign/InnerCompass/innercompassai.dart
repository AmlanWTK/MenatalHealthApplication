import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mental_health_ai/HomePageDesign/InnerCompass/Innercompasschatai.dart';
import 'package:visibility_detector/visibility_detector.dart';



class Innercompassai extends StatefulWidget {
  const Innercompassai({super.key});

  @override
  State<Innercompassai> createState() => _InnercompassaiState();
}

class _InnercompassaiState extends State<Innercompassai> {
  bool _issection=false;
  @override
  Widget build(BuildContext context) {
    return 

  

       VisibilityDetector(
        key: Key('section_key'),
        onVisibilityChanged: (info) {
          if(info.visibleFraction > 0.3 && !_issection){
            setState(() {
              _issection=true;
            });
          }
        },

         child:AnimatedOpacity(
          opacity:_issection?1.0:0.0 ,
           duration: Duration(milliseconds: 800),
           child: AnimatedSlide(
            offset: _issection?Offset(0, 0):Offset(0, 0.3),
     curve: Curves.easeOut,
            duration: Duration(milliseconds: 800),
            child:  Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              child: Container(
                height: 630,
                width: double.infinity,
               decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.blueGrey,width: 4
                ),
                gradient: LinearGradient(colors: [
                   Colors.green.shade200,  // one greenish shade
                Colors.teal.shade100,         // soft white
                Colors.blue.withOpacity(0.02),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                )
               ),
               child: Row(
                children: [
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
              'assets/animations/meditation2.json',
              fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              
              
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text("Discover the Power of Stillness: Your Gentle Introduction to Meditation",
                           style: GoogleFonts.playfairDisplay(
                            fontSize: 38,
                            color: const Color(0xFF7B4B42),
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none
                           ),
                           ),
                           SizedBox(height: 20,),
              
                           Text('''Meditation doesn’t have to be intimidating. We’ve designed simple, guided experiences that help you slow down, breathe deeply, and connect with yourself. Whether you're new or returning, our beginner-friendly programs help you:\n
         Understand the core principles of mindfulness
         Develop a consistent habit with ease
         Handle stress and distractions gently''',
                           style: GoogleFonts.dancingScript(
                             color: Colors.blueGrey.shade700,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            decoration: TextDecoration.none
                            ),
                           ),
                           SizedBox(height: 40,),
                          ElevatedButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>InnerCompassChatAi()));
                              }, 
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey.shade100,
                                padding: EdgeInsets.symmetric(horizontal: 34,vertical: 22),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                    color: Colors.white,
                                    width: 3
                                  )
                                ),
                                elevation: 0,
                                
                              ),
                              child: Text("Plan With Ai",
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey
                              ),
                              )),
                        
                        ],
                      ),
                    )
                    )
                ],
               ),
              ),
            ),
          ],
               ),
            ),
           )
         
         
         
       );
   
  }
}
