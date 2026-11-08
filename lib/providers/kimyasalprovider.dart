import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/kimyasal.dart';
import '../core/services/kimyasal_service.dart';
final kimyasalServiceProvider =
    Provider<KimyasalService>((ref) {
  return KimyasalService();
});
class KimyasalNotifier
    extends Notifier<List<Kimyasal>> {
  List<Kimyasal> _allKimyasallar = [];
  @override
  List<Kimyasal> build() {
    return [];
  }
  Future<void> fetchKimyasallar() async {
    final service =
        ref.read(kimyasalServiceProvider);
    final kimyasallar =
        await service.getAll();
    _allKimyasallar = kimyasallar;
    state = kimyasallar;
  }
  Future<void> deleteKimyasal(int id) async {
    final service =
        ref.read(kimyasalServiceProvider);
    await service.delete(id);
    await fetchKimyasallar();
  }
  void search(String text) {
    if (text.isEmpty) {
      state = _allKimyasallar;
      return;
    }
    state = _allKimyasallar.where((e) {
      return e.kimyasaladi
          .toLowerCase()
          .contains(text.toLowerCase());
    }).toList();
  }
}
final kimyasalProvider =
    NotifierProvider<
      KimyasalNotifier,
      List<Kimyasal>
    >(KimyasalNotifier.new);
