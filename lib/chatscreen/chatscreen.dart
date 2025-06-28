import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // List to hold chat messages (sender, text, timestamp)
  final List<Map<String, dynamic>> _messages = [
    {
      "sender": "bot",
      "text": "Hello! I'm your mental health assistant. How are you today?",
      "time": DateTime.now(),
    },
  ];

  // Text controller for the user input field
  final TextEditingController _controller = TextEditingController();

  // Scroll controller to keep the chat view auto-scrolling to the bottom
  final ScrollController _scrollController = ScrollController();

  // Function to handle sending the user's message
  void _sendMessage() {
    final text = _controller.text.trim();
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
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 280),
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
        title: const Text("Mental Health Chat"),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
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
    );
  }
}
