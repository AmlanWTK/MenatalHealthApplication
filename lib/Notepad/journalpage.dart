import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_health_ai/Notepad/journaleditorpage.dart';

class JournalPage extends StatefulWidget {

   const JournalPage({super.key});

  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {

  //aa list to store a;; the journal entries 
final List<Map<String, String>> entries=[];
//this function will trigger when someone will click add icom
Future<void> _openEditior()async{
final result=await Navigator.push(context, MaterialPageRoute(builder: (_)=>JournalEditorPage()));

if(result!=null || result is Map<String,String>){
  setState(() {
    entries.add(result);
  });
}

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF4F1),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(24),
          margin: EdgeInsets.all(24),
          height: 700,
          width: 700,
          decoration: BoxDecoration(
            color: Colors.white,
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
              Text("Welcome\nBack!",
              style: GoogleFonts.playfairDisplay(
                fontSize: 38,
              color: Color(0xFF5B3E37),
                     fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10,),
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.network("https://i.imgur.com/mKjLX49.jpeg",
                    height: 210,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Text( 'Reflect yourself\nIt\'s time for healing',
                    style: GoogleFonts.dancingScript(
                      fontSize:16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                            Shadow(
                              blurRadius: 8,
                              color: Colors.black.withOpacity(0.5),
                              offset: Offset(1, 1),
                            )
                      ]
                       ),
                    )
                    )
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Continue",
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 38,
                    color: Color(0xFF5B3E37),
                    fontWeight: FontWeight.bold
                  ),
                  )
                ],
              ),
              SizedBox(height: 12,),
              SizedBox(
                height: 100,
                child: entries.isEmpty?
                Center(
                  child: Text("No Entries Yet....",
                  style: GoogleFonts.dancingScript(
                    color: Color(0xFF5B3E37),
                    fontSize: 22
                    ),
                  )
                ):ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder:(context, index){
                  final entry=entries[index];
                  return  GestureDetector(
                    onTap: () async{
                      //on taping the card the editior with the exizting data
                      final result=await Navigator.push(context, MaterialPageRoute(builder: (_)=>JournalEditorPage(initialData: entry,)));
                     
                        //after edit update the entry
                      if(result!=null && result is Map<String,String>){
                        setState(() {
                          entries[index]=result;
                        });
                      }
                    },

                     child:   Container(
                         width: 160,
                         padding: EdgeInsets.all(12),
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
                                fontWeight: FontWeight.bold
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,//if thr text is too long to fit cut them and show ...
                            ),

                            SizedBox(height: 4,),

                            //body preview
                            Text(
                                (entry['body'] ?? '').split('\n').first,//taking data form the bpdy if the body is empty then null if not break them into lines and take the first line
                                  style: GoogleFonts.dancingScript(
                                      color: Color(0xFF5B3E37),

                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                            ),
                                SizedBox(height: 4,),
                                Text(
                                  entry['date'] ?? '',
                                  style: GoogleFonts.dancingScript(
                                    fontSize: 12,
                                     color: Color(0xFF5B3E37),
                                    ),
                                )
                          ],
                         ),)
                  );
               

               
                  
                  
               
                  } , 
                  //giveing space between every item of the list
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                   itemCount: entries.length
              )
              ),
              SizedBox(height: 10,),

              Center(
                child: Text(   "or Start a new one",
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 30,
                     color: Color(0xFF5B3E37),
                      fontWeight: FontWeight.bold
                            
                      ),
                ),
              ),
              SizedBox(height: 15,),
              Center(
                child: GestureDetector(
                  onTap: _openEditior,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF7B4B42),
      shape: BoxShape.circle,

                    ),
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.add, color: Colors.white, size: 28,),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}