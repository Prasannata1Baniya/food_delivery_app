class UserProfile{
  final String name;
  final String email;
  final String profileImage;
  UserProfile({
   required this.name,
   required this.email,
    required this.profileImage
});

  //from json
  factory UserProfile.fromJson(Map<String,dynamic> json){
    return UserProfile(
        name:json['name'] ,
        email: json['email'],
        profileImage: json['profileImage']);
  }

  Map<String,dynamic> toJson(){
    return{
      'name':name,
      'email':email,
      'profileImage':profileImage,
  };

}

}