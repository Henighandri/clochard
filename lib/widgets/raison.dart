import 'package:clochard/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class Raison extends StatelessWidget {
  const Raison({ Key? key, required this.image, required this.title, required this.description }) : super(key: key);
  final String image;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Image.asset(image),
        SizedBox(height: 10,),
        CustomText(text: title,fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black,),
        SizedBox(height: 10,),
        CustomText(text: description,fontSize: 12,color: Colors.grey,),
      ],),


      
    );
  }
}