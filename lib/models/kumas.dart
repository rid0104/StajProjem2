class Kumas {
  final int id;
  final String kumasadi;
  final String kumastipi;
  final int kumaskodu;
  final int partino;
  final String birim;
  final double stokmiktari;
  final String renk;
  final int topsayisi;
  final String durum;
  final String depolokasyonu;
  final bool isDeleted;
  final DateTime giristarihi;
  final DateTime guncellemetarihi;

  Kumas({
    required this.id,
    required this.kumasadi,
    required this.kumastipi,
    required this.kumaskodu,
    required this.partino,
    required this.birim,
    required this.stokmiktari,
    required this.renk,
    required this.topsayisi,
    required this.durum,
    required this.depolokasyonu,
    required this.isDeleted,
    required this.giristarihi,
    required this.guncellemetarihi,
  });

  factory Kumas.fromJson(Map<String, dynamic> json) {
    return Kumas(
      id: json["id"] ?? 0,
      kumasadi: json["kumasadi"] ?? "",
      kumastipi: json["kumastipi"] ?? "",
      kumaskodu: json["kumaskodu"] ?? 0,
 
      partino: json["partino"] ?? 0,
      birim: json["birim"] ?? "",
      stokmiktari: (json["stokmiktari"] ?? 0).toDouble(),
      renk: json["renk"] ?? "",
      topsayisi: json["topsayisi"] ?? 0,
      durum: json["durum"] ?? "",
      depolokasyonu: json["depolokasyonu"] ?? "",
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
      "kumasadi": kumasadi,
      "kumastipi": kumastipi,
      "kumaskodu": kumaskodu,
      "partino": partino,
      "birim": birim,
      "stokmiktari": stokmiktari,
      "renk": renk,
      "topsayisi": topsayisi,
      "durum": durum,
      "depolokasyonu": depolokasyonu,
      "is_deleted": isDeleted,
      "giristarihi": giristarihi.toIso8601String(),
      "guncellemetarihi": guncellemetarihi.toIso8601String(),
    };
  }
}