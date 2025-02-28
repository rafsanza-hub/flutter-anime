// features/profile/repositories/profile_repository.dart
import 'package:flutter_anime/features/auth/models/auth_model.dart';
import 'package:flutter_anime/features/auth/services/auth_service.dart';

class ProfileRepository {
  final AuthService authService;

  ProfileRepository({required this.authService});

  AppUser? getProfile() {
    return authService.getCurrentUser();
  }

  // Future<void> signOut() async {
  //   await authService.signOut();
  // }
}