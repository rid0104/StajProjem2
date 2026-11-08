import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/kumasprovider.dart';
import 'kumas_detay_page.dart';
import 'kumas_duzenle_page.dart';
import 'kumas_ekle_page.dart';

class KumasListPage extends ConsumerStatefulWidget {
  const KumasListPage({super.key});


  @override
  ConsumerState<KumasListPage> createState() =>
      _KumasListPageState();
}

class _KumasListPageState
    extends ConsumerState<KumasListPage> {

  final searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref
          .read(kumasProvider.notifier)
          .fetchKumaslar();
    });
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _delete(int id) async {
    await ref
        .read(kumasProvider.notifier)
        .deleteKumas(id);
  }

  String formatDate(DateTime date) {
    return
        "${date.day.toString().padLeft(2, '0')}."
        "${date.month.toString().padLeft(2, '0')}."
        "${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    final kumaslar = ref.watch(
      kumasProvider,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Kumaşlar"),

        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete_outline,
            ),
            onPressed: () {
              // KumasCopKutusuPage
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
                  const KumasEklePage(),
            ),
          );

          if (result == true) {
            ref
                .read(
                  kumasProvider.notifier,
                )
                .fetchKumaslar();
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
                hintText: "Kumaş Ara",
                prefixIcon:
                    Icon(Icons.search),
                border:
                    OutlineInputBorder(),
              ),
              onChanged: (value) {
                ref
                    .read(
                      kumasProvider.notifier,
                    )
                    .search(value);
              },
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount:
                  kumaslar.length,
              itemBuilder:
                  (context, index) {

                final k =
                    kumaslar[index];
                
                   
                final updated =
                    k.guncellemetarihi.isAfter(k.giristarihi);

                return Card(
                  margin:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),

                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) =>
                                  KumasDetayPage(
                            kumas: k,
                          ),
                        ),
                      );
                    },

                    title: Text(
                      k.kumasadi,
                      style:
                          const TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
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
                          "Tip: ${k.kumastipi}",
                        ),

                        Text(
                          "Stok: ${k.stokmiktari} ${k.birim}",
                        ),

                        Text(
                          "Renk: ${k.renk}",
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
                                        KumasDuzenlePage(
                                  kumas:
                                      k,
                                ),
                              ),
                            );

                            if (result ==
                                true) {
                              ref
                                  .read(
                                    kumasProvider.notifier,
                                  )
                                  .fetchKumaslar();
                            }
                          },
                        ),

                        IconButton(
                          icon:
                              const Icon(
                            Icons.delete,
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
                                    Text(
                                  "${k.kumasadi} silinsin mi?",
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