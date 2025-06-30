import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SleepTabSection extends StatefulWidget {
  const SleepTabSection({super.key});

  @override
  State<SleepTabSection> createState() => _SleepTabSectionState();
}

class _SleepTabSectionState extends State<SleepTabSection> {
  int selectedIndex = 1;

  final List<String> tabs = [
    "Sleep Stories",
    "Sleep Meditations",
    "Music",
    "Soundscapes",
    "Sleep Tracking",
    "For Kids",
  ];

 final List<Map<String, dynamic>> tabContent =
 [
  {
    "title": "Sleep Stories",
    "sectionTitle": "Drift Into Dreamland",
    "description":
        "Unwind with a collection of immersive bedtime stories designed to calm the mind. These gentle narratives, told in soothing tones, help create a peaceful transition from wakefulness to deep sleep.",
    "image": "https://i.imgur.com/oHdxtO5.jpeg",
    "audioLabel": "Gentle Storytime",
    "narrator": "Narrated by Emma",
  },
  {
    "title": "Sleep Meditations",
    "sectionTitle": "A Bit of Guidance to Help You Drift Off",
    "description":
        "Pick a dreamy voice, and they'll take it from there. Calm's Sleep Meditations work with mindfulness tools and themes, like body scans, gratitude, and progressive muscle relaxation.",
    "image": "https://i.imgur.com/wlRaTYx.jpeg",
    "audioLabel": "Unwind Into Sleep",
    "narrator": "Narrated by Chibs Okereke",
  },
  {
    "title": "Music",
    "sectionTitle": "Peaceful Sleep Through Music",
    "description":
        "Let ambient and instrumental music lull you into a peaceful state of mind and sleep. These gentle melodies are carefully composed to quiet your thoughts and ease you into rest.",
    "image": "https://i.imgur.com/WYwIm0F.jpeg",
    "audioLabel": "Soothing Piano",
    "narrator": "By Calm Studios",
  },
  {
    "title": "Soundscapes",
    "sectionTitle": "Let Nature Calm Your Mind",
    "description":
        "Immerse yourself in the calming rhythms of the natural world. From soft rainfall to ocean waves, these soundscapes help reduce stress and encourage a tranquil sleep environment.",
    "image": "https://i.imgur.com/Khd9eFc.jpeg",
    "audioLabel": "Forest Rain",
    "narrator": "By NatureLab",
  },
  {
    "title": "Sleep Tracking",
    "sectionTitle": "Understand Your Rest Better",
    "description":
        "Gain insight into your nightly rest with gentle sleep tracking. Monitor patterns, explore trends, and build better sleep habits with a soft and non-intrusive approach.",
    "image": "https://i.imgur.com/nUXHDNS.jpeg",
    "audioLabel": "Sleep Rhythm",
    "narrator": "By Calm Tracker",
  },
  {
    "title": "For Kids",
    "sectionTitle": "Gentle Sleep for Little Dreamers",
    "description":
        "Ease children into bedtime with friendly voices and delightful tales. These relaxing audio sessions are designed to calm busy minds and guide young listeners toward sweet dreams.",
    "image": "https://i.imgur.com/TvHnlO2.jpeg",
    "audioLabel": "Goodnight Moon",
    "narrator": "Narrated by Lily",
  },
];



  @override
  Widget build(BuildContext context) {
    final current = tabContent[selectedIndex];

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        // Main container
        Container(
          height: 600,
          margin: const EdgeInsets.symmetric(horizontal:  190,vertical: 60),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
               Colors.blue.shade100,
                    Colors.white70,
                  Color(0xFFF8EDE3),
                ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left content
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
  padding: const EdgeInsets.only(top: 110),
  child: Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Column(
        children: [
          Text(
            current["sectionTitle"],
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF7B4B42),
              decoration: TextDecoration.none,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            current["description"],
            textAlign: TextAlign.center,
            style: GoogleFonts.dancingScript(
              fontSize: 26,
              color: Colors.grey.shade800,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold,
              height: 1.6, // Optional: improves readability
            ),
          ),
        ],
      ),
    ),
  ),
),

                    const SizedBox(height: 56),
                    Center(
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Sample Audio",
                          style: GoogleFonts.openSans(
                            fontSize: 14,
                            color: Colors.blueGrey.shade900,
                             decoration: TextDecoration.none
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        current["audioLabel"],
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF7B4B42),
                           decoration: TextDecoration.none
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Center(
                      child: Text(
                        current["narrator"],
                        style: GoogleFonts.dancingScript(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF7B4B42),
                           decoration: TextDecoration.none
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: const Icon(Icons.play_circle_fill,
                          size: 36, color: Colors.deepPurple),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 30),
              // Right image
              Padding(padding: EdgeInsets.only(top: 50),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
                child: Image.network(
                  current["image"],
                  height: double.infinity,
                  width: 520,
                  fit: BoxFit.cover,
                ),
              ),
              
              )
            ],
          ),
        ),
        // Tab buttons
       Positioned(
  top: 30,
  child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.grey.shade300,
      borderRadius: BorderRadius.circular(32),
      boxShadow: [
        BoxShadow(
          blurRadius: 8,
          offset: const Offset(0, 4),
          color: Colors.black.withOpacity(0.08),
        ),
      ],
    ),
    child: Wrap(
      spacing: 25,
      children: List.generate(tabs.length, (index) {
        final isSelected = selectedIndex == index;

        return ElevatedButton(
          onPressed: () => setState(() => selectedIndex = index),
          style: ElevatedButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            backgroundColor: isSelected
                ? Colors.indigo.shade900
                : Colors.blueGrey.shade300,
            elevation: isSelected ? 6 : 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            shadowColor:
                isSelected ? Colors.indigo.shade100 : Colors.transparent,
          ),
          child: Text(
            tabs[index],
            style: GoogleFonts.playfairDisplay(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : Colors.black87,
              decoration: TextDecoration.none,
            ),
          ),
        );
      }),
    ),
  ),
),

      ],
    );
  }
}
