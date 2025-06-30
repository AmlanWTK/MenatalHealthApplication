import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_health_ai/HomePageDesign/SleepSection/sleepai.dart';
import 'package:mental_health_ai/HomePageDesign/SleepSection/sleeptabsection.dart';

class SleepSection extends StatelessWidget {
  const SleepSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5FAFD),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            Container(
              height: 500,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade100,
                    Colors.white70,
                  Color(0xFFF8EDE3),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Row(
                children: [
                  // Left side - Text
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sleep Stories, sleep meditations, music and soundscapes for your dreamiest sleep yet",
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 38,
                              color: const Color(0xFF7B4B42),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Join millions of sound sleepers worldwide. Fall asleep easily and naturally with our Sleep Stories, sleep meditations, exclusive sleep music and sleep sounds. With hundreds of titles to choose from, you'll be drifting off to dreamland in no time. Just press play and drift away.",
                            style: GoogleFonts.dancingScript(
                              color: const Color(0xFF7B4B42),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 20),
                            child: Text(
                              "Sleep Better",
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  // Right side - Image
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: double.infinity,
                      child: Image.network(
                        "https://i.imgur.com/TkrgWQF.jpeg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
            ),

            // Additional content section (optional)
            const SizedBox(height: 50),
    Center(
      child: Text("The easiest way to get better sleep",
      style: GoogleFonts.playfairDisplay(fontSize:38, color: const Color(0xFF7B4B42),fontWeight: FontWeight.bold ),
      ),
    ),
const SizedBox(height: 50),
            SleepTabSection(),
            const SizedBox(height: 50),

            Center(
      child: Text("Smart Sleep Planning, Made Gentle",
      style: GoogleFonts.playfairDisplay(fontSize:38, color: const Color(0xFF7B4B42),fontWeight: FontWeight.bold ),
      ),
    ),
    const SizedBox(height: 50),
           SizedBox(
            height: 500,
            child: SleepAi(),
           )
          ],
        ),
        
      ),
    );
  }
}
