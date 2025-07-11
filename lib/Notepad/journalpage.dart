import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mental_health_ai/Navbar/customnavbar.dart';
import 'package:mental_health_ai/Notepad/journaleditorpage.dart';
 // ✅ Add this line

class JournalPage extends StatefulWidget {
  const JournalPage({super.key});

  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  final List<Map<String, String>> entries = [];

  // ✅ For scroll-aware navbar
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  bool _isVisible=false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final scrolled = _scrollController.offset > 20;
      if (scrolled != _isScrolled) {
        setState(() => _isScrolled = scrolled);
      }
    });
  }

  Future<void> _openEditior() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => JournalEditorPage()),
    );

    if (result != null || result is Map<String, String>) {
      setState(() {
        entries.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2F9),
     body: SafeArea(
  child: LayoutBuilder(
    builder: (context, constraints) {
      return SingleChildScrollView(
        controller: _scrollController,
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: IntrinsicHeight(
            child: Column(
              children: [
                // ✅ Top navbar
                CustomNavBar(isScrolled: _isScrolled),

                // ✅ Page title
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: SizedBox(
                    height: 60,
                    child: DefaultTextStyle(
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 38,
                        color: const Color(0xFF5B3E37),
                        fontWeight: FontWeight.bold,
                      ),
                      child: AnimatedTextKit(
                        isRepeatingAnimation: false,
                        animatedTexts: [
                          TypewriterAnimatedText(
                            'Your Own Journal Page',
                            speed: Duration(milliseconds: 100),
                            cursor: '|',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // ✅ Journal Entry Section (no fixed height)
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    margin: const EdgeInsets.all(24),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5FAFD),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome\nBack!",
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 38,
                            color: const Color(0xFF5B3E37),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
Center(
  child: ClipRRect(
    borderRadius: BorderRadius.circular(18),
    child: Lottie.asset(
      'assets/animations/writingpad.json',
      height: 310,
      width: 420,
     
      fit: BoxFit.cover,
    ),
  ),
),

                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Continue",
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 38,
                                color: const Color(0xFF5B3E37),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // ✅ Entries list
                        SizedBox(
                          height: 100,
                          child: entries.isEmpty
                              ? Center(
                                  child: Text(
                                    "No Entries Yet....",
                                    style: GoogleFonts.dancingScript(
                                      color: const Color(0xFF5B3E37),
                                      fontSize: 22,
                                    ),
                                  ),
                                )
                              : ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final entry = entries[index];
                                    return GestureDetector(
                                      onTap: () async {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => JournalEditorPage(
                                              initialData: entry,
                                            ),
                                          ),
                                        );
                                        if (result != null && result is Map<String, String>) {
                                          setState(() {
                                            entries[index] = result;
                                          });
                                        }
                                      },
                                      child: Container(
                                        width: 160,
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE8E0DC),
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              entry['title'] ?? '',
                                              style: GoogleFonts.playfairDisplay(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              (entry['body'] ?? '').split('\n').first,
                                              style: GoogleFonts.dancingScript(
                                                color: const Color(0xFF5B3E37),
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              entry['date'] ?? '',
                                              style: GoogleFonts.dancingScript(
                                                fontSize: 12,
                                                color: const Color(0xFF5B3E37),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                                  itemCount: entries.length,
                                ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Text(
                            "or Start a new one",
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 30,
                              color: const Color(0xFF5B3E37),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Center(
                          child: GestureDetector(
                            onTap: _openEditior,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFF7B4B42),
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(10),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                          ),
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
    },
  ),
),
    );
  }
}