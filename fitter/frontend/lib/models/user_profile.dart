import 'package:fitter/services/api_service.dart';

import 'package:flutter/material.dart';

class UserProfile {
  Image? image;
  String email;
  String nickname;
  bool gender;
  String ageGroup;
  String box;

  UserProfile({
    required this.image,
    required this.email,
    required this.nickname,
    required this.gender,
    required this.ageGroup,
    required this.box,
  });
}

class UserData with ChangeNotifier {
  UserProfile? _userProfile;

  UserProfile? get userProfile => _userProfile;

  void updateUserProfile(UserProfile userProfile) {
    _userProfile = userProfile;
    notifyListeners();
  }
}
