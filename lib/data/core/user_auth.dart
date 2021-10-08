import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:detector/common/constants/firebase_constants.dart';
import 'package:detector/data/core/firebase_database.dart';
import 'package:detector/data/models/client_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAuth {
  static final UserAuth _singleton = UserAuth._internal();

  factory UserAuth() {
    return _singleton;
  }

  UserAuth._internal();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> createClient(ClientModel client) async {
    try {
      final UserCredential user = await auth.createUserWithEmailAndPassword(
        email: client.email,
        password: client.password,
      );

      client.id = user.user!.uid;
      var result = await FirebaseDatabase().createClient(client);

      if (result) {
        return "Success||${user.user!.uid}";
      } else {
        return "Failed to create account";
      }
    } on FirebaseAuthException catch (authEx) {
      print(authEx.code);
      switch (authEx.code) {
        case "email-already-in-use":
          return "Email already registered. Please use SignIn";
        case "invalid-email":
          return "Email address not valid";
        case "operation-not-allowed":
          return "Server error, please try again later";
        case "weak-password":
          return "Poor password, Please enter strong one";
        case "too-many-requests":
          return "Too many requests. Please try again later";
        default:
          return "Please check your connection and try again later";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "Success";
    } on FirebaseAuthException catch (authEx) {
      print(authEx.code);
      switch (authEx.code) {
        case "user-disabled":
          return "Account disabled. Please contact customer service";
        case "invalid-email":
          return "Email address not valid";
        case "operation-not-allowed":
          return "Server error, please try again later";
        case "user-not-found":
          return "No user found with this email";
        case "wrong-password":
          return "Wrong email/password combination";
        case "too-many-requests":
          return "Too many requests. Please try again later";
        default:
          return "Please check your connection and try again later";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<ClientModel?> getUser() async {
    if (auth.currentUser?.uid != null) {
      var userData = await db
          .collection(FirebaseConstants.CLIENTS)
          .doc(auth.currentUser?.uid)
          .get();
      ClientModel currentUser = ClientModel.fromMap(userData.data()!);
      return currentUser;
    }
    return null;
  }

  Future<String> requestResetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return "Email sent";
    } catch (e) {
      if (e.toString().contains("user-not-found")) {
        return "No user found with the email";
      } else if (e.toString().contains("An internal error has occurred")) {
        return "An internal error has occurred";
      } else {
        return "Something went wrong, try again later";
      }
    }
  }

  Future<bool> updatePassword(String password) async {
    try {
      if (auth.currentUser?.uid != null) {
        await auth.currentUser!.updatePassword(password);
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<bool> updateEmail(String email) async {
    try {
      if (auth.currentUser?.uid != null) {
        await auth.currentUser!.updateEmail(email);
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  User? getProfile() {
    return auth.currentUser;
  }

  Future<String?> getUserId() async {
    final currentUser = auth.currentUser;
    if (currentUser != null) {
      return currentUser.uid;
    }
    return null;
  }

  Future<bool> isSignedIn() async {
    final currentUser = auth.currentUser;
    return currentUser != null;
  }

  Future<List<void>> signOut() async {
    return Future.wait([auth.signOut()]);
  }
}
