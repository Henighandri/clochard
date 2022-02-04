import 'package:flutter/material.dart';




class FormError extends StatelessWidget {
  const FormError({
    Key? key,
    required this.errors, this.txtColor=Colors.white,
  }) : super(key: key);

  final List<String> errors;
  final Color txtColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
                errors.length, (index) => FormErrorText(errors[index])
                ),
      
    );
  }

  Widget FormErrorText(String error) {
    return Row(
       children: [
         Icon(Icons.error,color: Colors.red),
        
         SizedBox(width: 10,),
         Text(error,style: TextStyle(color: txtColor),textAlign: TextAlign.left,),
       ],
            );
  }
}