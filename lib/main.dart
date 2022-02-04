import 'package:clochard/Screen/Home_screen.dart';
import 'package:clochard/Screen/detail_screen.dart';
import 'package:clochard/Screen/mobile/detail_screen_mobile.dart';
import 'package:clochard/Screen/mobile/home_mobile.dart';
import 'package:clochard/Screen/mobile/panier_screen_mobile.dart';
import 'package:clochard/Screen/mobile/profil_mobile_screen.dart';
import 'package:clochard/Screen/panier_screen.dart';
import 'package:clochard/helper/binding.dart';
import 'package:clochard/responsive.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';

import 'Screen/profile_screen.dart';

void main() {
   WidgetsFlutterBinding.ensureInitialized();
 
   setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 
  @override
  Widget build(BuildContext context) {
   
    return GetMaterialApp(
      initialBinding:Binding() ,
    initialRoute:"/",
      //defaultTransition:Transition.zoom,
      getPages: [
        GetPage(name: "/", page: ()=>MyApp()),
        GetPage(name: "/Home", page: ()=> Responsive(mobile: HomeMobile(), desktop: HomeScreen(),tablet: HomeScreen(),)),
         GetPage(name: "/DetailProduit", page: ()=>Responsive(mobile: DetailScreenMobile(), desktop: DetailScreen(),tablet: DetailScreen(),)),
         GetPage(name: "/Panier", page: ()=>Responsive(mobile: PanierScreenMobile(), desktop: PanierScreen(),tablet: PanierScreen(),)),
          GetPage(name: "/MonCompte", page: ()=>Responsive(mobile: ProfilScreenMobile(), desktop: ProfileScreen(),tablet: ProfileScreen(),)),
   
         
      ],

      debugShowCheckedModeBanner: false,
      title: 'Clochard',
      theme: ThemeData(
    
        primarySwatch: Colors.blue,
      ),
      home: InitializeFireBase()
    );
  }
}
class InitializeFireBase extends StatefulWidget {
  const InitializeFireBase({ Key? key }) : super(key: key);

  @override
  _InitializeFireBaseState createState() => _InitializeFireBaseState();
}

class _InitializeFireBaseState extends State<InitializeFireBase> {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
    
          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return Responsive(mobile: HomeMobile(), desktop: HomeScreen(),tablet: HomeScreen(),);
          }
    
          // Otherwise, show something whilst waiting for initialization to complete
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}