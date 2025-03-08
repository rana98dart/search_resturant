import 'package:flutter/foundation.dart';

class ProfileModel {
  final String username;
  final String email;
  final String fullName;
  final String bio;
  final String profileImage;
  const ProfileModel(
      {required this.username,
      required this.email,
      required this.fullName,
      required this.bio,
      required this.profileImage});

  factory ProfileModel.fromjson(Map<String, dynamic> json) {
    return ProfileModel(
        username: json['username'],
        email: json['email'],
        fullName: json['fullName'],
        bio: json['bio'],
        profileImage: json['profileImage']);
  }
}
