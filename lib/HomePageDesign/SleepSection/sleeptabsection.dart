import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SleepTabSection extends StatefulWidget {
  const SleepTabSection({super.key});

  @override
  State<SleepTabSection> createState() => _SleepTabSectionState();
}

class _SleepTabSectionState extends State<SleepTabSection> {
  int selectIndex = 0;
  bool _isVisible = false;
  Timer? _autoSwitchTimer;

  final List<String> tabs = [
    "Sleep Stories",
    "Sleep Meditations",
    "Music",
    "Soundscapes",
    "For Kids",

  ];

  final List<Map<String, dynamic>> tabContent = [
   {
    "title": "Sleep Stories",
    "sectionTitle": "Drift Into Dreamland",
    "description":
        "Unwind with a collection of immersive bedtime stories designed to calm the mind. These gentle narratives, told in soothing tones, help create a peaceful transition from wakefulness to deep sleep.",
    "image": "assets/animations/sleepstory.json",
    "audioLabel": "Gentle Storytime",
    "narrator": "Narrated by Emma",
      "imageCaption": "Soft Words Before Sleep",
    "imageDescription": "Gentle tales whispered in the night,\nTo guide your dreams with calm and light.",
  },
  {
    "title": "Sleep Meditations",
    "sectionTitle": "A Bit of Guidance to Help You Drift Off",
    "description":
        "Pick a dreamy voice, and they'll take it from there. Calm's Sleep Meditations work with mindfulness tools and themes, like body scans, gratitude, and progressive muscle relaxation.",
    "image": "assets/animations/sleepmeditation.json",
    "audioLabel": "Unwind Into Sleep",
    "narrator": "Narrated by Chibs Okereke",
     "imageCaption": "Evening Mindfulness",
    "imageDescription": "Breathe in peace, let worries go,\nA mindful drift to sleep’s soft flow.",

  },
  {
    "title": "Music",
    "sectionTitle": "Peaceful Sleep Through Music",
    "description":
        "Let ambient and instrumental music lull you into a peaceful state of mind and sleep. These gentle melodies are carefully composed to quiet your thoughts and ease you into rest.",
    "image": "assets/animations/music.json",
    "audioLabel": "Soothing Piano",
    "narrator": "By Calm Studios",
    "imageCaption": "Melodic Sleep",
    "imageDescription": "Piano notes that kiss the air,\nA lullaby beyond compare.",
  
  },
  {
    "title": "Soundscapes",
    "sectionTitle": "Let Nature Calm Your Mind",
    "description":
        "Immerse yourself in the calming rhythms of the natural world. From soft rainfall to ocean waves, these soundscapes help reduce stress and encourage a tranquil sleep environment.",
    "image": "assets/animations/soundscapes.json",
    "audioLabel": "Forest Rain",
    "narrator": "By NatureLab",
    
    "imageCaption": "Nature’s Embrace",
    
    "imageDescription": "Rain and waves in soothing tune,\nCradle you beneath the moon.",
 
  },
  
  {
    "title": "For Kids",
    "sectionTitle": "Gentle Sleep for Little Dreamers",
    "description":
        "Ease children into bedtime with friendly voices and delightful tales. These relaxing audio sessions are designed to calm busy minds and guide young listeners toward sweet dreams.",
    "image": "assets/animations/kidsstory.json",
    
    "audioLabel": "Goodnight Moon",
    "narrator": "Narrated by Lily",
    "imageCaption": "Dreamy Adventures",
    "imageDescription": "Magic lands and starry skies,\nClose your eyes, let dreams arise.",

  },

  ];

  void startAutoSwitching() {
    _autoSwitchTimer?.cancel(); // avoid duplicates
    _autoSwitchTimer = Timer.periodic(Duration(seconds: 5), (_) {
      if (_isVisible) {
        setState(() {
          selectIndex = (selectIndex + 1) % tabs.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _autoSwitchTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final current = tabContent[selectIndex];

    return VisibilityDetector(
      key: Key('tab_section_visible'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 && !_isVisible) {
          setState(() {
            _isVisible = true;
            startAutoSwitching();
          });
        }
      },
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 800),
        switchInCurve: Curves.easeOut,
        transitionBuilder: (child, animation) {
          return SlideTransition(
            position: Tween<Offset>(begin: Offset(0.2, 0), end: Offset.zero).animate(animation),
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        child: Stack(
          key: ValueKey<int>(selectIndex),
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Main content
            Container(
              height: 600,
              margin: EdgeInsets.symmetric(horizontal: 190, vertical: 60),
              padding: EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey, width: 5),
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFF2F0FF), // Very pale lavender-white
        Color(0xFFD8CFFF).withOpacity(0.8), // Soft lavender, semi-transparent
        Color(0xFFEDE8FF), // Light lilac with white mix
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Column
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 110),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(current["sectionTitle"],
                              textAlign: TextAlign.center,
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF7B4B42),
                              )),
                          const SizedBox(height: 12),
                          Text(current["description"],
                              textAlign: TextAlign.center,
                              style: GoogleFonts.dancingScript(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey.shade700,
                                height: 1.6,
                              )),
                          const SizedBox(height: 56),
                          Text("Sample Audio",
                              style: GoogleFonts.openSans(
                                fontSize: 14,
                                color: Colors.blueGrey.shade900,
                              )),
                          const SizedBox(height: 20),
                          Text(current["audioLabel"],
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF7B4B42),
                              )),
                          const SizedBox(height: 15),
                          Text(current["narrator"],
                              style: GoogleFonts.dancingScript(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF7B4B42),
                              )),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  // Right Column: Lottie
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        children: [
                          Lottie.asset(current["image"],
                              width: 520, height: double.infinity, fit: BoxFit.cover),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(27),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    Text(current["imageCaption"],
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.playfairDisplay(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF7B4B42),
                                        )),
                                    const SizedBox(height: 4),
                                    Text(current["imageDescription"],
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.dancingScript(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF7B4B42),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Tab bar
            Positioned(
              top: 30,
              child: Column(
                children: [
                  // Tabs
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8,
                          offset: Offset(0, 6),
                          color: Colors.black.withOpacity(0.08),
                        ),
                      ],
                    ),
                    child: Wrap(
                      spacing: 25,
                      children: List.generate(tabs.length, (index) {
                        final isSelected = selectIndex == index;
                        return ElevatedButton(
                          onPressed: () => setState(() => selectIndex = index),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            backgroundColor: isSelected
                                ? Colors.indigo.shade900
                                : Colors.blueGrey.shade300,
                            elevation: isSelected ? 6 : 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            tabs[index],
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : Colors.black87,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Progress Bar
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 800),
                    height: 6,
                    width: 200,
                    alignment: Alignment.centerLeft,
                    child: LayoutBuilder(
                      builder: (context, constraints) => Container(
                        height: 6,
                        width: constraints.maxWidth * ((selectIndex + 1) / tabs.length),
                        decoration: BoxDecoration(
                          color: Colors.indigo.shade900,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
