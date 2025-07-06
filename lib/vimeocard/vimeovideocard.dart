import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui; // This still works for web builds
import 'dart:html' as html;
import 'package:google_fonts/google_fonts.dart';

class Vimeovideocard extends StatelessWidget {
  final String vimeoURL;
  final String title;
  final String description;
  final String viewID;

  const Vimeovideocard({
    super.key,
    required this.vimeoURL,
    required this.title,
    required this.description,
    required this.viewID,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ Register iframe only on web — and suppress analyzer warning
    if (kIsWeb) {
      //ignore:undefined_prefixed_name 
      ui.platformViewRegistry.registerViewFactory(viewID, (int _) {
        final iframe = html.IFrameElement()
          ..src = vimeoURL
          ..style.border = 'none'
          ..allowFullscreen = true
          ..width = '100%'
          ..height = '100%';
        return iframe;
      });
    }

    return Container(
      width: 600,
      height: 150,
      margin: EdgeInsets.symmetric(vertical: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 6),
          )
        ],
        border: Border.all(
          color: Colors.cyan,
          width: 4
        )
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 200,
            height: 130,
            child: kIsWeb
                ? HtmlElementView(viewType: viewID)
                : Center(child: Text('Only for web')),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7B4B42),
                    decoration: TextDecoration.none
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  description,
                  style: GoogleFonts.dancingScript(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                    decoration: TextDecoration.none
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
