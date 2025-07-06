import 'dart:math';

import 'package:flutter/material.dart';

class GratitudeWallApp extends StatelessWidget {
  const GratitudeWallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GratitudeWall(),
    );
  }
}

class GratitudeEntry {
  final String text;
  final Color color;
  GratitudeEntry(this.text, this.color);
}

class GratitudeWall extends StatefulWidget {
  const GratitudeWall({super.key});

  @override
  State<GratitudeWall> createState() => _GratitudeWallState();
}

class _GratitudeWallState extends State<GratitudeWall> {
  final TextEditingController _controller = TextEditingController();
  final List<GratitudeEntry> _gratitudes = [];

  final List<Color> leafColors = [
    Color(0xFFDCE6D3),
    Color(0xFFFFF3CD),
    Color(0xFFFFD6A5),
    Color(0xFFFFC8DD),
    Color(0xFFC3F0CA),
    Color(0xFFE0BBE4),
  ];

  void _addGratitude() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final random = Random();
    final color = leafColors[random.nextInt(leafColors.length)];

    setState(() {
      _gratitudes.add(GratitudeEntry(text, color));
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Gratitude Leaf Wall"),
        backgroundColor: Colors.green.shade700,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Input section
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        labelText: "What are you grateful for today?",
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        onPressed: _addGratitude,
                        icon: const Icon(Icons.eco),
                        label: const Text("Add Leaf"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Leaf Wall Section
            Wrap(
              alignment: WrapAlignment.center,
              children: _gratitudes.map((entry) {
                final tilt = Random().nextDouble() * 0.3 - 0.15;
                return Transform.rotate(
                  angle: tilt,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(10),
                    width: 120,
                    decoration: BoxDecoration(
                      color: entry.color,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      entry.text,
                      style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                    ),
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
