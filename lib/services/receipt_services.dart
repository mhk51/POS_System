import 'package:scanner_app/models/receipts.dart';
import 'package:scanner_app/objectbox.g.dart';
import 'package:scanner_app/services/open_store.dart';

class ReceiptServices {
  late final Store _store;
  static late final Box<Receipt> _boxReceipt;

  ReceiptServices._create(this._store) {
    _boxReceipt = Box<Receipt>(_store);
  }
  static Future<ReceiptServices> create() async {
    final store = await StoreService.create();
    return ReceiptServices._create(store);
  }

  static void insertReceipt(Receipt receipt) {
    _boxReceipt.put(receipt);
  }

  static List<Receipt> getAllReceipts() {
    return _boxReceipt.getAll();
  }

  static void deleteReceipt(int? id) {
    if (id != null) {
      _boxReceipt.remove(id);
    }
  }
}
