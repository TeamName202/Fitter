import 'dart:io';

import 'package:flutter/material.dart';

class UserProfile {
  Image? image;
  final String email;
  final String nickname;
  final bool gender;
  final String ageGroup;
  final String box;

  UserProfile({
    required this.image,
    required this.email,
    required this.nickname,
    required this.gender,
    required this.ageGroup,
    required this.box,
  });
}

class UserData extends ChangeNotifier {
  UserProfile? _userProfile;

  UserProfile? get userProfile => _userProfile;

  void updateUserProfile(UserProfile userProfile) {
    _userProfile = userProfile;
    notifyListeners();
  }
}
