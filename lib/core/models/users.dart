class UserModel {
  final String uid;
  final String? email;

  UserModel(this.uid, this.email);
}

class UserProfile {
  final String? fullName;
  final String? dateOfBirth;
  final String? gender;
  final int? height;

  UserProfile({this.fullName, this.dateOfBirth, this.gender, this.height});
}
