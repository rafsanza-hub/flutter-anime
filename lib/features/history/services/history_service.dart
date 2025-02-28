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
      await _supabase.from('history').insert(data);
    } catch (e) {
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
      return (response as List).map((json) => HistoryEntry.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Gagal mengambil histori: $e');
    }
  }
}