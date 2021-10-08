import 'package:detector/data/models/client_model.dart';
import 'package:detector/data/models/question_model.dart';
import 'package:flutter/foundation.dart';

class DataProvider extends ChangeNotifier {
  late ClientModel _client;
  List<QuestionModel> _questions = [];

  void setClient(ClientModel client) {
    _client = client;
  }

  void setQuestions(List<QuestionModel> questions) {
    _questions = questions;
  }

  ClientModel get currentClient => _client;
  List<QuestionModel> get questions => _questions;
}
