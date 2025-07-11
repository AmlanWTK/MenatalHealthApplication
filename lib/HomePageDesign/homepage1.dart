import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mental_health_ai/Emergency/emergencypage.dart';
import 'package:mental_health_ai/GratitudeWall/gratitudeopeningsection.dart';
import 'package:mental_health_ai/HomePageDesign/MoodSection/moodsectionopening.dart';
import 'package:mental_health_ai/HomePageDesign/wellnesssection.dart';
import 'package:mental_health_ai/Notepad/notepadsection.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Homepage1 extends StatefulWidget {
  const Homepage1({super.key});

  @override
  State<Homepage1> createState() => _Homepage1State();
}

class _Homepage1State extends State<Homepage1> {
  bool _istypewrting=false;
  
ScrollController _scrollController=ScrollController();
bool _isScrolled=false;
bool _isVisible=false;
bool _isVisible1=false;


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
  final List<String> rightitems=["NoteBook","Emergency"];

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
      Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
          height: 400,
          width: double.infinity,
          child: Image.network(
            "https://i.imgur.com/eM1GEls.jpeg",
            fit: BoxFit.cover,
          ),
          
        ),
       
        ],
       
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
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
SizedBox(height: 40,),

           WellnessSection(),
           
          SizedBox(height: 40,),
             
             Text("A Space For Your Feelings",
             style: GoogleFonts.playfairDisplay(
              fontSize: 38,
              fontWeight: FontWeight.bold,
                color: Color(0xFF7B4B42),
              ),
              textAlign: TextAlign.center,
             ),
              const SizedBox(height: 16),
             Text(
              " This is your emotional safe zone",
              style: GoogleFonts.dancingScript(
                fontSize: 27,
               color: Colors.blueGrey,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
             SizedBox(height: 40,),
             Moodsectionopening(),
              SizedBox(height: 40,),


              VisibilityDetector(
                key: Key('type_writing'),
                onVisibilityChanged: (info) {
                  if(info.visibleFraction>0.3 && !_isVisible){
                    setState(() {
                      _isVisible=true;
                    });
                  }
                },
                child: 
                SizedBox(
                  height: 60,
                  child: DefaultTextStyle(
                    style: GoogleFonts.playfairDisplay(
                      fontSize:38,
                       color: const Color(0xFF7B4B42),
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none
                
                       ), 
                    child:_isVisible?
                    AnimatedTextKit(
                      isRepeatingAnimation: false,
                      animatedTexts: [
                 TypewriterAnimatedText('In the Quiet Corners of My Mind: A Personal Notebook of Thoughts and Musings',
                 speed: Duration(milliseconds: 100),
                 cursor: '|'
                 )
                    ]
                    ):Text('In the Quiet Corners of My Mind: A Personal Notebook of Thoughts and Musings')
                    ),
                
                  ),
              ),


               SizedBox(height: 16),
               Text(" Where ideas whisper, emotions breathe, and each page holds a piece of me,",
               style: GoogleFonts.dancingScript(
                fontSize: 27,
                 color: Colors.blueGrey,
                fontWeight: FontWeight.bold
                ),
               ),
               SizedBox(height: 20,),
               NotePadSection(),
              SizedBox(height: 40,),
               VisibilityDetector(
                key: Key('type_writing_1'),
                onVisibilityChanged: (info) {
                  if(info.visibleFraction>0.3 && !_isVisible){
                    setState(() {
                      _isVisible=true;
                    });
                  }
                },
                child: SizedBox(
                  height: 60,
                  child: DefaultTextStyle(
                    style: GoogleFonts.playfairDisplay(
                      fontSize:38,
                       color: const Color(0xFF7B4B42),
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none
                
                       ), 
                    child:_isVisible?
                    AnimatedTextKit(
                      isRepeatingAnimation: false,
                      animatedTexts: [
                 TypewriterAnimatedText('Things I’m Grateful For, Big and Small, That Make Life Magical',
                 speed: Duration(milliseconds: 100),
                 cursor: '|'
                 )
                    ]
                    ):Text('Things I’m Grateful For, Big and Small, That Make Life Magical')
                    ),
                
                  ),
              ),


               SizedBox(height: 16),
               Text('Tiny joys, warm feelings, and everything that makes me smile.',
               style: GoogleFonts.dancingScript(
                fontSize: 27,
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold
                ),
               ),
               Gratitudeopeningsection(),

               SizedBox(height: 40,),

               VisibilityDetector(
                key: Key('type_writing2'),
                onVisibilityChanged: (info) {
                  if(info.visibleFraction>0.3 && !_isVisible){
                    setState(() {
                      _isVisible1=true;
                    });
                  }
                },
                child: 
                SizedBox(
                  height: 60,
                  child: DefaultTextStyle(
                    style: GoogleFonts.playfairDisplay(
                      fontSize:38,
                       color: const Color(0xFF7B4B42),
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none
                
                       ), 
                    child:_isVisible1?
                    AnimatedTextKit(
                      isRepeatingAnimation: false,
                      animatedTexts: [
                 TypewriterAnimatedText('When Everything Feels Too Much and I Need Help Right Away',
                 speed: Duration(milliseconds: 100),
                 cursor: '|'
                 )
                    ]
                    ):Text('When Everything Feels Too Much and I Need Help Right Away')
                    ),
                
                  ),
              ),



              //  Text('When Everything Feels Too Much and I Need Help Right Away',
              //  style: GoogleFonts.playfairDisplay(
              //   fontSize: 38,
              //   color: Color(0xFF7B4B42),
              //   fontWeight: FontWeight.bold
              //   ),
              //  ),




               SizedBox(height: 16,),
               Text('This is a safe place to find calm, support, and someone who cares',
                style: GoogleFonts.dancingScript(
                fontSize: 27,
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold
                ),
               ),
             
               Emergencypage()
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
                      "Aranyak",
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





