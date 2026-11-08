

import 'package:flutter/material.dart';
import '../auth/login.dart';
import '../../core/token_storage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
      ),
      body: Column(
        children: [

          ListTile(
            title: Text("Kullanıcı"),
          ),

          ElevatedButton(
            onPressed: () async {

              await TokenStorage.clearToken();

              if(context.mounted){
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const LoginPage(),
                  ),
                  (route) => false,
                );
              }
            },
            child: const Text("Çıkış Yap"),
          )
        ],
      ),
    );
  }
}
