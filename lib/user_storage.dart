import 'dart:convert';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import 'package:excelerate_my_learning/mockdata.dart';

Future<String> get _userPath async {
  final directory = await getApplicationDocumentsDirectory();
  return '${directory.path}/user_profile.json';
}

Future<void> saveUserProfile(UserProfile profile) async {
  final file = File(await _userPath);
  await file.writeAsString(jsonEncode(profile.toJson()));
}

Future<UserProfile?> loadUserProfile() async {
  try {
    final file = File(await _userPath);
    final contents = await file.readAsString();
    return UserProfile.fromJson(jsonDecode(contents));
  } catch (e) {
    return null; // No saved profile yet
  }
}

Future<void> deleteUserProfile() async {
  final file = File(await _userPath);
  if (await file.exists()) {
    await file.delete();
  }
}