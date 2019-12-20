class Contact {
  String id;
  String firstName;
  String lastName;
  DateTime birthDate;
  String email;
  String gender;
  String mobileNumber;
  String profilePhotoUrl;

  Contact({
    this.firstName,
    this.lastName,
    this.birthDate,
    this.email,
    this.gender,
    this.mobileNumber,
    this.profilePhotoUrl
  });

  Contact.fromMap(Map snapshot, String id) :
        id = id ?? '',
        firstName = snapshot['firstName'] ?? '',
        lastName = snapshot['lastName'] ?? '',
        birthDate = snapshot['birthDate'] ?? DateTime.now(),
        email = snapshot['email'] ?? '',
        gender = snapshot['gender'] ?? '',
        mobileNumber = snapshot['mobileNumber'] ?? '',
        profilePhotoUrl = snapshot['profilePhotoUrl'] ?? null;

  toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "birthDate": birthDate,
      "email": email,
      "gender": gender,
      "mobileNumber": mobileNumber,
      "profilePhotoUrl": profilePhotoUrl
    };
  }

}
