import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    int? id,
    required String username,
    required String email,
    required String address,
    required String number,
    required String password,
    required String token,
  }) : super(
    id: id,
    username: username,
    email: email,
    address: address,
    number: number,
    password: password,
    token: token,
  );

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
    id: map['id'],
    username: map['username'],
    email: map['email'],
    address: map['address'],
    number: map['number'],
    password: map['password'],
    token: map['token'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'username': username,
    'email': email,
    'address': address,
    'number': number,
    'password': password,
    'token': token,
  };
}
