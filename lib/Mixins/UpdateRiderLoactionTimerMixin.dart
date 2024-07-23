import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/API_models/API_response.dart';
import '../models/API_models/LogInModel.dart';

mixin PeriodicApiMixin {
  void startPeriodicApiCalls(
      {required Duration duration, required Function callback}) {
    Timer.periodic(duration, (Timer timer) {
      callback();
    });
  }

  /// Update rider location after a certain amount of time API:

  Future<APIResponse<LogInModel>> updateRiderLocationAPI(Map data) async {
    String API = 'https://deliverbygfl.com/api/update_location_rider';
    return http.post(Uri.parse(API), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonData = json.decode(value.body);

        if (jsonData['data'] != null) {
          final itemCat = LogInModel.fromJson(jsonData['data']);
          return APIResponse<LogInModel>(
              data: itemCat,
              status: jsonData['status'],
              message: jsonData['message']);
        } else {
          return APIResponse<LogInModel>(
              data: LogInModel(),
              status: jsonData['status'],
              message: jsonData['message']);
        }
      }
      return APIResponse<LogInModel>(
        status: APIResponse.fromMap(json.decode(value.body)).status,
        message: APIResponse.fromMap(json.decode(value.body)).message,
      );
    }).onError((error, stackTrace) => APIResponse<LogInModel>(
          status: error.toString(),
          message: stackTrace.toString(),
        ));
  }
}
