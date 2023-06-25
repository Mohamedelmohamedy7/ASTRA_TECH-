class Users {
  int ? id;
  String ? fName;
  String ? lastName;
  String ? email;
  String ? phone;

  Users({
    this.id,
    this.fName,
    this.lastName,
    this.email,
    this.phone,
  });

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = fName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['term'] = 1;
    data["password"] = "XXXVIII";
    return data;
  }
}