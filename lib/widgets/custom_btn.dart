import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String? text;
  final Function()? onPressed;
  final bool? outlineBtn;
  final bool? isLoading;
  final Color? bgColor;
  final Color txtColor;
  final Color? borderColor;
  final double height;
  final double width;
  final double fontSize;
  const CustomBtn(
      {Key? key,
      this.text,
      this.onPressed,
      this.outlineBtn,
      this.isLoading,
      this.bgColor,
      this.txtColor = Colors.white,
      this.height = 50,
      this.width = 250,

      this.borderColor, this.fontSize=16 })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _outlineBtn = outlineBtn ?? false;
    bool _isLoading = isLoading ?? false;
    Color? _borderColor=borderColor ?? bgColor;
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: _outlineBtn ? Colors.transparent : bgColor,
          border: Border.all(
            color: _borderColor!,
            width: 1,
          ),
          // borderRadius: BorderRadius.circular(30)
        ),
        // margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Stack(
          children: [
            Visibility(
              visible: _isLoading ? false : true,
              child: Center(
                child: Text(
                  text.toString(),
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,
                    color: txtColor,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _isLoading,
              child: Center(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
