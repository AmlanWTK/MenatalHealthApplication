import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mental_health_ai/HomePageDesign/MoodSection/dailymood.dart';
import 'package:mental_health_ai/VisibilityDetector/slidefadeinonvisible.dart';

class Moodsectionopening extends StatelessWidget {
  const Moodsectionopening({super.key});

  @override
  Widget build(BuildContext context) {
    return SlideFadeInOnVisible(
      
      duration: Duration(milliseconds: 800), 
      offset: Offset(0, 0.2), 
      curve: Curves.easeOut, 
      visibilityKey: Key('mood_section'),
      child: 
    SizedBox(
      height: 650,
      width: double.infinity,
      child: Stack(
        children: [
          // 🌄 Blurred Background Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 650,
            child: ClipRRect(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://i.imgur.com/hVm4hxW.jpeg',
                    fit: BoxFit.cover,
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                    child: Container(
                      color: Colors.black.withOpacity(0.05),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 📦 Foreground Container with Content
          Positioned(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Container(
                height: 580,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blueGrey,
                    width: 5
                  ),
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
  colors: [
   Color(0xFFFFF9E5), // Buttery pastel yellow
Color(0xFFFFFDF9), // Creamy white

  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
),

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
                            'assets/animations/trackingemotion.json',
                            fit: BoxFit.cover,
                          ),
                        ),
                            ),
                          ),
                        ),
            
                    const SizedBox(width: 10),
                    // 📝 Right Text Section
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // 🧠 Title
                            Text(
                              "Track Your Emotions Daily to Understand, Heal, and Grow Deeper",
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 38,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF7B4B42),
                                decoration: TextDecoration.none,
                              ),
                            ),
                            const SizedBox(height: 14),

                            // 💬 Description
                            Text(
                              "By tracking your mood each day, you begin to notice patterns in your emotional highs and lows. This awareness helps you understand what triggers stress or happiness, allowing you to respond more wisely. Over time, you develop greater emotional resilience and find healthier ways to cope with challenges. Consistent mood tracking also encourages mindfulness, helping you stay present and grounded throughout your day."
                              ,style: GoogleFonts.dancingScript(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // 🔘 Button
                            ElevatedButton(
                              onPressed: () {
                                 
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>DailyMood()));

                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey.shade700,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 4,
                              ),
                              child: Text(
                                "Let's Track",
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // 📷 Left Image with Rounded Corners
       

                    
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
      );
    
    
    
  }
}
