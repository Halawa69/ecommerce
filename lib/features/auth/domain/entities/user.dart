class User {
  final int? id;
  final String username;
  final String email;
  final String address;
  final String number;
  final String password;
  final String token;

  User({
    this.id,
    required this.username,
    required this.email,
    required this.address,
    required this.number,
    required this.password,
    required this.token,
  });
}
