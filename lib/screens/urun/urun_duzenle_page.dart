import 'package:flutter/material.dart';
import '../../models/urun.dart';
import '../../core/services/urun_service.dart';

class UrunDuzenlePage extends StatefulWidget {
  final Urun urun;

  const UrunDuzenlePage({
    super.key,
    required this.urun,
  });

  @override
  State<UrunDuzenlePage> createState() =>
      _UrunDuzenlePageState();
}

class _UrunDuzenlePageState
    extends State<UrunDuzenlePage> {

  late TextEditingController urunCtrl;
  late TextEditingController partiCtrl;
  late TextEditingController birimCtrl;
  late TextEditingController minimumCtrl;

  late TextEditingController aciklamaCtrl;


  @override
  void initState() {
    super.initState();

    urunCtrl =
        TextEditingController(text: widget.urun.uruntipi);

    partiCtrl =
        TextEditingController(text: widget.urun.partino.toString());

    birimCtrl =
        TextEditingController(text: widget.urun.birim);


    minimumCtrl =
        TextEditingController(text: widget.urun.minimumstok.toString());

    aciklamaCtrl =
        TextEditingController(text: widget.urun.aciklama);

    
  }

  @override
  void dispose() {
    urunCtrl.dispose();
    partiCtrl.dispose();
    birimCtrl.dispose();

    minimumCtrl.dispose();
    aciklamaCtrl.dispose();
 
    super.dispose();
  }

  Future<void> _guncelle() async {
    await UrunService().update(
      widget.urun.id,
      {
        "uruntipi": urunCtrl.text,
    
        "partino": int.tryParse(partiCtrl.text) ?? 0,
        "birim": birimCtrl.text,
        "minimumstok":
            int.tryParse(minimumCtrl.text) ?? 0,
        "aciklama": aciklamaCtrl.text,
   
   
      },
    );

    if (mounted) {
      Navigator.pop(context, true);
    }
  }

  Widget field(
    TextEditingController c,
    String label, {
    TextInputType? type,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        keyboardType: type,
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
        title: const Text("Ürün Düzenle"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            field(urunCtrl, "Ürün Tipi"),
         
            field(partiCtrl, "Parti No",
                type: TextInputType.number),
            field(birimCtrl, "Birim"),
            field(minimumCtrl, "Minimum Stok",
                type: TextInputType.number),
            field(aciklamaCtrl, "Açıklama"),
        
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