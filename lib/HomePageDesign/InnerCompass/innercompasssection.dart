import 'package:flutter/material.dart';
import 'package:mental_health_ai/HomePageDesign/InnerCompass/innercompassai.dart';
import 'package:mental_health_ai/HomePageDesign/InnerCompass/innercompassexercise.dart';
import 'package:mental_health_ai/HomePageDesign/InnerCompass/innercompasstabsection.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mental_health_ai/Navbar/customnavbar.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';



class InnerCompassSection extends StatefulWidget {
  const InnerCompassSection({super.key});

  @override
  State<InnerCompassSection> createState() => _InnerCompassSectionState();
}

class _InnerCompassSectionState extends State<InnerCompassSection> {
  bool _isHeroVisible = false;
  bool _istypewriting = false;
  bool _isScrolled = false;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // ✅ Listen to scroll changes
    _scrollController.addListener(() {
      final scrolled = _scrollController.offset > 20;
      if (scrolled != _isScrolled) {
        setState(() => _isScrolled = scrolled);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // ✅ Clean up controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

            // 🧭 Add the reusable nav bar at the top
          CustomNavBar(isScrolled: _isScrolled),
          // 🌿 Background content with scrolling
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  // ✅ Hero Section (with animation trigger)
                  VisibilityDetector(
                    key: const Key('hero_section'),
                    onVisibilityChanged: (info) {
                      if (info.visibleFraction > 0.3 && !_isHeroVisible) {
                        setState(() => _isHeroVisible = true);
                      }
                    },
                    child: Container(
                      height: 600,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.green.shade200,
                            Colors.teal.shade100,
                            Colors.blue.withOpacity(0.1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Row(
                        children: [
                          // ✨ Left text side
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 180,
                                    child: DefaultTextStyle(
                                      style: GoogleFonts.playfairDisplay(
                                        fontSize: 38,
                                        color: const Color(0xFF7B4B42),
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none,
                                      ),
                                      child: _isHeroVisible
                                          ? AnimatedTextKit(
                                              isRepeatingAnimation: false,
                                              animatedTexts: [
                                                TypewriterAnimatedText(
                                                  'Mindfulness, meditation and guided programs to build healthy habits that will last a lifetime',
                                                  speed: const Duration(milliseconds: 100),
                                                  cursor: '|',
                                                ),
                                              ],
                                            )
                                          : const SizedBox(),
                                    ),
                                  ),
                                  _isHeroVisible
                                      ? Text('''You're in the right place. Calm puts the tools to achieve mindfulness in your back pocket with guided meditations, soothing music, and daily guided programs designed to fit into your lifestyle in practical ways.Whether you're new to mindfulness or deepening your journey, there's something for every moment. Take a breath, slow down, and reconnect with yourself—right here, right now.Because even a minute of calm can change the rhythm of your whole day.''',
                              style: GoogleFonts.dancingScript(
                                fontSize: 24,
                                 color: Colors.blueGrey,
                                 fontWeight: FontWeight.bold
                                ),
                              )
                                          .animate()
                                          .fadeIn(duration: 800.ms)
                                          .slideY(begin: 0.4, end: 0, duration: 800.ms, curve: Curves.easeOut)
                                      : const SizedBox(),
                                  const SizedBox(height: 20),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      border: Border.all(color: Colors.white, width: 2),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                                    child: Text(
                                      "Live Mindfully",
                                      style: GoogleFonts.playfairDisplay(fontSize: 18, color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
            
                          // ✨ Right Lottie
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 20,
                                      offset: Offset(0, 10),
                                    ),
                                  ],
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Lottie.asset(
                                  'assets/animations/meditation1.json',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            
                  const SizedBox(height: 50),
                  Center(
                    child: Text(
                      "Mindfulness tools for a calmer mind and a more fulfilling life.",
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 38,
                        color: const Color(0xFF7B4B42),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  const InnerCompassTabSection(),
                  const SizedBox(height: 40),
                  const Innercompassai(),
                  const SizedBox(height: 40),
            
                  // ✍️ Typewriting text
                  VisibilityDetector(
                    key: const Key("typewriting_key"),
                    onVisibilityChanged: (info) {
                      if (info.visibleFraction > 0.3 && !_istypewriting) {
                        setState(() => _istypewriting = true);
                      }
                    },
                    child: SizedBox(
                      height: 60,
                      child: DefaultTextStyle(
                        style: GoogleFonts.playfairDisplay(
                          color: const Color(0xFF7B4B42),
                          fontWeight: FontWeight.bold,
                          fontSize: 38,
                          decoration: TextDecoration.none,
                        ),
                        child: _istypewriting
                            ? AnimatedTextKit(
                                isRepeatingAnimation: false,
                                animatedTexts: [
                                  TypewriterAnimatedText(
                                    'Gentle Moments to Ease Your Mind and Restore Your Inner Calm',
                                    speed: const Duration(milliseconds: 100),
                                    cursor: '|',
                                  ),
                                ],
                              )
                            : const Text('Gentle Moments to Ease Your Mind and Restore Your Inner Calm'),
                      ),
                    ),
                  ),
            
                  const SizedBox(height: 16),
                  Text(
                    "Explore these calming meditation videos to relax your body and soothe your mind.",
                    style: GoogleFonts.dancingScript(
                      fontSize: 29,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Innercompassexercise(),
                ],
              ),
            ),
          ),

        
        ],
      ),
    );
  }
}
