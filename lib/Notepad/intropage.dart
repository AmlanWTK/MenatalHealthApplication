import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_health_ai/Notepad/journalpage.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   backgroundColor: Color(0xFFE3F2F9),
  




      body: Center(
        child: Container(
          margin: const EdgeInsets.all(40),
          padding: const EdgeInsets.all(24),
          height: 700,
          width: double.infinity,
          decoration: BoxDecoration(
           color: Color(0xFFF5FAFD),

            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start, // Align content to start
            children: [
              // Header text aligned left
              Center(
                child:  Text(
                  "YOUR OWN THOUGHTS",
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 38,
                    color: Color(0xFF5B3E37),
                     fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.left, // Align text to left
                ),
              ),
              SizedBox(height: 10,),
 Center(
                child:  Text(
                  "Welcome to your sanctuary of self.",
                  style: GoogleFonts.openSans(
                    fontSize: 28,
                    color: Color(0xFF5B3E37),
                  
                  ),
                  textAlign: TextAlign.left, // Align text to left
                ),
              ),

              const SizedBox(height: 16),
              
              // Button row with spacer to push it right
              Row(
                mainAxisAlignment: MainAxisAlignment.end, // Aligns children to end (right)
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>JournalPage()));
                    }, 
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(14),
                      backgroundColor: const Color(0xFF5B3E37),
                      elevation: 0,
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 15),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  "https://i.imgur.com/DIqTBog.jpeg",
                  width: double.infinity,
                  height: 350,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10,),

              Center(
                child:  Text(
                  " 'Let your feelings find form' ",
                 
                  style: GoogleFonts.dancingScript(
                    fontSize: 20,
                    color: Color(0xFF5B3E37),
                    fontWeight: FontWeight.bold
                    
                  ),
                  textAlign: TextAlign.left, // Align text to left
                ),
              ),

               SizedBox(height: 10,),

              Center(
                child: Text(
                  " 'in the pages you call your own' ",
                 
                  style:GoogleFonts.dancingScript(
                    fontSize: 20,
                     fontWeight: FontWeight.bold
                    
                  ),
                  textAlign: TextAlign.left, // Align text to left
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}