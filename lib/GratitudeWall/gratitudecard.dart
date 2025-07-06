import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Gratitudecard extends StatelessWidget {
  final String lottiurl;
  final String title;
  final String description;
  final VoidCallback?onTap;
  
  const Gratitudecard({
    super.key,
    required this.lottiurl,
    required this.title,
    required this.description,
    required this.onTap,
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      
      onTap: onTap,
      child: Container(
        height: 250,
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.cyan,
            width: 3,
            
          ),
          gradient: LinearGradient(
            colors: [
                      Color(0xFFEFF4EF), // Soft pastel green
                      Color(0xFFFFFFFF), // White
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.8,1.0],
          )
        ),
       child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
               Lottie.asset(lottiurl,
               height: 150,
               width: 280,
               fit: BoxFit.contain
               ),
               SizedBox(height: 10,),
               Text(title,
               style: GoogleFonts.playfairDisplay(
                fontSize: 22,
                color: Color(0xFF7B4B42),
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none
               ),
               textAlign: TextAlign.center,
               ),
               SizedBox(height: 10,),
               Text(description,
               style: GoogleFonts.dancingScript(
                fontSize: 18,
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none
               ),
               textAlign: TextAlign.center,
               ),

          ],
        ),
        ),
      ),

    );
  }
}