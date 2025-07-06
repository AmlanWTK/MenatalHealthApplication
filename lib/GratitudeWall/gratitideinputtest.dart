

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_health_ai/GratitudeWall/gratitudewallpage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GratitudeEntryPage extends StatefulWidget {
  const GratitudeEntryPage({Key? key}) : super(key: key);

  @override
  State<GratitudeEntryPage> createState() => _GratitudeEntryPageState();
}

class _GratitudeEntryPageState extends State<GratitudeEntryPage> {
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
      'is_public': _isPublic,
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
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text('Gratitude Wall Entry',
          style: GoogleFonts.playfairDisplay(
            fontSize: 38,
             color: const Color(0xFF7B4B42),
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
          
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
      
      //  Padding(
      //   padding: const EdgeInsets.all(20),
      //   child: ListView(
      //     children: [
      //       const Text(
      //         'What are you grateful for today?',
      //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      //       ),
      //       const SizedBox(height: 12),
      //       TextField(
      //         controller: _textController,
      //         maxLines: 4,
      //         decoration: InputDecoration(
      //           hintText: 'e.g. I’m grateful for a peaceful morning walk.',
      //           border: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(12),
      //           ),
      //           contentPadding: const EdgeInsets.all(16),
      //         ),
      //       ),
      //       const SizedBox(height: 16),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           const Text('Make public (anonymous)?'),
      //           Switch(
      //             value: _isPublic,
      //             onChanged: (val) {
      //               setState(() {
      //                 _isPublic = val;
      //               });
      //             },
      //           ),
      //         ],
      //       ),
      //       const SizedBox(height: 12),
      //       DropdownButtonFormField<String>(
      //         value: _selectedCategory,
      //         decoration: const InputDecoration(
      //           labelText: 'Category (optional)',
      //           border: OutlineInputBorder(),
      //         ),
      //         items: _categories
      //             .map((cat) => DropdownMenuItem(
      //                   value: cat,
      //                   child: Text(cat),
      //                 ))
      //             .toList(),
      //         onChanged: (val) {
      //           setState(() {
      //             _selectedCategory = val;
      //           });
      //         },
      //       ),
      //       const SizedBox(height: 20),
      //       ElevatedButton.icon(
      //         icon: const Icon(Icons.favorite, color: Colors.white),
      //         label: const Text('Submit Gratitude'),
      //         onPressed: submitGratitudeEntry,
      //         style: ElevatedButton.styleFrom(
      //           padding: const EdgeInsets.symmetric(vertical: 16),
      //           textStyle: const TextStyle(fontSize: 16),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
