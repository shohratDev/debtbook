class AppUser {
  final String uid;
  final String email;

  AppUser({required this.email, required this.uid});

  // convert app user -> json
  Map<String, dynamic> toJson() {
    return <String, dynamic>{'uid': uid, 'email': email};
  }

  // convert json -> app user
  factory AppUser.fromMap(Map<String, dynamic> jSonUser) {
    return AppUser(uid: jSonUser['uid'], email: jSonUser['email']);
  }
}
