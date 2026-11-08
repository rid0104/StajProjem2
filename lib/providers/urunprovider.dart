

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/urun.dart';
import '../core/services/urun_service.dart';

final urunServiceProvider = Provider<UrunService>((ref) {
  return UrunService();
});

class UrunNotifier extends Notifier<List<Urun>> {
  List<Urun> _allUrunler = [];

  @override
  List<Urun> build() {
    return [];
  }

  Future<void> fetchUrunler() async {
    final urunService = ref.read(urunServiceProvider);

    final urunler = await urunService.getAll();

    _allUrunler = urunler;
    state = urunler;
  }

  Future<void> deleteUrun(int id) async {
    final urunService = ref.read(urunServiceProvider);

    await urunService.delete(id);

    await fetchUrunler();
  }

  void search(String text) {
    if (text.isEmpty) {
      state = _allUrunler;
      return;
    }

    state = _allUrunler.where((e) {
      return e.uruntipi
          .toLowerCase()
          .contains(text.toLowerCase());
    }).toList();
  }
}

final urunProvider =
    NotifierProvider<UrunNotifier, List<Urun>>(
  UrunNotifier.new,
);


