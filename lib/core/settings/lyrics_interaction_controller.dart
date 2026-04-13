import 'package:flutter/foundation.dart';

import '../storage/binary_config_store.dart';
import '../storage/storage_keys.dart';

class LyricsInteractionController extends ChangeNotifier {
  LyricsInteractionController(this._configStore);

  final BinaryConfigStore _configStore;

  bool _enableCompactDetailPage = false;

  bool get enableCompactDetailPage => _enableCompactDetailPage;

  Future<void> load() async {
    await _configStore.init();
    final stored =
        _configStore.getValue<bool>(StorageKeys.enableCompactLyricsDetailPage);
    final next = stored ?? false;
    if (_enableCompactDetailPage != next) {
      _enableCompactDetailPage = next;
      notifyListeners();
    }
  }

  Future<void> setEnableCompactDetailPage(bool value) async {
    if (_enableCompactDetailPage == value) return;
    _enableCompactDetailPage = value;
    await _configStore.setValue(StorageKeys.enableCompactLyricsDetailPage, value);
    notifyListeners();
  }
}
