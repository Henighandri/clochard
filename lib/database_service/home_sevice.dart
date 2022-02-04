
import 'package:cloud_firestore/cloud_firestore.dart';


class HomeService{


  final CollectionReference _categoryCollectionRef=
     FirebaseFirestore.instance.collection("Categories");

     
     Future<List<QueryDocumentSnapshot>>  getCategory()async{
    
     var valueResult=  await _categoryCollectionRef.get();
   
       return valueResult.docs;
     }

     Future<List<QueryDocumentSnapshot>>  getProductFromCategory(String idCategory,String? search)async{
           
     var valueResult;
     if(search==null){
       valueResult=  await _categoryCollectionRef.doc(idCategory).collection('Produits').get();
     }else{
       valueResult=  await _categoryCollectionRef.doc(idCategory).collection('Produits')
       .orderBy("name")
       .startAt([search])
         .endAt(["$search\uf8ff"])
       .get();
     }
       
       return valueResult.docs;
     }

final DateTime now = DateTime.now();
Future<List<QueryDocumentSnapshot>>  getNewCollection(String idCategory)async{
    
    var valueResult=  await _categoryCollectionRef.doc(idCategory).collection('Produits')
    .where("collection",isEqualTo: now.year)
    .get();
   
       return valueResult.docs;
     }
}