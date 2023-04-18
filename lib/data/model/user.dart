class User {
  late String idUser;
  late String username;
  late String password;
  late String name;
  late String email;
  late int loginStatus;

  User({
    required this.idUser,
    required this.username,
    required this.password,
    required this.name,
    required this.email,
    required this.loginStatus,
  });

  Map<String, dynamic> toMap() {
    return {
      'idUser': idUser,
      'username': username,
      'password': password,
      'name': name,
      'email': email,
      'loginStatus': loginStatus,
    };
  }

  User.fromMap(Map<String, dynamic> map) {
    idUser = map['idUser'];
    username = map['username'];
    password = map['password'];
    name = map['name'];
    email = map['email'];
    loginStatus = map['loginStatus'];
  }
}
