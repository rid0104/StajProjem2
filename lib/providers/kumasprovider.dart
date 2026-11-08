import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/kumas.dart';
import '../core/services/kumas_service.dart';

final kumasServiceProvider =
    Provider<KumasService>((ref) {
  return KumasService();
});

class KumasNotifier
    extends Notifier<List<Kumas>> {

  List<Kumas> _allKumaslar = [];

  @override
  List<Kumas> build() {
    return [];
  }

  Future<void> fetchKumaslar() async {
    final kumasService =
        ref.read(kumasServiceProvider);

    final kumaslar =
        await kumasService.getAll();

    _allKumaslar = kumaslar;
    state = kumaslar;
  }

  Future<void> deleteKumas(int id) async {
    final kumasService =
        ref.read(kumasServiceProvider);

    await kumasService.delete(id);

    await fetchKumaslar();
  }

  void search(String text) {
    if (text.isEmpty) {
      state = _allKumaslar;
      return;
    }

    state = _allKumaslar.where((e) {
      return e.kumasadi
          .toLowerCase()
          .contains(text.toLowerCase());
    }).toList();
  }
}

final kumasProvider =
    NotifierProvider<KumasNotifier, List<Kumas>>(
  KumasNotifier.new,
);