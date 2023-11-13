class UserData {
  String firstname;
  String lastname;
  String email;
  int age;
  bool isFramer;
  String photourl;

  UserData({
    required this.firstname,
    required this.lastname,
    required this.age,
    required this.email,
    required this.isFramer,
    required this.photourl,
  });

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      firstname: map['first_name'] ?? '',
      lastname: map['last_name'] ?? '',
      email: map['email'] ?? '',
      age: map['age'] ?? 0,
      photourl: map['photo_url'] ?? '',
      isFramer: map['isFramer'] == null ? false : map['isFramer'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstname;
    data['last_name'] = lastname;
    data['email'] = email;
    data['age'] = age;
    data['photo_url'] = photourl;
    data['isFramer'] = isFramer;
    return data;
  }
}
