import 'package:dio/dio.dart';
import 'api_service.dart';

import '../services/urun_service.dart';
import '../services/kumas_service.dart';
import '../services/kimyasal_service.dart';
import '../../models/stok_item.dart';

class StokService {
  final Dio dio = ApiService().dio;

  Future<void> stokhareket({
    required String entityType,
    required int entityId,
    required String hareketTipi,
    required double miktar,
    required String aciklama,
  }) async {
    await dio.post(
      "/stokhareket/",
      data: {
        "entitytype": entityType,
        "entity_id": entityId,
        "harekettipi": hareketTipi,
        "miktar": miktar,
        "aciklama": aciklama,
      },
    );
  }

  // 🔥 BUNU CLASS İÇİNE AL
  Future<List<StokItem>> getAllStockItems() async {
    final urunler = await UrunService().getAll();
    final kumaslar = await KumasService().getAll();
    final kimyasallar = await KimyasalService().getAll();

    return [
      ...urunler.map((u) => StokItem(
            id: u.id,
            type: "urun",
            name: u.uruntipi,
            quantity: u.miktar,
          )),

      ...kumaslar.map((k) => StokItem(
            id: k.id,
            type: "kumas",
            name: k.kumasadi,
            quantity: k.stokmiktari,
          )),

      ...kimyasallar.map((k) => StokItem(
            id: k.id,
            type: "kimyasal",
            name: k.kimyasaladi,
            quantity: k.stokmiktari,
          )),
    ];
  }
}