import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mental_health_ai/Notepad/intropage.dart';

class NotePadSection extends StatelessWidget {
  const NotePadSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
        child: Container(
         height: 550,
         width: double.infinity,
         padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
         decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFFF3EDFF), // Soft lilac
Color(0xFFE7DFFF), // Light lavender

          ],
          begin: Alignment.centerLeft,
                end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.blueGrey,
            width: 5,

          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 6)
            )
          ]
         ),
         child: Row(
          children: [
             Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("When the Heart Speaks in Ink: A Personal Record of Feelings, Thoughts, and Truths",
                     style: GoogleFonts.playfairDisplay(
                      fontSize: 38,
                     color: Color(0xFF7B4B42),
                     fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none
                     ),
                    ),
                    SizedBox(height: 16,),
                    Text('''Welcome to your personal space on this page.
Write freely, feel deeply, and don’t worry about making it perfect.
This notebook is here to hold your thoughts, your emotions, and your voice.
No judgment — just a safe place for self-expression.
Start wherever you are. Just begin.''',
                style: GoogleFonts.dancingScript(
                  color: Color(0xFF7B4B42),
                     fontWeight: FontWeight.bold,
                     fontSize: 28 ,
                     decoration: TextDecoration.none
                ),
                
                ),
                SizedBox(height: 20,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15)
                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>IntroPage()));
                    }, 
                    child: Text("Your Own NoteBook",
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                      color: Colors.white
                    ),
                    )
                    )
                  ],
                ),
              )
              ),
              SizedBox(width: 10,),
             Expanded(
  flex: 1,
  child: Stack(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          'https://i.imgur.com/myQnbaw.jpeg',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              '''This page belongs to your imagination.\nDraw, scribble, write, or dream — there are no rules.''',
              textAlign: TextAlign.center,
              style: GoogleFonts.dancingScript(
                fontSize: 20,
                color: Colors.blueGrey.shade800,
                decoration: TextDecoration.none
              ),
            ),
          ),
        ),
      ),
    ],
  ),
)

          ],
         ),
        ),
      ),
    );
  }
}