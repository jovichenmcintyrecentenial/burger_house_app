class User {
  User({
    required this.firstName,
    required this.lastName,
    required this.type,
    required this.email,
    required this.password,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String firstName;
  String lastName;
  String type;
  String email;
  String password;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory User.fromJson(Map<String, dynamic> json) => User(
    firstName: json['first_name'],
    lastName: json['last_name'],
    type: json['type'],
    email: json['email'],
    password: json['password'],
    id: json['_id'],
    createdAt: DateTime.parse(json['createdAt']),
    updatedAt: DateTime.parse(json['updatedAt']),
    v: json['__v'],
  );

  Map<String, dynamic> toJson() => {
    'first_name': firstName,
    'last_name': lastName,
    'type': type,
    'email': email,
    'password': password,
    '_id': id,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    '__v': v,
  };
}