import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mental_health_ai/HomePageDesign/MoodSection/Models/custom_icon.dart';


class IconPickerGrid extends StatefulWidget {
  const IconPickerGrid({super.key});

  @override
  State<IconPickerGrid> createState() => _IconPickerGridState();
}

class _IconPickerGridState extends State<IconPickerGrid> {
  Future<List<CustomIcon>> loadIconLibrary() async {
  final jsonString = await rootBundle.loadString('assets/data/icon_library.json');
  final List<dynamic> jsonData = jsonDecode(jsonString);
  return jsonData.map((e) => CustomIcon.fromJson(e)).toList();
}
  List<CustomIcon> icons = [];

  @override
  void initState() {
    super.initState();

  
    loadIconLibrary().then((loadedIcons) {
      setState(() {
        icons = loadedIcons;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (icons.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: icons.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5, // adjust for responsiveness
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        final icon = icons[index];
        return GestureDetector(
          onTap: () {
            // TODO: Handle selection
            print("Selected: ${icon.name}");
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: Colors.black12,
                child: SvgPicture.asset(
                  icon.path,
                  width: 36,
                  height: 36,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                icon.name,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        );
      },
    );
  }
}
