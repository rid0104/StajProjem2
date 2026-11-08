
import 'package:flutter/material.dart';
import '../../models/kumas.dart';
import '../../core/services/kumas_service.dart';

class KumasDuzenlePage extends StatefulWidget {
  final Kumas kumas;

  const KumasDuzenlePage({
    super.key,
    required this.kumas,
  });

  @override
  State<KumasDuzenlePage> createState() =>
      _KumasDuzenlePageState();
}

class _KumasDuzenlePageState
    extends State<KumasDuzenlePage> {

  late TextEditingController adCtrl;
  late TextEditingController tipCtrl;
  late TextEditingController kodCtrl;
  late TextEditingController partiCtrl;
  late TextEditingController birimCtrl;
  late TextEditingController renkCtrl;
  late TextEditingController topCtrl;
  late TextEditingController durumCtrl;
  late TextEditingController depoCtrl;

  @override
  void initState() {
    super.initState();

    adCtrl =
        TextEditingController(text: widget.kumas.kumasadi);

    tipCtrl =
        TextEditingController(text: widget.kumas.kumastipi);

    kodCtrl =
        TextEditingController(
          text: widget.kumas.kumaskodu.toString(),
        );

 

    partiCtrl =
        TextEditingController(
          text: widget.kumas.partino.toString(),
        );

    birimCtrl =
        TextEditingController(
          text: widget.kumas.birim,
        );

    renkCtrl =
        TextEditingController(
          text: widget.kumas.renk,
        );

    topCtrl =
        TextEditingController(
          text: widget.kumas.topsayisi.toString(),
        );

    durumCtrl =
        TextEditingController(
          text: widget.kumas.durum,
        );

    depoCtrl =
        TextEditingController(
          text: widget.kumas.depolokasyonu,
        );
  }

  @override
  void dispose() {
    adCtrl.dispose();
    tipCtrl.dispose();
    kodCtrl.dispose();

    partiCtrl.dispose();
    birimCtrl.dispose();
    renkCtrl.dispose();
    topCtrl.dispose();
    durumCtrl.dispose();
    depoCtrl.dispose();
    super.dispose();
  }

Future<void> _guncelle() async {
  await KumasService().update(widget.kumas.id, {
    "kumasadi": adCtrl.text,
    "kumastipi": tipCtrl.text,
    "kumaskodu": int.tryParse(kodCtrl.text) ?? 0,

    "partino": int.tryParse(partiCtrl.text) ?? 0,
    "birim": birimCtrl.text,
    "renk": renkCtrl.text,
    "topsayisi": int.tryParse(topCtrl.text) ?? 0,
    "durum": durumCtrl.text,
    "depolokasyonu": depoCtrl.text,
  });

  if (mounted) Navigator.pop(context, true);
}

  Widget buildField(
    TextEditingController controller,
    String label, {
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kumaş Düzenle"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            buildField(adCtrl, "Kumaş Adı"),
            buildField(tipCtrl, "Kumaş Tipi"),

            buildField(
              kodCtrl,
              "Kumaş Kodu",
              keyboardType: TextInputType.number,
            ),

            

            buildField(
              partiCtrl,
              "Parti No",
              keyboardType: TextInputType.number,
            ),

            buildField(
              birimCtrl,
              "Birim",
            ),

        

            buildField(
              renkCtrl,
              "Renk",
            ),

            buildField(
              topCtrl,
              "Top Sayısı",
              keyboardType: TextInputType.number,
            ),

            buildField(
              durumCtrl,
              "Durum",
            ),

            buildField(
              depoCtrl,
              "Depo Lokasyonu",
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _guncelle,
              child: const Text("Güncelle"),
            ),
          ],
        ),
      ),
    );
  }
}
