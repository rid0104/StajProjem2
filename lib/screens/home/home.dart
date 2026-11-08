import 'package:flutter/material.dart';

import '../urun/urun_list_page.dart';
import '../kumas/kumas_list_page.dart';
import '../../screens/stok/stokhareket.dart';
import '../kimyasal/kimyasal_list_page.dart';

import 'profile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget buildCard(
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 40),
              const SizedBox(height: 8),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Depo"),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: [
          buildCard(
            "Ürün",
            Icons.inventory,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const UrunListPage(),
              ),
            ),
          ),

          buildCard(
            "Kumaşlar",
            Icons.checkroom,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const KumasListPage(),
              ),
            ),
          ),

          buildCard(
            "Kimyasallar",
            Icons.science,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const KimyasalListPage(),
              ),
            ),
          ),

          buildCard(
            "Stok Kontrol ",
            Icons.science,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const StokPage(),
              ),
            ),
          ),

          buildCard(
            "Profil",
            Icons.person,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ProfilePage(),
              ),
            ),
          ),


        ],
      ),
    );
  }
}







