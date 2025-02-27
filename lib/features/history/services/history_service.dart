import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/history_model.dart';

class HistoryService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> addHistory(HistoryEntry entry) async {
    try {
      await _supabase.from('history').insert(entry.toJson());
    } catch (e) {
      throw Exception('Gagal menambahkan histori: $e');
    }
  }

  Future<List<HistoryEntry>> getHistory() async {
    try {
      final response = await _supabase
          .from('history')
          .select()
          .order('timestamp', ascending: false);
      return (response as List).map((json) => HistoryEntry.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Gagal mengambil histori: $e');
    }
  }
}