import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


class JournalEditorPage extends StatefulWidget {
  //if we edit an exixting journal entry this receives data
  final Map<String,String>? initialData;
  const JournalEditorPage({
    super.key,
    this.initialData
    });

  @override
  State<JournalEditorPage> createState() => _JournalEditorPageState();
}

class _JournalEditorPageState extends State<JournalEditorPage> {


   final TextEditingController _titlecontroller=TextEditingController();
   final TextEditingController _bodycontroller=TextEditingController();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    //if editing fill the text fields with old data
    if(widget.initialData !=null){//accessing the data map from the previous page
      _titlecontroller.text=widget.initialData!['title'] ?? '';
      _bodycontroller.text=widget.initialData!['body'] ?? '';
    }
  }

//saving the journal
   void _saveRntry(){
    final title=_titlecontroller.text.trim();
    final body=_bodycontroller.text.trim();

   if(title.isEmpty || body.isEmpty){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Please fill in both fields"))
    );
    return;
   }
//formatting the data
   final String date = DateFormat('MMMM dd, yyyy').format(DateTime.now());
//returning the journal entry as a map 
   Navigator.pop(context,
   {
'title':title,
'body':body,
'date':date
   }
   );

   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFFFDF4F1) ,
      
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
            
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: SingleChildScrollView(

           
    

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Center(
                child: GestureDetector(
                  onTap:(){
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF7B4B42),
      shape: BoxShape.circle,

                    ),
                    padding: EdgeInsets.all(5),
                    child: Icon(Icons.arrow_back, color: Colors.white, size: 20,),
                  ),
                ),
              ),
 ElevatedButton.icon(
        onPressed: _saveRntry, 
        label: Text('Save',style: GoogleFonts.playfairDisplay(
          color: Color(0xFF5B3E37),
          ),
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
          ),
        ),


                        ],
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    controller: _titlecontroller,
                    style: GoogleFonts.playfairDisplay(
                     color: Color(0xFF5B3E37),
                     fontSize: 28,
                     fontWeight: FontWeight.bold
                      ),
                      decoration: InputDecoration(hintText: 'Title', border: InputBorder.none,
                      hintStyle: GoogleFonts.playfairDisplay(
                        color:   Color(0xFF5B3E37),
                       )),
                  ),
                 
                  TextField(
                    controller: _bodycontroller,
                    //for allowing multilines
          
                    keyboardType: TextInputType.multiline,
                    maxLength: null,
                    style: GoogleFonts.dancingScript(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5B3E37),
                      ),
                      decoration: InputDecoration(
                        hintText: "Start Writing Your Thoughts",
                        border: InputBorder.none
                      ),
          
                  )
                ],
              ),
            ),
            ),
        ),
      ),
    );
  }
}