// features/auth/repositories/auth_repository.dart
import '../models/auth_model.dart';
import '../services/auth_service.dart';

class AuthRepository {
  final AuthService authService;

  AuthRepository({required this.authService});

  Future<AppUser> signInWithGoogle() async {
    return await authService.signInWithGoogle();
  }

  Future<void> signOut() async {
    await authService.signOut();
  }

  AppUser? getCurrentUser() {
    return authService.getCurrentUser();
  }
}