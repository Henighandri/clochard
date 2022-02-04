
class UserModel {
  String? email ;
      String? password ;
      String? nom ;
      String? adresse;
      String?  codePostal;
      String? prenom;
      String? region;
      String? tel;

   UserModel({
       this.email,
       this.nom,
       this.prenom,
       this.tel,
       this.region,
       this.password,
       this.adresse,
       this.codePostal
   });

factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map["email"],
      
      nom: map["nom"],
      adresse: map["adresse"],
      codePostal: map["codePostal"],
      prenom: map["prenom"],
      region: map["region"],
       tel: map["tel"],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      
      'nom': nom,
      'adresse': adresse,
      'codePostal': codePostal,
       'prenom': prenom,
        'region': region,
         'tel': tel,
    };
  }
}