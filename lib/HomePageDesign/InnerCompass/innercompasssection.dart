import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_health_ai/HomePageDesign/InnerCompass/innercompassai.dart';
import 'package:mental_health_ai/HomePageDesign/InnerCompass/innercompasstabsection.dart';

class InnerCompassSection extends StatelessWidget {
  const InnerCompassSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5FAFD),
      body: SingleChildScrollView(
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
                           color: const Color(0xFF7B4B42),
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
                      child: Container(
                        height: double.infinity,
                        child: Image.network("https://i.imgur.com/GrkAwQQ.jpeg",
                        fit: BoxFit.cover,
                        ),
                      )
                      )

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
 SizedBox(height: 50),
           SizedBox(
            height: 500,
            child: Innercompassai(),
           )

          ],

          
        ),
      ),
    );
  }
}