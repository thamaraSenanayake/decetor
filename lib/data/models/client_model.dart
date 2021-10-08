import 'package:cloud_firestore/cloud_firestore.dart';

class ClientModel {
  String? id;
  final String fullName;
  final String email;
  final String phone;
  final String password;
  final Timestamp timestamp;

  ClientModel({
    this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'password': password,
      'timestamp': timestamp,
    };
  }

  static ClientModel fromMap(Map<String, dynamic> map) {
    return ClientModel(
      id: map['id'],
      fullName: map['fullName'],
      email: map['email'],
      phone: map['phone'],
      password: map['password'],
      timestamp: map['timestamp'],
    );
  }
}
