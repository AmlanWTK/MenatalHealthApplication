import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_health_ai/Emergency/emergencypage.dart';
import 'package:mental_health_ai/HomePageDesign/InnerCompass/innercompasssection.dart';
import 'package:mental_health_ai/HomePageDesign/SleepSection/sleepsection.dart';
import 'package:mental_health_ai/HomePageDesign/homepage1.dart';
import 'package:mental_health_ai/Notepad/notepadsection.dart';

// 📦 Import your pages


// 🗺️ Define the mapping from text to pages
final Map<String, Widget Function()> pageRoutes = {
  "Sleep": () => SleepSection(),
  "Stress & Anxiety": () => SleepSection(),
  "Mindfullness": () => InnerCompassSection(),
  "NoteBook": () => NotePadSection(),
  "Emergency": () => Emergencypage(),
};

class CustomNavBar extends StatelessWidget {
  final bool isScrolled; // Needed to change nav color on scroll

   CustomNavBar({Key? key, required this.isScrolled}) : super(key: key);

  // 🧭 Navigation items
  final List<String> leftitems = ["Sleep", "Stress & Anxiety", "Mindfullness"];
  final List<String> rightitems = ["NoteBook", "Emergency"];

  // 🚀 Navigate to specific page based on item
  void _navigateToPage(BuildContext context, String item) {
    final pageBuilder = pageRoutes[item];
    if (pageBuilder != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => pageBuilder()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Stack(
        children: [
          // 🌈 Scroll-reveal gradient
          ClipRect(
            child: Align(
              alignment: Alignment.topCenter,
              heightFactor: isScrolled ? 1.0 : 0.0,
              child: Container(
                height: 100,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.white70,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 🧭 NavBar content
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            width: double.infinity,
            child: AnimatedOpacity(
              opacity: isScrolled ? 1 : 0.95,
              duration: const Duration(milliseconds: 500),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left side: logo + menu
                  Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Homepage1()));
                        },
                        child: 
                       Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFE9F7EF), // very light mint green
          Color(0xFFD0F0C0), // pale pastel green
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.green.withOpacity(0.1),
          blurRadius: 8,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Text(
      "Aranyak",
      style: GoogleFonts.dancingScript(
        fontSize: 34,
        fontWeight: FontWeight.bold,
        color: Color(0xFF7B9E7C), // soft sage green
        shadows: [
          Shadow(
            blurRadius: 2,
            color: Colors.black12,
            offset: Offset(1, 1),
          ),
        ],
      ),
    ),
  ),


                      ),
                      const SizedBox(width: 16),

                      // Clickable left items
                      for (final item in leftitems)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: GestureDetector(
                            onTap: () => _navigateToPage(context, item),
                            child: Text(
                              item,
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: isScrolled ? const Color(0xFF7B4B42) : Colors.blueGrey,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),

                  // Right side: clickable items
                  Row(
                    children: [
                      for (final item in rightitems)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: GestureDetector(
                            onTap: () => _navigateToPage(context, item),
                            child: Text(
                              item,
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: isScrolled ? const Color(0xFF7B4B42) : Colors.blueGrey,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
