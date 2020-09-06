import 'package:lorax/notifications/NotificationManager.dart';

import '../database/moor_database.dart';
import '../enums/icon_enum.dart';
import 'package:scoped_model/scoped_model.dart';

class NotificationModel extends Model with IconMixin {
  final AppDatabase _database = AppDatabase();
  final NotificationManager notificationManager = NotificationManager();
  NotificationModel();

  Future<List<NotifyTableData>> getMedicineList() async {
    return await _database.getAllNotification();
  }

  AppDatabase getDatabase() {
    return _database;
  }

  void toggleIconState() {
    toggleState();
    notifyListeners();
  }

  DeleteIconState getIconState() {
    return getCurrentIconState();
  }

  void refreshList() {
    notifyListeners();
  }
}

mixin IconMixin {
  var iconState = DeleteIconState.hide; // default

  void toggleState() {
    if (iconState == DeleteIconState.hide) {
      iconState = DeleteIconState.show;
    } else {
      iconState = DeleteIconState.hide;
    }
  }

  DeleteIconState getCurrentIconState() {
    return iconState;
  }
}