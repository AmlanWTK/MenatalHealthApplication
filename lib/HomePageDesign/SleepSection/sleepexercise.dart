import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_health_ai/VisibilityDetector/slidefadeinonvisible.dart';
import 'package:mental_health_ai/vimeocard/vimeovideocard.dart';

class Sleepexercise extends StatelessWidget {
  const Sleepexercise({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> videoList = [
      {
        'url': 'https://player.vimeo.com/video/1099086997',
        'title': 'Breathe and Be Calm',
        'desc': 'A short breathing session to ground yourself.',
        'id': 'vimeo_view_1',
      },
      {
        'url': 'https://player.vimeo.com/video/1099086877',
        'title': 'Relaxing Nature Sounds',
        'desc': 'Gentle scenes and sounds from nature to ease your mind.',
        'id': 'vimeo_view_2',
      },
      {
        'url': 'https://player.vimeo.com/video/1099085799',
        'title': 'Soothing Affirmations',
        'desc': 'Positive words to remind you that you are safe and strong.',
        'id': 'vimeo_view_3',
      },
    ];

    return SlideFadeInOnVisible(
       
      duration: Duration(milliseconds: 800), 
      offset: Offset(0, 0.2), 
      curve: Curves.easeOut, 
      visibilityKey:Key('tab_section'),
      child: Center(
      child: Container(
        height: 600,
        width: 1280,
        padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 40),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [
            Color(0xFFE0F7FA), // Very light blue
        Color(0xFFD0F0EC), // Light blue-green blend (optional)
        Color(0xFFE8F5E9), // Very light mint green
          ]),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            )
          ],
          border: Border.all(
            color: Colors.blueGrey,
            width: 4
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Ease your Mind',
              style: GoogleFonts.playfairDisplay(
                fontSize: 38,
                color: const Color(0xFF7B4B42),
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: videoList.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (_, index) {
                  final video = videoList[index];
                  return Vimeovideocard(
                    vimeoURL: video['url']!,
                    title: video['title']!,
                    description: video['desc']!,
                    viewID: video['id']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
      );
    
    
    
    
  }
}
