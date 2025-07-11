

import 'package:flutter/material.dart';
import 'package:mental_health_ai/GratitudeWall/gratitideentrypage.dart';
import 'package:mental_health_ai/GratitudeWall/gratitudecard.dart';
import 'package:mental_health_ai/VisibilityDetector/slidefadeinonvisible.dart';

class Gratitudeopeningsection extends StatelessWidget {
  const Gratitudeopeningsection({super.key});

  @override
  Widget build(BuildContext context) {
    return SlideFadeInOnVisible(
    duration: Duration(milliseconds: 800), 
    offset: Offset(0,0.2), 
    curve: Curves.easeOut,
     visibilityKey: Key('gratitude_key'),
     child: Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade100,
        border: Border.all(
          color: Colors.blueGrey,
          width: 4
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      gradient: LinearGradient(colors: [
         Color(0xFFEFF4EF), // Soft pastel green
                      Color(0xFFFFFFFF), // White
      ])
      ),
      child: Center(
        child: Wrap(
          spacing: 16, // horizontal gap
          runSpacing: 16, // vertical gap
          alignment: WrapAlignment.center,
          children: [
            _buildCard(context, 'assets/gratitudecard/friends.json', 'People Who Care', '''The ones who hug me when I’m sad,\ncheer me on when I try,\nand stay by my side with love and kindness.'''),
            _buildCard(context, 'assets/gratitudecard/nature.json', 'Wonders of Nature', '''From clouds above to flowers below,\nthe world around me sparkles with beauty\nthat calms my heart and makes me smile.'''),
            _buildCard(context, 'assets/gratitudecard/kindmoments.json', 'Moments of Kindness', '''A quiet “thank you,” a helping hand,\na shared giggle or a smile—\nlittle moments that warm the soul.'''),
            _buildCard(context, 'assets/gratitudecard/pets.json', 'Animal Friends', '''Wagging tails, tiny paws, or soft purrs—\nmy pets or wild friends remind me\nhow love can be furry or feathery too.'''),
            _buildCard(context, 'assets/gratitudecard/healthy.json', 'My Strong Body', '''I can run, jump, stretch, and rest.\nMy body helps me explore the world\nand feel every little moment.'''),
            _buildCard(context, 'assets/gratitudecard/littlejoys.json', 'Little Joys I Love', '''Stories, songs, games, and dreams—\nsmall things that light up my day\nand fill my heart with happy sparkles.'''),
          ],
        ),
      ),
    ),
     );
    
    
  }

  Widget _buildCard(BuildContext context, String lottie, String title, String desc) {
    return SizedBox(
      width: 480, // Set desired width
      height: 320, // Set desired height
      child: Gratitudecard(
        lottiurl: lottie,
        title: title,
        description: desc,
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => GratitudeEntryPage()));
        },
      ),
    );
  }
}
