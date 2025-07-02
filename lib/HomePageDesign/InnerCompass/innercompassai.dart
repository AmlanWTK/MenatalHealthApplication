import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_health_ai/HomePageDesign/SleepSection/sleepchatai.dart';


class Innercompassai extends StatelessWidget {
  const Innercompassai({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
       Column(
        children: [
          Container(
            height: 500,
            width: double.infinity,
           decoration: BoxDecoration(
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
                child: Container(
                  height: double.infinity,
                  child: Image.network("https://i.imgur.com/M0lvP9Y.jpeg",
                  fit: BoxFit.cover,
                  ),
                )
              ),

              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text("Plan your perfect night’s rest with your own AI sleep assistant",
                       style: GoogleFonts.playfairDisplay(
                        fontSize: 38,
                        color: const Color(0xFF7B4B42),
                        fontWeight: FontWeight.bold
                       ),
                       ),
                       SizedBox(height: 20,),

                       Text("Discover a new way to unwind. Whether you're an early riser or a night owl, our AI gently guides you to set personalized sleep schedules that fit your lifestyle. Just share how you're feeling, and let your assistant craft a calm, restful journey to dreamland — perfectly timed for you.",
                       style: GoogleFonts.dancingScript(
                         color: const Color(0xFF7B4B42),
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        ),
                       ),
                       SizedBox(height: 40,),
                      ElevatedButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SleepChatAi()));
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
        ],
      ),
    );
  }
}
