import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mental_health_ai/VisibilityDetector/slidefadeinonvisible.dart';
import 'package:url_launcher/url_launcher.dart';

class Emergencypage extends StatelessWidget {
  const Emergencypage({super.key});

  // Phone call function
  Future<void> _makephonecall(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlideFadeInOnVisible( 
      duration: Duration(milliseconds: 800), 
      offset: Offset(0, 2), 
      curve: Curves.easeOut, 
      visibilityKey: Key('emergency_page'),
      child:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1400),
            child: Container(
              height: 600,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                      const Color(0xFFB2EBF2),
                    
                       Colors.purple.shade200,
                    
                    ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blueGrey, width: 5),
              ),
              child: Row(
                children: [
                  // Left content
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 24),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Kaan Pete Roi – Emotional Support Helpline",
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF7B4B42),
                                  decoration: TextDecoration.none
                              ),
                            ),
                        
                            SizedBox(height: 12,),
                            Text(''' Kaan Pete Roi is Bangladesh’s first emotional support helpline, offering a safe and anonymous space to talk. Volunteers are trained to listen with empathy — no judgment, just support when you need it most.
It's completely free, confidential, and available when you feel overwhelmed.
Whether you're feeling lost, anxious, or just need to be heard — someone is always ready to listen..''',
                            style: GoogleFonts.dancingScript(fontSize: 22,fontWeight: FontWeight.bold,  decoration: TextDecoration.none,
                                color: Colors.blueGrey ),
                            ),
                            const SizedBox(height: 12),
                            // Motivational quote
                            
                            const SizedBox(height: 18),
                            _infoRow("🕒", "Available: 3 PM – 3 AM"),
                            _infoRow("🌍", "Language: Bengali & English"),
                            _infoRow("🔒", "Your call is confidential and free."),
                            _infoRow("☎️", "Landline: 880-2-9130355"),
                            const SizedBox(height: 10),
                            ElevatedButton.icon(
                              onPressed: () => _makephonecall('88029130355'),
                              icon: const Icon(Icons.call, color: Colors.white),
                              label:  Text("Call Landline", style: GoogleFonts.dancingScript(color: Colors.white, fontWeight: FontWeight.bold,  decoration: TextDecoration.none),),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                            const SizedBox(height: 7),
                            _infoRow("📱", "Mobile: +8801700758590"),
                            const SizedBox(height: 10),
                            ElevatedButton.icon(
                              onPressed: () =>
                                  _makephonecall('+8801700758590'),
                              icon: const Icon(Icons.phone_android,
                                  color: Colors.white,),
                              label:  Text("Call Mobile",style: GoogleFonts.dancingScript(color: Colors.white,  decoration: TextDecoration.none),),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                           SizedBox(height: 20,),
                            Divider(),
                            Row(
                              children: [
                                const Icon(Icons.email_outlined,
                                    color: Colors.grey, size: 18),
                                const SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () async{
                                    final Uri emailLaunchUri=Uri(
                                           scheme: 'mailto',
                                           path:  'support@kaanpeteroi.org',
                                           query: 'subject=Need Suuport & body=Hello, I need help with ...',
                                    );
                                    if(await canLaunchUrl(emailLaunchUri)){
                                      await launchUrl(emailLaunchUri);
                                    }else{
                                      throw 'Could not launch email';
                                    }
                                  },
                                  child: Text('support@kaanpeteroi.org',
                                  style: GoogleFonts.playfairDisplay(fontSize: 18, color: Colors.blueGrey, fontWeight: FontWeight.bold,  decoration: TextDecoration.none),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Right image
                  Expanded(
                    flex: 1,

                    child:Center(
                      child: Stack(
                        children: [
                           ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15)
                        ),
                        child: Lottie.asset(
                          'assets/animations/calling1.json',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      
                                       Align(
                        alignment: Alignment.center,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 450), // or any width you prefer
                         
                        ),
                      )
                      ,
                      
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Container(
                             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                )
                              ]
                            ),
                            child: Text('''Reaching out is not a sign of weakness — it’s a step toward healing.\nSometimes, the bravest thing you can do is ask for help.\n You don’t have to go through it alone.''',
                            style: GoogleFonts.dancingScript(
                               fontSize: 20,
                                      color: Colors.blueGrey.shade800,
                                      decoration: TextDecoration.none
                            ),
                            textAlign: TextAlign.center,
                            ),
                          ),
                          ),
                      ),
                        ],
                      ),
                    )
                    
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      );


     
  
  }

  // Widget to build emoji + info row
  Widget _infoRow(String emoji, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 8),
          Expanded(
              child: Text(
            text,
            style: GoogleFonts.playfairDisplay(fontSize: 16),
          )),
        ],
      ),
    );
  }
}
