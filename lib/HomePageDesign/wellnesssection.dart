// 📄 wellness_section.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

import 'package:mental_health_ai/HomePageDesign/SleepSection/sleepsection.dart'; // 👈 Needed for blur effect

class WellnessSection extends StatelessWidget {
  const WellnessSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      width: double.infinity,
      child: Stack(
        children: [
          // 🌄 Background Image with Blur - fixed height 500
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 500,
            child: ClipRRect(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    width: double.infinity,
                    "https://i.imgur.com/WfZArVG.jpeg",
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

          // 💼 Grid Layout in middle of image
          Positioned(
            top: 100,
            left: 220,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCard(
                  context,
                  title: "Stress Less",
                  description: "Ease stress and anxiety—one breath, one moment, one step at a time.",
                  icon: Icons.healing,
                  gradientColors: [
                    Colors.blue.shade200,
                    Colors.white70,
                    Colors.transparent
                  ],
                  onTap: () => Navigator.pushNamed(context, '/stress'),
                ),
                _buildCard(
                  context,
                  title: "Sleep more.",
                  description: "Sleep comes softly. Stay wrapped in calm all night long.",
                  icon: Icons.bedtime,
                  gradientColors: [
                    Colors.purple.shade200,
                    Colors.white70,
                    Colors.transparent
                  ],
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>SleepSection())),
                ),
                _buildCard(
                  context,
                  title: "Inner Compass.",
                  description: "Find balance and confidence through life’s highs and lows.",
                  icon: Icons.eco,
                  gradientColors: [
                    Colors.green.shade200,
                    Colors.white70,
                    Colors.transparent
                  ],
                  onTap: () => Navigator.pushNamed(context, '/mindfulness'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildCard(
  BuildContext context, {
  required String title,
  required String description,
  required IconData icon,
  required List<Color> gradientColors,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: ClipRRect(
      child: Container(
        width: 350,
        height: 300,
       // padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 6),
            )
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 40, color: Colors.black54),
            SizedBox(height: 16),
            Text(
              title,
              style: GoogleFonts.playfairDisplay(
                fontSize: 30,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
                color: Color(0xFF7B4B42),
              ),
            ),
            SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: GoogleFonts.dancingScript(
                fontSize: 22,
                decoration: TextDecoration.none,
                color: Colors.blueGrey
                //color: Color(0xFF7B4B42),
              ),
            ),
            SizedBox(height: 22),
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: Colors.transparent,
    border: Border.all(color: Colors.white, width: 2),  // White border
  ),
  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),  // Add padding for shape
  child: Text(
    "Learn More",
    style: GoogleFonts.playfairDisplay(fontSize: 18, decoration: TextDecoration.none, color: Colors.black),
  ),
)

            
          ],
        ),
      ),
    ),
  );
}
