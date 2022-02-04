import 'package:clochard/model/user.dart';
import 'package:clochard/view_Controller/auth_controller/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService{

//final AuthController _authController = Get.put(AuthController());
 final CollectionReference _usersCollectionRef=
     FirebaseFirestore.instance.collection("Users");



    resetPassword(String email) async {
    FirebaseAuth.instance.sendPasswordResetEmail(email:email );
  }

   Future<String?> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
         
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        
        return ('Cette utilisateur n\'existe pas.');
      } else if (e.code == 'wrong-password') {
        return ('Mot de passe incorrect fourni\n pour cet utilisateur.');
      }
      return "Error";
    } catch (e) {
      return ("Error");
    }
  }

  Future<void> creatUser(UserModel user) async {
    try {
  UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email:user.email.toString(),
    password: user.password.toString()
  );
  //if(userCredential.user!=null)
    await addUserInformation(user,userCredential.user!.uid.toString());
  
  } on FirebaseAuthException catch (e) {
    
  } catch (e) {
    print(e);
  }
    }
  
    Future<void> addUserInformation(UserModel user,String uid) async {
      //print(user.nom.toString()+'|'+user.email.toString()+'|'+user.password.toString()+'|'+user.prenom.toString()+'|'+user.tel.toString()+'|'+user.codePostal.toString()+'|'+user.region.toString()+'|'+user.adresse.toString()+'|');
     await _usersCollectionRef.doc(uid).set(
        user.toMap()
      );
    }
}