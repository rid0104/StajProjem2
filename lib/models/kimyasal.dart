class Kimyasal {
  final int id;
  final String kimyasaladi;
  final String kategori;
  final int kimyasalkodu;
  final DateTime sonkullanmatarihi;
  final String birim;
  final double stokmiktari;
  final int minimumstok;
  final String tedarikci;
  final String tehlikesinifi;
  final bool isDeleted;
  final DateTime giristarihi;
  final DateTime guncellemetarihi;
  final String depolokasyonu;

  Kimyasal({
    required this.id,
    required this.kimyasaladi,
    required this.kategori,
    required this.kimyasalkodu,
    required this.sonkullanmatarihi,
    required this.birim,
    required this.stokmiktari,
    required this.minimumstok,
    required this.tedarikci,
    required this.tehlikesinifi,
    required this.depolokasyonu,
    required this.isDeleted,
    required this.giristarihi,
    required this.guncellemetarihi,
  });

  factory Kimyasal.fromJson(Map<String, dynamic> json) {
    return Kimyasal(
      id: json["id"] ?? 0,
      kimyasaladi: json["kimyasaladi"] ?? "",
      kategori: json["kategori"] ?? "",
      kimyasalkodu: json["kimyasalkodu"] ?? 0,
      birim: json["birim"] ?? "",
      stokmiktari: (json["stokmiktari"] ?? 0).toDouble(),
      minimumstok: json["minimumstok"] ?? 0,
      tedarikci: json["tedarikci"] ?? "",
      tehlikesinifi: json["tehlikesinifi"] ?? "",
      depolokasyonu: json["depolokasyonu"] ?? "",

      sonkullanmatarihi: json["sonkullanmatarihi"] != null
          ? DateTime.parse(json["sonkullanmatarihi"])
          : DateTime.now(),

      giristarihi: json["giristarihi"] != null
          ? DateTime.parse(json["giristarihi"])
          : DateTime.now(),

      guncellemetarihi: json["guncellemetarihi"] != null
          ? DateTime.parse(json["guncellemetarihi"])
          : DateTime.now(),

      isDeleted: json["is_deleted"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "kimyasaladi": kimyasaladi,
      "kimyasalkodu": kimyasalkodu,
      "kategori": kategori,
      "sonkullanmatarihi": sonkullanmatarihi.toIso8601String(),
      "birim": birim,
      "stokmiktari": stokmiktari,
      "minimumstok": minimumstok,
      "tedarikci": tedarikci,
      "tehlikesinifi": tehlikesinifi,
      "depolokasyonu": depolokasyonu,
      "giristarihi": giristarihi.toIso8601String(),
      "guncellemetarihi": guncellemetarihi.toIso8601String(),
      "is_deleted": isDeleted,
    };
  }
}