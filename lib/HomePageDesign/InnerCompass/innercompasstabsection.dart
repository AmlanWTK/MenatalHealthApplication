import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InnerCompassTabSection extends StatefulWidget {
  const InnerCompassTabSection({super.key});

  @override
  State<InnerCompassTabSection> createState() => _InnerCompassTabSectionState();
}

class _InnerCompassTabSectionState extends State<InnerCompassTabSection> {
  late var selectIndex=1;
  
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
    "image": "https://i.imgur.com/EMKqTgQ.jpeg",
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
    "image": "https://i.imgur.com/X1D7vm0.jpeg",
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
    "image": "https://i.imgur.com/gGNzmAO.jpeg",
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
    "image": "https://i.imgur.com/Nh3OXb1.jpeg",
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
    "image": "https://i.imgur.com/vwHpqNU.jpeg",
    "audioLabel": "Mindfulness Journey",
    "narrator": "By Calm Tracker",
    "imageCaption": "Growth begins in mindful repetition.",
    "imageDescription": "Step-by-step guidance designed to evolve with you.",
  },
];




  @override
  Widget build(BuildContext context) {
    final current=tabContent[selectIndex];//getting current tab content
    return Stack(
    clipBehavior: Clip.none,
    alignment: Alignment.center,
    children: [
      //main container 
      Container(
        height: 600,
        margin: EdgeInsets.symmetric(horizontal: 190, vertical: 60),
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 0),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
              Colors.green.shade200,  // one greenish shade
  Colors.teal.shade100,         // soft white
  Colors.blue.withOpacity(0.02),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
          ),
          borderRadius: BorderRadius.circular(20)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Left side
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 110),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 500,

                        ),
                        child: Column(
                               children: [
                                //main title
                                Text(
                                  current["sectionTitle"],
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.playfairDisplay(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF7B4B42),
                                    decoration: TextDecoration.none

                                    ),
                                ),
                                SizedBox(height: 12,),
                                //description text
                                Text(
                                  current["description"],
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.dancingScript(
                                    fontSize: 26,
                                     color: Colors.black,
                                     fontWeight: FontWeight.bold,
                                     decoration: TextDecoration.none,
                                     height: 1.6
                                  ),
                                ),

                               ],
                        ),
                        ),

                    ),
                    ),
                    SizedBox(height: 56,),
                    //audio sample 
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text("Sample Audio",
                        style: GoogleFonts.openSans(fontSize: 14, color: Colors.blueGrey.shade900,decoration: TextDecoration.none
                        ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Center(
                      child: Text(
                        current["audioLabel"],
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF7B4B42),
                          decoration: TextDecoration.none

                        ),
                      )
                    ),
                    SizedBox(height: 15,),
                    Center(
                      child: Text(
                        current["narrator"],
                        style: GoogleFonts.dancingScript(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF7B4B42),
                          decoration: TextDecoration.none,
                          ),
                      ),
                    ),
                    SizedBox(height: 12,),

                ],
              )
              ),

          SizedBox(width: 30,),
          Padding(padding: EdgeInsets.only(top: 50),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Stack(
              children: [
                Image.network(
                  current["image"],
                  height: double.infinity,
                  width: 520,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(27.0),
                    child: Container(
                      
                            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white.withOpacity(0.8)
                            ),
                            child: Column(
                              children: [
                                Text(
                                  current["imageCaption"],
                                  style: GoogleFonts.playfairDisplay(
                                    fontSize: 18, 
                                    fontWeight: FontWeight.bold, 
                                     color: const Color(0xFF7B4B42),
                                     decoration: TextDecoration.none,
                                     ),
                                     textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 4,),
                                Text(
                                  current["imageDescription"],
                                  style: GoogleFonts.dancingScript(
                                    fontSize: 14,
                                    color: const Color(0xFF7B4B42),
                                    decoration: TextDecoration.none,
                                   fontWeight: FontWeight.bold
                                    ),
                                    textAlign: TextAlign.center,
                                )
                              ],
                            ),
                                    ),
                  ))
              ],
            ),
          ),
          )
          ],
        ),
      ),
      //tab bar
      Positioned(
        top: 30,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                offset: Offset(0, 6),
                color: Colors.black.withOpacity(0.08)
              ),
            ],
          ),
          child: Wrap(
              spacing: 25, // Space between each tab button
              children: List.generate(tabs.length, (index) {
                final isSelected = selectIndex == index;


                return ElevatedButton(
                  onPressed: () => setState(() => selectIndex = index),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    backgroundColor: isSelected
                        ? Colors.indigo.shade900 // Highlight selected tab
                        : Colors.blueGrey.shade300, // Unselected tab color
                    elevation: isSelected ? 6 : 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    shadowColor: isSelected
                        ? Colors.indigo.shade100
                        : Colors.transparent,
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




