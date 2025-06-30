import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_health_ai/HomePageDesign/wellnesssection.dart';

class Homepage1 extends StatefulWidget {
  const Homepage1({super.key});

  @override
  State<Homepage1> createState() => _Homepage1State();
}

class _Homepage1State extends State<Homepage1> {
  
ScrollController _scrollController=ScrollController();
bool _isScrolled=false;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener((){
     if(_scrollController.offset>50 && !_isScrolled){
      setState(() {
        _isScrolled=true;
      });
     }else if(_scrollController.offset<=50 && _isScrolled){
      setState(() {
        _isScrolled=false;
      });
     }
         });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  //Navigation items
  final List<String> leftitems=["Sleep","Stress & Anxiety", "Mindfullness"];
  final List<String> rightitems=["Screening","Calm Health"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF5FAFD),
        body: Stack(
          children: [
            //full page scrollable
           SingleChildScrollView(
  controller: _scrollController,
  child: Column(
    children: [
      // 🖼️ Image section
      SizedBox(
        height: 400,
        width: double.infinity,
        child: Image.network(
          "https://i.imgur.com/eM1GEls.jpeg",
          fit: BoxFit.cover,
        ),
      ),

      // 📜 Text section BELOW the image
      Container(
        padding: const EdgeInsets.symmetric(vertical: 60,),
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(
              "Whispers of Calm, Echoes of Change",
              style: GoogleFonts.playfairDisplay(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: Color(0xFF7B4B42),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              "A journey inward, where healing begins.",
              style: GoogleFonts.dancingScript(
                fontSize: 27,
                color: Color(0xFF7B4B42),
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
SizedBox(height: 40,),
           WellnessSection()
             
          ],
        ),
      ),
    ],

    
  ),

  
),
// 🌟 Smooth AppBar reveal with gradient background
Positioned(
  top: 0,
  left: 0,
  right: 0,
  child: Stack(
    children: [
      // 🔽 Gradient background that grows from top
      ClipRect(
        child: Align(
          alignment: Alignment.topCenter,
          heightFactor: _isScrolled ? 1.0 : 0.0,
          child: Container(
            height: 100,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.white70,
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ),

      // 🧭 Actual NavBar content
      AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        width: double.infinity,
        child: AnimatedOpacity(
          opacity: _isScrolled ? 1 : 0.95,
          duration: const Duration(milliseconds: 500),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 👉 Left side: Logo + menu
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5FAFD),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Aranya",
                      style: GoogleFonts.dancingScript(
                        color: Colors.grey,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  for (final item in leftitems)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        item,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: _isScrolled ? const Color(0xFF7B4B42) : Colors.white,
                        ),
                      ),
                    ),
                ],
              ),

              // 👉 Right side: Menu items
              Row(
                children: [
                  for (final item in rightitems)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        item,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: _isScrolled ? const Color(0xFF7B4B42) : Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  ),
),

          ],

          
        ),


      
    );
  }
}





