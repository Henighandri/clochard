import 'package:clochard/model/produit.dart';
import 'package:clochard/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileService{
  
  final CollectionReference _usersCollectionRef=
     FirebaseFirestore.instance.collection("Users");
  final CollectionReference _commandeRef=
     FirebaseFirestore.instance.collection("Commandes");
      final CollectionReference _categoryRef=
     FirebaseFirestore.instance.collection("Categories");
     
     Future<DocumentSnapshot<Object?>>  getUser(String id)async{
    
     var valueResult=  await _usersCollectionRef.doc(id).get();
   
       return valueResult;
     }

    Future<void> changeUserInfo(UserModel user,String uid) async {
      //print(user.nom.toString()+'|'+user.email.toString()+'|'+user.password.toString()+'|'+user.prenom.toString()+'|'+user.tel.toString()+'|'+user.codePostal.toString()+'|'+user.region.toString()+'|'+user.adresse.toString()+'|');
     await _usersCollectionRef.doc(uid).set(
        user.toMap()
      );
    }

     Future<List<QueryDocumentSnapshot>>  getCommande(String id)async{
    
     var valueResult=  await _commandeRef.doc(id).collection("cart").orderBy('date', descending: true).get();
        
       return valueResult.docs;
     }
     Future<List<QueryDocumentSnapshot>>  getCommandeDetail(String iduser,String idCommand)async{
    
     var valueResult=  await _commandeRef.doc(iduser).collection("cart").doc(idCommand).collection("commande").get();
   
       return valueResult.docs;
     }

   Future<Produit>  getPrduit(String idProduit,String idCategory) async {
      DocumentSnapshot<Map<String, dynamic>>? produit;
      Produit? _produit;
      produit=await  _categoryRef.doc(idCategory).collection("Produits").doc(idProduit).get();
            
             
                            _produit=  Produit(
                            images:produit.data()!["image"],
                            name: produit.data()!['name'],
                            price: double.parse(produit.data()!["prix"].toString()),
                            sizes: produit.data()!["taille"],
                            colors: produit.data()!["colors"],
                            solde: double.parse(produit.data()!["solde"].toString()),
                            idProduit:produit.id);
                    
               
             
 return _produit;
}

}