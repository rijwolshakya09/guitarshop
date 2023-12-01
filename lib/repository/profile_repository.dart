import 'dart:io';

import 'package:guitarshop/api/profile_api.dart';
import 'package:guitarshop/model/show_profile.dart';
import 'package:guitarshop/response/profile_response.dart';

class ProfileRepository {
  Future<ProfileResponse?> getProfile() async {
    return ProfileAPI().getProfile();
  }

  Future<bool> updatePatientProfile(
      ShowProfile patientProfile, File? image) async {
    return await ProfileAPI().updatePatientProfile(patientProfile, image);
  }
}
