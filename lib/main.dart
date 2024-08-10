import 'package:flutter/material.dart';
import 'package:flutter_post_request/widget.dart';

void main(){ 
  runApp(
   const MaterialApp( 
    home:FlutterPost() ,
  ));
}

class FlutterPost extends StatelessWidget {
  const FlutterPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar( 
        title: const Text("Post reqiest"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body:const FlutterTextBoxScreen(),
    );
  }
}