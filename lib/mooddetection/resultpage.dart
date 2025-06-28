
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ResultPage extends StatelessWidget {
  final Map<String, int> emotionScores;

  const ResultPage({super.key, required this.emotionScores});

  String _getAnimations(String emotion){
    switch(emotion){
      case 'joy':
      return 'assets/animations/happy.json';
      case 'sadness':
      return 'assets/animations/sad.json';
      case 'anger':
      return 'assets/animations/anger.json';
      case 'fear':
      return 'assets/animations/fear.json';
      case 'love':
      return 'assets/animations/love.json';
      default:
       return 'assets/animations/sad.json';

    }
  }
 // 🎨 Get message based on emotion
  String _getMessage(String emotion) {
    switch (emotion) {
      case 'joy':
        return "You seem really happy today! Something wonderful must’ve happened.";
      case 'sadness':
        return "It feels like you're sad today. Would you like to talk about it?";
      case 'anger':
        return "You’re feeling angry today. Let’s try to find a way to calm down together.";
      case 'fear':
        return "You might be feeling anxious. Take a deep breath — everything will be okay.";
      case 'love':
        return "You’re feeling loved today! Why not write down that special moment?";
      default:
        return "Your mood today is unique. Stay mindful and take care of yourself!";
    }
  }

  double _normalize(int value, int max) => (value / max).clamp(0, 1);

  String _getEmoji(String emotion) {
    switch (emotion) {
      case 'joy': return '😊';
      case 'sadness': return '😢';
      case 'anger': return '😡';
      case 'fear': return '😨';
      case 'love': return '❤️';
      default: return '🤔';
    }
  }

  String _getTopEmotion(){
    String topEmotion='';
    int topScore=-1;
    emotionScores.forEach((emotion, score){//This goes through each key-value pair in your emotionScores map
if(score>topScore){
  topScore=score;
  topEmotion=emotion;
}
    });
    return topEmotion;
  }

  //shpw action based on emotions 
  Widget _getActionButton(String emotion, BuildContext context){
    if(emotion=='joy' || emotion=='love'){
      return TextButton.icon(
        onPressed: (){},
        icon: Icon(Icons.note_alt),
         label: Text("Write on Notebook")
         );
    }else if(emotion=='sadness' || emotion=='anger' || emotion=='fear'){
    return TextButton.icon(
      onPressed:(){

      } , 
      icon: Icon(Icons.chat),
      label: Text("Chat with me ")
      );
    }else {
      return SizedBox.shrink();//no actions
    }

    
  }

  @override
  Widget build(BuildContext context) {
    final topEmotion=_getTopEmotion();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Mood Today"),
        backgroundColor: Colors.teal,
      ),
      body:Center(
        child: Padding(padding: EdgeInsets.all(24),
        child: Container(
             padding: EdgeInsets.all(20),
             decoration: BoxDecoration(
              color: Colors.teal.shade50,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.teal.withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset(0, 6)
                )
              ]
             ),
             child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 200,
                  child: Lottie.asset(_getAnimations(topEmotion)),
                ),
                SizedBox(height: 20,),

                Text(
                  _getMessage(topEmotion),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 24,),


                //Button
                _getActionButton(topEmotion, context)
              ],
             ),
        ),
        ),
      )
      
       
    );
  }
}
