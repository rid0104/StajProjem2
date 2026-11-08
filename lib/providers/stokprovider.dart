
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/services/stok_service.dart';

final stokServiceProvider =
    Provider<StokService>((ref) {
  return StokService();
});
