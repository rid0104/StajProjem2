

class User {
  final int id;
  final String kullaniciadi;
  final String email;
  


  User ({
    required this.id ,
    required this.kullaniciadi ,
    required this.email ,
 


  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User (
      id: json["id"],
      kullaniciadi: json["kullaniciadi"],
      email: json["email"],
    

  );
  }
  Map <String, dynamic> toJson() {
    return {
      "id": id,
      "kullaniciadi": kullaniciadi,
      "email": email,

    };
  }
}
