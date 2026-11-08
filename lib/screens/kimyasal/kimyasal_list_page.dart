
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/kimyasalprovider.dart';
import 'kimyasal_detay_page.dart';
import 'kimyasal_duzenle_page.dart';
import 'kimyasal_ekle_page.dart';

class KimyasalListPage extends ConsumerStatefulWidget {
  const KimyasalListPage({super.key});

  @override
  ConsumerState<KimyasalListPage> createState() =>
      _KimyasalListPageState();
}

class _KimyasalListPageState
    extends ConsumerState<KimyasalListPage> {

  late TextEditingController searchCtrl;

  @override
  void initState() {
    super.initState();

    searchCtrl = TextEditingController();

    Future.microtask(() {
      ref
          .read(kimyasalProvider.notifier)
          .fetchKimyasallar();
    });
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _delete(int id) async {
    await ref
        .read(kimyasalProvider.notifier)
        .deleteKimyasal(id);
  }

  String formatDate(DateTime date) {
    return
        "${date.day.toString().padLeft(2, '0')}."
        "${date.month.toString().padLeft(2, '0')}."
        "${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    final kimyasallar = ref.watch(
      kimyasalProvider,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Kimyasallar"),

        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete_outline,
            ),
            onPressed: () {
              // İleride Çöp Kutusu Sayfası
            },
          ),
        ],
      ),

      floatingActionButton:
          FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result =
              await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const KimyasalEklePage(),
            ),
          );

          if (result == true) {
            ref
                .read(
                  kimyasalProvider.notifier,
                )
                .fetchKimyasallar();
          }
        },
      ),

      body: Column(
        children: [

          Padding(
            padding:
                const EdgeInsets.all(8),
            child: TextField(
              controller: searchCtrl,
              decoration:
                  const InputDecoration(
                hintText: "Kimyasal Ara",
                prefixIcon:
                    Icon(Icons.search),
                border:
                    OutlineInputBorder(),
              ),
              onChanged: (value) {
                ref
                    .read(
                      kimyasalProvider.notifier,
                    )
                    .search(value);
              },
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount:
                  kimyasallar.length,
              itemBuilder:
                  (context, index) {

                final k =
                    kimyasallar[index];

                final updated =
                    k.guncellemetarihi
                            .difference(
                              k.giristarihi,
                            )
                            .inSeconds >
                        5;

                return Card(
                  margin:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),

                  child: ListTile(
                    title: Text(
                      k.kimyasaladi,
                    ),

                    subtitle: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [

                        const SizedBox(
                          height: 4,
                        ),

                        Text(
                          "Stok: ${k.stokmiktari} ${k.birim}",
                        ),

                        const SizedBox(
                          height: 4,
                        ),

                        Text(
                          updated
                              ? "Güncellendi: ${formatDate(k.guncellemetarihi)}"
                              : "Eklenme: ${formatDate(k.giristarihi)}",
                          style:
                              TextStyle(
                            fontSize: 12,
                            color: updated
                                ? Colors.orange
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    trailing: Row(
                      mainAxisSize:
                          MainAxisSize.min,
                      children: [

                        IconButton(
                          icon:
                              const Icon(
                            Icons
                                .visibility,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) =>
                                        KimyasalDetayPage(
                                  kimyasal:
                                      k,
                                ),
                              ),
                            );
                          },
                        ),

                        IconButton(
                          icon:
                              const Icon(
                            Icons.edit,
                          ),
                          onPressed:
                              () async {
                            final result =
                                await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) =>
                                        KimyasalDuzenlePage(
                                  kimyasal:
                                      k,
                                ),
                              ),
                            );

                            if (result ==
                                true) {
                              ref
                                  .read(
                                    kimyasalProvider.notifier,
                                  )
                                  .fetchKimyasallar();
                            }
                          },
                        ),

                        IconButton(
                          icon:
                              const Icon(
                            Icons
                                .delete,
                            color:
                                Colors.red,
                          ),
                          onPressed:
                              () {
                            showDialog(
                              context:
                                  context,
                              builder:
                                  (_) =>
                                      AlertDialog(
                                title:
                                    const Text(
                                  "Sil",
                                ),
                                content:
                                    const Text(
                                  "Kimyasalı silmek istiyor musunuz?",
                                ),
                                actions: [

                                  TextButton(
                                    onPressed:
                                        () {
                                      Navigator.pop(
                                        context,
                                      );
                                    },
                                    child:
                                        const Text(
                                      "Hayır",
                                    ),
                                  ),

                                  TextButton(
                                    onPressed:
                                        () async {
                                      await _delete(
                                        k.id,
                                      );

                                      if (context
                                          .mounted) {
                                        Navigator.pop(
                                          context,
                                        );
                                      }
                                    },
                                    child:
                                        const Text(
                                      "Evet",
                                    ),
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

