import '../models/history_model.dart';
import '../services/history_service.dart';

class HistoryRepository {
  final HistoryService historyService;

  HistoryRepository({required this.historyService});

  Future<void> addHistory(HistoryEntry entry) async {
    try {
      await historyService.addHistory(entry);
    } catch (e) {
      throw Exception('Error menambahkan histori: $e');
    }
  }

  Future<List<HistoryEntry>> getHistory() async {
    try {
      return await historyService.getHistory();
    } catch (e) {
      throw Exception('Error mengambil histori: $e');
    }
  }
}