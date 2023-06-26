class UserModel {
  String? uid;
  String? email;
  String? joindate;

  UserModel({this.uid, this.email, this.joindate});

  //retrieve data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'], email: map['email'], joindate: map['Joined at']);
  }
//send data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'Joined at': joindate,
    };
  }
}
