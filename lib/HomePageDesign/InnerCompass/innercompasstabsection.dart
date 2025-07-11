import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:visibility_detector/visibility_detector.dart';

class InnerCompassTabSection extends StatefulWidget {
  const InnerCompassTabSection({super.key});

  @override
  State<InnerCompassTabSection> createState() => _InnerCompassTabSectionState();
}

class _InnerCompassTabSectionState extends State<InnerCompassTabSection> {
  int selectIndex = 0;
  bool _isVisible = false;
  Timer? _autoSwitchTimer;

  final List<String> tabs = [
    "Getting Started",
    "Mindful Mornings",
    "Evening Reflections",
    "Mini Calm Breaks",
    "Growth Pathways",
  ];

  final List<Map<String, dynamic>> tabContent = [
    {
      "title": "Getting Started",
      "sectionTitle": "Your First Step Toward Stillness",
      "description":
          "New to mindfulness? Start here. These sessions gently introduce the basics of meditation, breathing techniques, and calming awareness — perfect for easing into the practice with confidence.",
      "image": "assets/animations/gettingstarted.json",
      "audioLabel": "Intro to Calm",
      "narrator": "Guided by Alex",
      "imageCaption": "Breathe in stillness, breathe out stress.",
      "imageDescription": "Begin your journey with gentle moments of reflection and ease.",
    },
    {
      "title": "Daily Mindfulness",
      "sectionTitle": "Consistency is the Key to Presence",
      "description":
          "Build healthy habits that will last a lifetime. Our daily programs are designed to fit into your lifestyle in practical ways, giving your day a dose of mindfulness, wisdom, and encouragement.",
      "image": "assets/animations/mindfulmorning.json",
      "audioLabel": "Morning Reset",
      "narrator": "Narrated by Chibs Okereke",
      "imageCaption": "Anchor your day with mindful intention.",
      "imageDescription": "Pause and reconnect with yourself in the quiet between tasks.",
    },
    {
      "title": "Daily Wisdom",
      "sectionTitle": "Mindful Thoughts for a Meaningful Life",
      "description":
          "Spend 7 minutes a day with Jay Shetty, and watch all the ways your life changes. Jay keeps it fun and fresh, with sessions on prioritization, purpose, self-talk, and more.",
      "image": "assets/animations/evening.json",
      "audioLabel": "Words of Presence",
      "narrator": "By Calm Studios",
      "imageCaption": "Let wisdom whisper through the noise.",
      "imageDescription": "Discover clarity in the small reflections of daily life.",
    },
    {
      "title": "Quick Meditations",
      "sectionTitle": "Ease Into Calm in Just Minutes",
      "description":
          "Calm's Quick Meditations are the easiest way to get started. These guided sessions are as short as 1 to 2 minutes, and you can choose from a variety of voices and techniques.",
      "image": "assets/animations/breaktime.json",
      "audioLabel": "Mini Mindful Break",
      "narrator": "By NatureLab",
      "imageCaption": "Even a moment of silence can restore balance.",
      "imageDescription": "Short bursts of calm that fit into your busiest days.",
    },
    {
      "title": "Courses",
      "sectionTitle": "Learn, Grow, and Deepen Your Practice",
      "description":
          "Our popular courses help integrate mindfulness into different aspects of your life, like building confidence, improving relationships, and breaking bad habits.",
      "image": "assets/animations/growthpathways.json",
      "audioLabel": "Mindfulness Journey",
      "narrator": "By Calm Tracker",
      "imageCaption": "Growth begins in mindful repetition.",
      "imageDescription": "Step-by-step guidance designed to evolve with you.",
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
                    Colors.green.shade200,
                    Colors.teal.shade100,
                    Colors.blue.withOpacity(0.02),
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
