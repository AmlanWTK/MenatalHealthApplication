import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:visibility_detector/visibility_detector.dart';

class InnerCompassChatAi extends StatefulWidget {
  const InnerCompassChatAi({super.key});

  @override
  State<InnerCompassChatAi> createState() => _InnerCompassChatAiState();
}

class _InnerCompassChatAiState extends State<InnerCompassChatAi> {
bool _isVisible=false;
  
  // List to hold chat messages (sender, text, timestamp)
  final List<Map<String, dynamic>> _messages = [
  {
    "sender": "bot",
    "text": "Hi! I'm your meditation guide. Ready to help you find calm and clarity.",
    "time": DateTime.now(),
  },
];



final List<String> _suggestionPrompts = [
  "Guide me through a quick meditation.",
  "How do I start meditating?",
  "Help me focus on my breath.",
  "I feel overwhelmed — what can I do?",
  "Give me a grounding mindfulness practice.",
];

  // Text controller for the user input field
  final TextEditingController _controller = TextEditingController();

  // Scroll controller to keep the chat view auto-scrolling to the bottom
  final ScrollController _scrollController = ScrollController();

  // Function to handle sending the user's message
  void _sendMessage([String?textOverride]) {
   final text = textOverride ?? _controller.text.trim();
    if (text.isEmpty) return;

    // Add user's message to the chat list
    setState(() {
      _messages.add({
        "sender": "user",
        "text": text,
        "time": DateTime.now(),
      });
    });

    _controller.clear(); // Clear the input box
    _autoScroll();       // Scroll to bottom
    _getAIResponse(text); // Send message to AI and get reply
  }

  // Function to send user message to Ollama (local AI) and receive response
  Future<void> _getAIResponse(String userInput) async {
    final url = Uri.parse("http://localhost:11434/api/generate");

    try {
      // Make POST request to Ollama with prompt
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "model": "mistral",     // Your running Ollama model
          "prompt": userInput,    // User's message as prompt
          "stream": false         // We wait for full response (no streaming yet)
        }),
      );

      if (response.statusCode == 200) {
        // Decode the JSON response from Ollama
        final data = jsonDecode(response.body);
        final reply = data['response'] ?? "Sorry, I didn't understand that.";

        // Add AI's reply to the chat list
        setState(() {
          _messages.add({
            "sender": "bot",
            "text": reply,
            "time": DateTime.now(),
          });
        });
      } else {
        // Handle non-200 errors (e.g. 500, 404)
        setState(() {
          _messages.add({
            "sender": "bot",
            "text": "API Error (${response.statusCode})",
            "time": DateTime.now(),
          });
        });
      }
    } catch (e) {
      // Handle network or decoding errors
      setState(() {
        _messages.add({
          "sender": "bot",
          "text": "Connection Error: ${e.toString()}",
          "time": DateTime.now(),
        });
      });
    }

    _autoScroll(); // Scroll to show the latest message
  }

  // Automatically scrolls to bottom of the chat after new messages
  void _autoScroll() {
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  // Builds individual message UI bubble
 Widget _buildMessage(Map<String, dynamic> message) {
  final isUser = message['sender'] == 'user';

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        // 1️⃣ BOT AVATAR (on left)
        if (!isUser)
          CircleAvatar(
            backgroundColor: Colors.teal,
            child: const Icon(Icons.smart_toy, color: Colors.white),
          ),
        if (!isUser) const SizedBox(width: 8),

        // 2️⃣ MESSAGE BUBBLE
        Flexible(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isUser ? Colors.blue.shade400 : Colors.teal.shade100,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(18),
                topRight: const Radius.circular(18),
                bottomLeft: Radius.circular(isUser ? 18 : 0),
                bottomRight: Radius.circular(isUser ? 0 : 18),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message['text'],
                  style: TextStyle(
                    color: isUser ? Colors.white : Colors.black87,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _formatTime(message['time']),
                  style: TextStyle(
                    fontSize: 10,
                    color: isUser ? Colors.white70 : Colors.black45,
                  ),
                )
              ],
            ),
          ),
        ),

        if (isUser) const SizedBox(width: 8),
        // 3️⃣ USER AVATAR (on right)
        if (isUser)
          const CircleAvatar(
            backgroundColor: Colors.blue,
            child: Icon(Icons.person, color: Colors.white),
          ),
      ],
    ),
  );
}

  // Formats DateTime into hh:mm format for timestamps
  String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title:VisibilityDetector(
          key: Key("Chat_ai"), 
        
          onVisibilityChanged: (info){
            if (info.visibleFraction > 0.3 && !_isVisible){
               setState(() {
                 _isVisible=true;
               });
            }
          },
          
          child: _isVisible?
          
          
           Center(child:SizedBox(
          height: 40,
          child:  DefaultTextStyle(
          style:GoogleFonts.dancingScript(
            fontSize: 38,
            color: const Color(0xFF7B4B42),
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none
            
          ) , 
          child: AnimatedTextKit(
            isRepeatingAnimation: false,
            animatedTexts: [
              TypewriterAnimatedText('Whispered Guidance into the Night',
              speed: Duration(milliseconds: 100),
              cursor: "|"
              
              )

          ])
          ),
        )
        
        
        
      
        ):Text('Whispered Guidance into the Night')
          )
        
        ,
        backgroundColor: Colors.white,
      ),
      body: Container(
         decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2), 
            gradient: LinearGradient(colors: [
               Colors.blue.shade100,
                    Colors.white70,
                  Color(0xFFF8EDE3),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            )
           ),
        child: Column(
          
          children: [
        
            //suggested propmt screen
            Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
          color: Colors.grey[100],
          child: Wrap(
            spacing: 8,
            runSpacing: 10,
            children: _suggestionPrompts.map((propmpt){
            return ActionChip(
              label: Text(propmpt),
              backgroundColor: Colors.teal.shade50,
              onPressed: ()=>_sendMessage(propmpt),
             labelStyle: TextStyle(color: Colors.teal),
            );
            }).toList(),
          ),
            ),
            // Chat list
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _buildMessage(_messages[index]);
                },
              ),
            ),
            // Message input area
            Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                children: [
                  // Text input field
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Type something...",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Send button
                  CircleAvatar(
                    backgroundColor: Colors.teal,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: _sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
