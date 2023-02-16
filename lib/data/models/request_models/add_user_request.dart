class AddUserRequest {
  AddUserRequest({
    required this.firstName,
    required this.lastName,
    required this.emailAddress,
    required this.password,
  });

  String firstName;
  String lastName;
  String emailAddress;
  String password;

  factory AddUserRequest.fromJson(Map<String, dynamic> json) => AddUserRequest(
    firstName: json['first_name'],
    lastName: json['last_name'],
    emailAddress: json['email_address'],
    password: json['password'],
  );

  Map<String, dynamic> toJson() => {
    'first_name': firstName,
    'last_name': lastName,
    'email_address': emailAddress,
    'password': password,
  };
}
