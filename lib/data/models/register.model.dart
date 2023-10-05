// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Register {
  String email;
  String password;

  Register(
    this.email,
    this.password,
  );

  Register copyWith({
    String? email,
    String? password,
  }) {
    return Register(
      email ?? this.email,
      password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory Register.fromMap(Map<String, dynamic> map) {
    return Register(
      map['email'] as String,
      map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Register.fromJson(String source) =>
      Register.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Register(email: $email, password: $password)';

  @override
  bool operator ==(covariant Register other) {
    if (identical(this, other)) return true;

    return other.email == email && other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
