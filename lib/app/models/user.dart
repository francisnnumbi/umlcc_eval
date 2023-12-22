class User {
  int? id;
  final String firstName;
  final String lastName;
  final String identity;
  final String phone;
  final String dialCode;
  final String type;

  User({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.identity,
    required this.phone,
    required this.dialCode,
    required this.type,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      identity: json['identity'],
      phone: json['phone'],
      dialCode: json['dial_code'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'identity': identity,
      'phone': phone,
      'dial_code': dialCode,
      'type': type,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, firstName: $firstName, lastName: $lastName, identity: $identity, phone: $phone, dialCode: $dialCode, type: $type}';
  }
}
