import 'dart:convert';

class UserModel {
  final String id;
  final String photo;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String address;
  final String type;
  final String tokenFCM;
  final String token;

  UserModel({
    required this.id,
    required this.photo,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.address,
    required this.type,
    required this.tokenFCM,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'photo': photo,
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'address': address,
      'type': type,
      'tokenFCM': tokenFCM,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] ?? '',
      photo: map['photo'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? '',
      tokenFCM: map['tokenFCM'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  UserModel copyWith({
    String? id,
    String? photo,
    String? name,
    String? email,
    String? phone,
    String? password,
    String? address,
    String? type,
    String? tokenFCM,
    String? token,
  }) {
    return UserModel(
      id: id ?? this.id,
      photo: photo ?? this.photo,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      address: address ?? this.address,
      type: type ?? this.type,
      tokenFCM: tokenFCM ?? this.tokenFCM,
      token: token ?? this.token,
    );
  }
}
