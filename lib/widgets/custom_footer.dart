import 'package:clochard/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class CustemFooter extends StatefulWidget {
  const CustemFooter({
    Key? key,
  }) : super(key: key);

  @override
  _CustemFooterState createState() => _CustemFooterState();
}

class _CustemFooterState extends State<CustemFooter> {
  Future<void> _launchInWebViewWithJavaScript(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 250,
      color: Color(0xFFF5F5F5),
      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width*.1,vertical: 20 ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset("assets/images/logo_noir.png",height: 150,),
            Column(
              children: [
                CustomText(text: "CONTACT",fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold,),
                SizedBox(height: 20,),
                CustomText(text: "Clochard@gmail.com",fontSize: 14,color: Colors.black,),
                SizedBox(height: 10,),
                CustomText(text: "tel:23 89 79 33",fontSize: 14,color: Colors.black,),
              ],
            ),
             Column(
              children: [
                CustomText(text: "SIUVEZ NOUS",fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold,),
                SizedBox(height: 20,),
                Row(
                  children: [
                    InkWell(
                      onTap:(){
                        _launchInWebViewWithJavaScript("https://www.instagram.com/clochard470/");
                      },
                      child: Image.asset("assets/images/instagram_logo.png")),
                    SizedBox(width: 20,),
                     InkWell(
                       onTap:() {
                         _launchInWebViewWithJavaScript("https://www.facebook.com/clochard470");
                       },
                       child: Image.asset("assets/images/facebook-logo.png")),
                    
                  ],
                )
              ],
            ),
            Container(
              width: 150,
              height: 60,
              //alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black,
                
              ),
              child: Center(child: CustomText(text: "Telecharger \nl'application",color: Colors.white,alignment: Alignment.center,)),
            ),
          ],
        ),
    );
  }
}
