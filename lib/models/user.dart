class User {
  String fullName;
  String email;
  String password;
  List<String> roles;

  User(
      {required this.email,
      required this.password,
      this.fullName = '',
      this.roles = const []});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullName'] = fullName;
    data['email'] = email;
    data['password'] = password;
    data['roles'] = roles;
    return data;
  }
}
