class StokHareket {
  final int? id;
  final String entityType;
  final int entityId;
  final String aciklama;
  final String hareketTipi;
  final double miktar;
  final double oncekiStok;
  final double sonrakiStok;

  StokHareket({
    this.id,
    required this.entityType,
    required this.entityId,
    required this.aciklama,
    required this.hareketTipi,
    required this.miktar,
    required this.oncekiStok,
    required this.sonrakiStok,
  });

  factory StokHareket.fromJson(Map<String, dynamic> json) {
    return StokHareket(
      id: json["id"],
      entityType: json["entitytype"] ?? "",
      entityId: json["entity_id"] ?? 0,
      aciklama: json["aciklama"] ?? "",
      hareketTipi: json["harekettipi"] ?? "",
      miktar: (json["miktar"] ?? 0).toDouble(),
      oncekiStok: (json["oncekistok"] ?? 0).toDouble(),
      sonrakiStok: (json["sonrakistok"] ?? 0).toDouble(),
    );
  }
}