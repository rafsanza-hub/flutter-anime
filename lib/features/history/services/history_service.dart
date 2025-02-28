// features/history/services/history_service.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/history_model.dart';

class HistoryService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> addHistory(HistoryEntry entry) async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) throw Exception('User tidak login');

      final data = {
        ...entry.toJson(),
        'user_id': user.id,
      };

// jika sudah ada
      await _supabase.from('history').upsert(
            data,
            onConflict: 'user_id,anime_id',
          );
    } catch (e) {
      print('Error adding history: $e');
      throw Exception('Gagal menambahkan histori: $e');
    }
  }

  Future<List<HistoryEntry>> getHistory() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) throw Exception('User tidak login');

      final response = await _supabase
          .from('history')
          .select()
          .eq('user_id', user.id)
          .order('timestamp', ascending: false);

      return (response as List)
          .map((json) => HistoryEntry.fromJson(json))
          .toList();
    } catch (e) {
      print('Error fetching history: $e');
      throw Exception('Gagal mengambil histori: $e');
    }
  }
}
