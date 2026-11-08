
class Urun {
  final int id;
  final String uruntipi;
  final String aciklama;
  final int partino;

  final String birim;
  final double miktar;
  final int minimumstok;
  final bool isDeleted;
  final DateTime giristarihi;
  final DateTime guncellemetarihi;

  Urun({
    required this.id,
    required this.uruntipi,
    required this.aciklama,
    required this.partino,
    required this.birim,

    required this.miktar,
    required this.minimumstok,
    required this.isDeleted,
    required this.giristarihi,
    required this.guncellemetarihi,
  });

  factory Urun.fromJson(Map<String, dynamic> json) {
    return Urun(
      id: json["id"] ?? 0,
      uruntipi: json["uruntipi"] ?? "",
      aciklama: json["aciklama"] ?? "",
      partino: json["partino"] ?? 0,

      birim: json["birim"] ?? "",
      miktar: (json["miktar"] ?? 0).toDouble(),
      minimumstok: json["minimumstok"] ?? 0,
      isDeleted: json["is_deleted"] ?? false,

      giristarihi: json["giristarihi"] != null
          ? DateTime.parse(json["giristarihi"])
          : DateTime.now(),

      guncellemetarihi: json["guncellemetarihi"] != null
          ? DateTime.parse(json["guncellemetarihi"])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "uruntipi": uruntipi,
      "aciklama": aciklama,
      "partino": partino,
      "birim": birim,
      "miktar": miktar,
      "minimumstok": minimumstok,
      "is_deleted": isDeleted,
      "giristarihi": giristarihi.toIso8601String(),
      "guncellemetarihi": guncellemetarihi.toIso8601String(),
    };
  }
}