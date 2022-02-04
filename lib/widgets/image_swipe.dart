import 'package:clochard/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../responsive.dart';

class ImageSwipe extends StatefulWidget {
  final List? imageList;
  final bool imageProduit;
  final Function()? pressDrawer;
  const ImageSwipe({Key? key, this.imageList,required this.pressDrawer, this.imageProduit=false}) : super(key: key);
  @override
  _ImageSwipeState createState() => _ImageSwipeState();
}

class _ImageSwipeState extends State<ImageSwipe> {
  PageController pageController = PageController(initialPage: 0);

  int selectedImage = 0;

  @override
  void initState() {
    // TODO: implement initState
  

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final bool isTablet=Responsive.isTablet(context);
    return Container(
      height:widget.imageProduit?400: isTablet ? 270: 350,
      // width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (value) {
              setState(() {
                selectedImage = value;
              });
            },
            children: [
              for (var i = 0; i < widget.imageList!.length; i++)
                Container(
                 
                 height:widget.imageProduit?400: isTablet ? 270: 350,
                  child: Stack(
                    children: [
                      widget.imageProduit
                      ?FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                         image:"${widget.imageList![i]}",
                       width:MediaQuery.of(context).size.width ,
                      
                        fit: BoxFit.contain,)
                      :Image.asset(
                        "${widget.imageList![i]}",
                        width:MediaQuery.of(context).size.width ,
                        fit: BoxFit.fill,
                       

                      ),
                       if(!widget.imageProduit)
                      Container(
                        height: 350,
                        color: Colors.black.withOpacity(.2),
                      ),
                    ],
                  ),
                )
            ],
          ),
          if(!widget.imageProduit)
          CustomAppBar(pressDrawer:widget.pressDrawer ,),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 for (var i = 0; i < widget.imageList!.length; i++)
                AnimatedContainer(
              duration: Duration(
                milliseconds: 300,
              ),
              curve: Curves.easeOutCubic,
              margin: EdgeInsets.symmetric(horizontal:widget.imageProduit ?0: 2),
              width:widget.imageProduit ? 40 : selectedImage == i ? 35 : 10,
              height:widget.imageProduit ? 3: 10,
              decoration: BoxDecoration(
                  color:widget.imageProduit ? selectedImage == i ?Colors.black: Colors.white:Colors.white,
                  borderRadius: BorderRadius.circular(widget.imageProduit ?0:12)),
            )
              ],
            ),
          ),
          if(!widget.imageProduit)
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    if (selectedImage > 0) {
                      selectedImage--;
                      pageController.animateToPage(selectedImage,
                          duration: Duration(milliseconds: 250),
                          curve: Curves.bounceInOut);
                    }
                  },
                  child: Container(
                    width: 30,
                    height: 100,
                    margin: EdgeInsets.only(left: 20),
                    color: Color(0xFF989898),
                    child: Image.asset("assets/icons/flech_left.png"),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (selectedImage < widget.imageList!.length - 1) {
                      selectedImage++;
                      pageController.animateToPage(selectedImage,
                          duration: Duration(milliseconds: 250),
                          curve: Curves.bounceInOut);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 20),
                    width: 30,
                    height: 100,
                    color: Color(0xFF989898),
                    child: Image.asset("assets/icons/flech_right.png"),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
