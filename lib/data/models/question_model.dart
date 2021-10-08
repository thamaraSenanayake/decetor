import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionModel {
  String? id;
  final String question;
  final int number;
  final Timestamp timestamp;

  QuestionModel({
    this.id,
    required this.question,
    required this.number,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'number': number,
      'timestamp': timestamp,
    };
  }

  static QuestionModel fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      id: map['id'],
      question: map['question'],
      number: map['number'],
      timestamp: map['timestamp'],
    );
  }
}
