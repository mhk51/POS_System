import 'package:scanner_app/models/settings.dart';
import 'package:scanner_app/objectbox.g.dart';
import 'package:scanner_app/services/open_store.dart';

class SettingsServices {
  late final Store _store;
  static late final Box<Settings> _boxSettings;

  SettingsServices._create(this._store) {
    _boxSettings = Box<Settings>(_store);
    _boxSettings.put(Settings());
  }
  static Future<SettingsServices> create() async {
    final store = await StoreService.create();
    return SettingsServices._create(store);
  }

  static Settings getSettings() {
    return _boxSettings.getAll().first;
  }

  static void updateSettings(Settings settings) {
    settings.id = getSettings().id;
    _boxSettings.put(settings, mode: PutMode.update);
  }
}
