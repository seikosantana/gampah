class UserModel {
  String name;
  String phone;
  String email;
  String roles;
  String password;
  String? token;
  UserModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.roles,
    required this.password,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'],
        phone: json['phone'],
        email: json['email'],
        roles: json['roles'],
        password: json['password'],
        token: json['token'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'email': email,
        'roles': roles,
        'password': password,
        'token': token,
      };
}
