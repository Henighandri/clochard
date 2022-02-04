import 'package:flutter/material.dart';

class CustomIconCart extends StatelessWidget {
  const CustomIconCart({
    Key? key,
    this.numOftItems = 0,
    @required this.press,
    this.iconColor = Colors.white,
  }) : super(key: key);

  final Color iconColor;
  final int numOftItems;
  final Function()? press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        margin: EdgeInsets.only(top: 8),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  
                ),
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: iconColor,
                )),
            if (numOftItems != 0)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  height: 16,
                  width: 16,
                  padding: EdgeInsets.all(1),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(width: 1.5, color: Colors.white),
                  ),
                  child: Text(
                    "${numOftItems}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        height: 1,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
