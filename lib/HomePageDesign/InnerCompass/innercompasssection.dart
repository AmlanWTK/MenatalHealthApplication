import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mental_health_ai/HomePageDesign/InnerCompass/innercompassai.dart';
import 'package:mental_health_ai/HomePageDesign/InnerCompass/innercompassexercise.dart';
import 'package:mental_health_ai/HomePageDesign/InnerCompass/innercompasstabsection.dart';

class InnerCompassSection extends StatelessWidget {
  const InnerCompassSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
             Color(0xFFE0F7FA), // Very light blue
        Color(0xFFD0F0EC), // Light blue-green blend (optional)
        Color(0xFFE8F5E9), // Very light mint green
          ])
        ),

        child: SingleChildScrollView(
          child: Column(
            children: [
              //Hero Section
              Container(
                height: 500,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors:
                  [
          Colors.green.shade200,  // one greenish shade
          Colors.teal.shade100,         // soft white
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
                          Text("Mindfulness, meditation and guided programs to build healthy habits that will last a lifetime",
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 38,
                             color: const Color(0xFF7B4B42),
                             fontWeight: FontWeight.bold
                            ),
                          ), 
                          SizedBox(height: 20,),
                          Text("You're in the right place. Calm puts the tools to achieve mindfulness in your back pocket with guided meditations, soothing music, and daily guided programs designed to fit into your lifestyle in practical ways.",
                          style: GoogleFonts.dancingScript(
                            fontSize: 24,
                             color: Colors.blueGrey,
                             fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 20,),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              border: Border.all(color: Colors.white,width: 2),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                            child: Text("Live Mindfully",
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
            'assets/animations/meditation1.json',
            fit: BoxFit.cover,
          ),
        ),
            ),
          ),
        ),
        
                  ],
                ),
              ),
        
              SizedBox(height: 50,),
              Center(
                child: Text("Mindfulness tools for a calmer mind and a more fulfilling life.",
                style: GoogleFonts.playfairDisplay(
                  fontSize: 38,
                   color: const Color(0xFF7B4B42),
                   fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(height: 50,),
        
        InnerCompassTabSection(),
         SizedBox(height: 40,),
         Innercompassai(),
        
             SizedBox(height: 40,),
             Text("Gentle Moments to Ease Your Mind and Restore Your Inner Calm",
             style: GoogleFonts.playfairDisplay(fontSize: 38,
               color: const Color(0xFF7B4B42),
               fontWeight: FontWeight.bold,
               decoration: TextDecoration.none
             ),
             ),
        
             SizedBox(height: 16,),
             Text("Explore these calming meditation videos to relax your body and soothe your mind.",
             style: GoogleFonts.dancingScript(fontSize: 20,
             color: Colors.blueGrey,
             fontWeight: FontWeight.bold,
             decoration: TextDecoration.none
             ),
             ),
             SizedBox(height: 16,)
        ,
             Innercompassexercise()
        
            ],
        
            
          ),
        ),
      ),
    );
  }
}