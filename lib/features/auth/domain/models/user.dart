class User {
  final int id;
  final String? name;
  final String? paternal;
  final String? maternal;
  final String email;
  final String? path;
  final String? phone;
  final int? userType;
  final int? idZone;
  final String? token;

  User( 
      {required this.id,
      this.name,
      this.paternal,
      this.maternal,
      required this.email,
      this.path,
      this.phone,
      this.userType,
      this.idZone,
      this.token,});

  bool isAdmin() {
    if (userType == 1) return true;

    return false;
  }

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        paternal: json["paternal_name"],
        maternal: json["maternal_name"],
        email: json['email'],
        path: json['profile_photo_url'],
        phone: json['cell_phone'],
        userType: json['is_user_type'],
        idZone:json['id_zone'],
        token:json['token'],
      );

    
}
