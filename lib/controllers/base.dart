import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:bot_toast/bot_toast.dart';

enum AppState { Busy, Idel }

class BaseController extends ChangeNotifier {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseFirestore get firebaseFirestore => _firebaseFirestore;

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseAuth get firebaseAuth => _firebaseAuth;

  AppState _appstate = AppState.Idel;
  AppState get appstate => _appstate;

  void setAppState(AppState value) {
    _appstate = value;
    notifyListeners();
  }

  void showLoading() => BotToast.showLoading();

  void closeLoadings() => BotToast.closeAllLoading();

  void showToast(String message) {
    BotToast.showText(text: message);
  }
}
