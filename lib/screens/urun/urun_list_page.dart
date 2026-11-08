import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/urunprovider.dart';
import 'urun_detay_page.dart';
import 'urun_duzenle_page.dart';
import 'urun_ekle_page.dart';

class UrunListPage extends ConsumerStatefulWidget {
  const UrunListPage({super.key});

  @override
  ConsumerState<UrunListPage> createState() =>
      _UrunListPageState();
}

class _UrunListPageState
    extends ConsumerState<UrunListPage> {
  late TextEditingController searchCtrl;

  @override
  void initState() {
    super.initState();

    searchCtrl = TextEditingController();

    Future.microtask(() {
      ref.read(urunProvider.notifier).fetchUrunler();
    });
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _delete(int id) async {
    await ref.read(urunProvider.notifier).deleteUrun(id);
  }

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}."
        "${date.month.toString().padLeft(2, '0')}."
        "${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    final urunler = ref.watch(urunProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ürünler"),
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const UrunEklePage(),
            ),
          );

          if (result == true) {
            ref.read(urunProvider.notifier).fetchUrunler();
          }
        },
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: searchCtrl,
              decoration: const InputDecoration(
                hintText: "Ürün Ara",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                ref.read(urunProvider.notifier).search(value);
              },
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: urunler.length,
              itemBuilder: (context, index) {
                final u = urunler[index];

                final updated = u.guncellemetarihi.isAfter(u.giristarihi);

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: ListTile(
                    title: Text(
                      u.uruntipi,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),

                        Text("Stok: ${u.miktar}"),

                        const SizedBox(height: 4),

                        Text(
                          updated
                              ? "Güncellendi: ${formatDate(u.guncellemetarihi)}"
                              : "Eklenme: ${formatDate(u.giristarihi)}",
                          style: TextStyle(
                            fontSize: 12,
                            color: updated
                                ? Colors.orange
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UrunDetayPage(urun: u),
                        ),
                      );
                    },

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.visibility),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    UrunDetayPage(urun: u),
                              ),
                            );
                          },
                        ),

                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    UrunDuzenlePage(urun: u),
                              ),
                            );

                            if (result == true) {
                              ref
                                  .read(urunProvider.notifier)
                                  .fetchUrunler();
                            }
                          },
                        ),

                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text("Sil"),
                                content: const Text(
                                  "Ürün silinsin mi?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Hayır"),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await _delete(u.id);

                                      if (context.mounted) {
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: const Text("Evet"),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}