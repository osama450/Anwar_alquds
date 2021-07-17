import 'package:Anwar/data/model/response/base/api_response.dart';
import 'package:Anwar/data/model/response/notification_model.dart';
import 'package:Anwar/data/repository/notification_repo.dart';
import 'package:Anwar/helper/api_checker.dart';
import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationRepo notificationRepo;

  NotificationProvider({@required this.notificationRepo});

  List<NotificationModel> _notificationList;
  List<NotificationModel> get notificationList => _notificationList;

  Future<void> initNotificationList(BuildContext context) async {
    ApiResponse apiResponse = await notificationRepo.getNotificationList();
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      _notificationList = [];
      apiResponse.response.data.forEach((notification) =>
          _notificationList.add(NotificationModel.fromJson(notification)));
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }
}
