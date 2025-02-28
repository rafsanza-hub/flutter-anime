import 'package:flutter/foundation.dart'; // Untuk debugPrint
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/auth_model.dart'; // Pastikan ini sesuai dengan nama file model Anda

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Gantilah dengan Client ID dari Google Cloud
  static final String _webClientId = dotenv.env['GOOGLE_WEB_CLIENT_ID']!;
  static final String _iosClientId = dotenv.env['GOOGLE_IOS_CLIENT_ID']!;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId: _webClientId,
    clientId: _iosClientId,
    scopes: ['email', 'profile'],
  );

  Future<AppUser> signInWithGoogle() async {
    try {
      debugPrint('Memulai Google Sign-In...');
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        debugPrint('Google Sign-In dibatalkan oleh pengguna');
        throw Exception('Google Sign-In dibatalkan');
      }

      debugPrint('Google Sign-In berhasil: ${googleUser.email}');

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final String? accessToken = googleAuth.accessToken;
      final String? idToken = googleAuth.idToken;

      if (accessToken == null || idToken == null) {
        debugPrint('Token Google null');
        throw Exception('Gagal mendapatkan token dari Google');
      }

      debugPrint('Mengautentikasi ke Supabase dengan token Google...');
      final AuthResponse response = await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      final User? user = response.user;
      if (user == null) {
        debugPrint('User Supabase null setelah autentikasi');
        throw Exception('Login gagal: User tidak ditemukan');
      }

      debugPrint('Login Supabase berhasil: ${user.email}');
      return AppUser.fromJson(user.toJson());
    } catch (e) {
      debugPrint('Error selama Google Sign-In: $e');
      throw Exception('Login Google gagal: $e');
    }
  }

  Future<void> signOut() async {
    try {
      debugPrint('Memulai proses logout...');
      await _googleSignIn.signOut();
      debugPrint('Logout dari Google berhasil');

      await _supabase.auth.signOut();
      debugPrint('Logout dari Supabase berhasil');
    } catch (e) {
      debugPrint('Error selama logout: $e');
      throw Exception('Logout gagal: $e');
    }
  }

  AppUser? getCurrentUser() {
    final User? user = _supabase.auth.currentUser;
    if (user != null) {
      debugPrint('Pengguna saat ini: ${user.email}');
      return AppUser.fromJson(user.toJson());
    }
    debugPrint('Tidak ada pengguna yang login');
    return null;
  }
}
