import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:detector/common/constants/firebase_constants.dart';
import 'package:detector/data/models/client_model.dart';
import 'package:detector/data/models/question_model.dart';

class FirebaseDatabase {
  static final FirebaseDatabase _singleton = FirebaseDatabase._internal();

  factory FirebaseDatabase() {
    return _singleton;
  }

  FirebaseDatabase._internal();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //create client account
  Future<bool> createClient(ClientModel client) async {
    try {
      await _db
          .collection(FirebaseConstants.CLIENTS)
          .doc(client.id)
          .set(client.toMap());

      return true;
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  //get all questions
  Future<List<QuestionModel>> getQuestions() async {
    print("Getting questions...");
    var _data = await _db
        .collection(FirebaseConstants.QUESTIONS)
        .orderBy("number")
        .get();
    return _data.docs.map((e) => QuestionModel.fromMap(e.data())).toList();
  }
}
