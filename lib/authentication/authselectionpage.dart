import 'package:flutter/material.dart';
import 'package:mental_health_ai/authentication/loginpage.dart';
import 'package:mental_health_ai/authentication/signuppage.dart';

class Authselectionpage extends StatelessWidget {
  const Authselectionpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFF305C4E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(child: Text("Mental Health Ai")),
        ),
        body: Center(
          child: Container(
            height: 400,
            width: 400,
            decoration: BoxDecoration(
              color: const Color(0xFF366C56), 
              borderRadius: BorderRadius.circular(30)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage(),));
                  },
                   child: Text("Sign Up")
                   ),
            
                   SizedBox(height: 20,),
            
                   ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LogInPage()));
                    }, 
                    child: Text("Login Page")
                    )
              ],
            ),
          ),
        ),
    );
  }
}