
import 'package:flutter/material.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function()? onPress;
  final Color? bgColor;
  final Color txColor;
  final double? width;
  final double? height;
  
 CustomButton({
   required this.text,
 this.onPress, this.bgColor, this.width, this.txColor=Colors.white, this.height=35});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPress,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: bgColor,
            ),
        width: width,
        height: height,
          padding: EdgeInsets.all(8),
        child: CustomText(
          text: text,
          alignment: Alignment.center,
          color: txColor,
          fontSize: 12,
        ),
      ),
    );
  }
}
