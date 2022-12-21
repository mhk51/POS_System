import 'package:scanner_app/objectbox.g.dart';

class StoreService {
  static Store? _store;

  static Future<Store> create() async {
    if (_store == null) {
      _store = await openStore();
      return _store!;
    } else {
      return _store!;
    }
  }
}
