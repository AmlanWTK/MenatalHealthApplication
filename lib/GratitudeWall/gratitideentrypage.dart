

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_health_ai/GratitudeWall/gratitudewallpage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:visibility_detector/visibility_detector.dart';

class GratitudeEntryPage extends StatefulWidget {
  const GratitudeEntryPage({Key? key}) : super(key: key);

  @override
  State<GratitudeEntryPage> createState() => _GratitudeEntryPageState();
}

class _GratitudeEntryPageState extends State<GratitudeEntryPage> {

  bool _isVisible=false;
  final _textController = TextEditingController();
  bool _isPublic = false;
  String? _selectedCategory;

  final List<String> _categories = [
    'Family',
    'Nature',
    'Food',
    'Self-Growth',
    'Work',
    'Health',
    'Other',
  ];

  /// Submits a gratitude entry to Supabase with the values from the form
  Future<void> submitGratitudeEntry() async {
    final text = _textController.text.trim();

    // Check if the user wrote something
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please write what you are grateful for.')),
      );
      return;
    }

    // 🔐 Check if user is logged in (required by RLS policy)
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must be logged in to submit.')),
      );
      print('❌ Not logged in. Insert blocked.');
      return;
    }

    // Prepare data for Supabase
    final Map<String, dynamic> data = {
      'text': text,
      'is_public': true,
      'category': _selectedCategory,
    };

    try {
      // Insert into the gratitude_entries table
      final response = await Supabase.instance.client
          .from('gratitude_entries')
          .insert(data);

      // ✅ Handle successful insert
      if (response == null || (response is List && response.isEmpty)) {
        Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (_) => const GratitudeWallPage()),
);

        print('✅ Entry added.');
        _textController.clear();
        setState(() {
          _isPublic = false;
          _selectedCategory = null;
        });
      } else {
        print('✅ Insert response: $response');
      }
    } catch (error) {
      // ❌ Catch and show errors
      print('❌ Insert error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error submitting gratitude: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor:    Colors.green.shade100,
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title:VisibilityDetector(
          key: Key("grat_page"), 
          
           onVisibilityChanged:(info){
            if(info.visibleFraction> 0.3 && !_isVisible){
              setState(() {
                _isVisible=true;
              });
            }
           },
           child: 
         Padding(
          padding: const EdgeInsets.only(top: 10),
          child:
          SizedBox(
                            height: 60,
                            child: DefaultTextStyle(
                              style:GoogleFonts.playfairDisplay(
                                fontSize: 38,
                                color: const Color(0xFF7B4B42),
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none
               
                                ),
                              child: _isVisible?
                             
                             
                               AnimatedTextKit(
                                isRepeatingAnimation: false,
                                animatedTexts: [
                                      TypewriterAnimatedText(
                                        'Notes of Gratitude: A Wall of Kind Words and Bright Moments',
                                        speed: Duration(milliseconds: 100),
                                        cursor: '|'
                                      )  
                                ]
                                ):Text('Notes of Gratitude: A Wall of Kind Words and Bright Moments')
                              ),
                           
                            ),


        
        ),
           ),
        
        
        centerTitle: true,
      ),
      body:Center(
  child: ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Stack(
      children: [
        // Background image
        Image.network(
          'https://i.imgur.com/aotL1md.jpeg',
          fit: BoxFit.cover,
          height: 600,
          width: 900,
        ),

        // Optional border overlay
        Container(
          height: 600,
          width: 900,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.blueGrey,
              width: 5,
            ),
          ),
        ),

        // Centered content with spacing
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(32.0), // Add spacing from edges
            child:
             Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "What are you grateful for?",
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 30,
                    color: const Color(0xFF7B4B42),
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 20),

                // Text input
                TextField(
                  controller: _textController,
                  maxLines: null,
                  scrollPhysics: BouncingScrollPhysics(),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8), // background for readability
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    hintText: ' e.g. I am grateful for the family I am born into',
                    hintStyle: GoogleFonts.dancingScript(
                      fontSize: 20,
                      color: const Color(0xFF7B4B42),
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                 const SizedBox(height: 40),
                       
           ElevatedButton(
            onPressed:submitGratitudeEntry ,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueGrey,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16,horizontal: 16),
              textStyle: GoogleFonts.playfairDisplay(fontSize: 16)
            ), 
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                        Icon(Icons.favorite,color: Colors.white,),
                        SizedBox(width: 8,),
                        Text("Submit Gratitude"),
                        SizedBox(width: 8,),
                        Icon(Icons.favorite,color: Colors.white,)
              ],
            )
            )
      
              ],
            ),
          ),
        ),
      ],
    ),
  ),
),

    );
  }
}
