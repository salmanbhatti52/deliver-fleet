import 'dart:convert';

import 'package:deliver_partner/models/API%20models/GetAllAvailableVehicles.dart';
import 'package:deliver_partner/models/API%20models/GetAllSystemDataModel.dart';
import 'package:deliver_partner/models/API%20models/GetAllUserToUsreChatModel.dart';
import 'package:deliver_partner/models/API%20models/InProgressRidesModel.dart';
import 'package:deliver_partner/models/API%20models/ShowBookingsModel.dart';
import 'package:deliver_partner/models/APIModelsFleet/AcceptAndRejectRequestedVehicleModel.dart';
import 'package:deliver_partner/models/GetFleetVehicleByIdModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/API models/API response.dart';
import '../models/API models/AddVehicleModel.dart';
import '../models/API models/GetAllNotificationsModel.dart';
import '../models/API models/GetAllRatingsModel.dart';
import '../models/API models/GetAllSupportMessagesModel.dart';
import '../models/API models/GetAllVehicalsModel.dart';
import '../models/API models/GetBookingDeatinationsStatus.dart';
import '../models/API models/LogInModel.dart';
import '../models/API models/ReadNotificationsModel.dart';
import '../models/API models/RequestBikeModel.dart';
import '../models/API models/ScheduledRiderModel.dart';
import '../models/API models/SupportedUserModel.dart';
import '../models/APIModelsFleet/GetAllRidersModel.dart';
import '../models/APIModelsFleet/GetAllVehiclesFleetModel.dart';
import '../models/APIModelsFleet/GetFleetVehicleRequestByIdModel.dart';
import '../models/APIModelsFleet/UploadCACCertificateModel.dart';
import '../models/tempLoginModel.dart';

class ApiServices {
  /// Sign-up API:

  Future<APIResponse<APIResponse>> signUpAPI(Map data) async {
    String API = 'https://deliver.eigix.net/api/email_signup_fleet';
    return http.post(Uri.parse(API), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonData = json.decode(value.body);
        if (jsonData is Map &&
            jsonData.containsKey('status') &&
            jsonData.containsKey('message')) {
          return APIResponse<APIResponse>(
              status: jsonData['status'], message: jsonData['message']);
        }
      }
      if (value.body is Map) {
        final jsonData = json.decode(value.body);
        if (jsonData.containsKey('status') && jsonData.containsKey('message')) {
          return APIResponse<APIResponse>(
            status: APIResponse.fromMap(jsonData).status,
            message: APIResponse.fromMap(jsonData).message,
          );
        }
      }
      return APIResponse<APIResponse>(
        status: 'Error',
        message: 'Unexpected server response',
      );
    }).onError((error, stackTrace) => APIResponse<APIResponse>(
          status: error.toString(),
          message: stackTrace.toString(),
        ));
  }

  /// LogIn API:
//Temp Login API Function
  Future<APIResponse<TempLoginModel>> tempLoginAPI(Map data) async {
    String API = 'https://deliver.eigix.net/api/email_login_fleet';

    try {
      var response = await http.post(Uri.parse(API), body: data);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['data'] != null) {
          final itemCat = TempLoginModel.fromJson(jsonData['data']);

          return APIResponse<TempLoginModel>(
              data: itemCat,
              status: jsonData['status'],
              message: jsonData['message']);
        } else {
          return APIResponse<TempLoginModel>(
              data: TempLoginModel(),
              status: jsonData['status'],
              message: jsonData['message']);
        }
      }

      return APIResponse<TempLoginModel>(
        status: APIResponse.fromMap(json.decode(response.body)).status,
        message: APIResponse.fromMap(json.decode(response.body)).message,
      );
    } catch (error) {
      return APIResponse<TempLoginModel>(
        status: error.toString(),
        message: error.toString(),
      );
    }
  }

  Future<APIResponse<LogInModel>> logInAPI(Map data) async {
    String API = 'https://deliver.eigix.net/api/login_fleet';
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

  /// Update Location one time API:

  Future<APIResponse<LogInModel>> updateLocationOneTimeAPI(Map data) async {
    String API = 'https://deliver.eigix.net/api/update_location_fleet';
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

  /// Forget API:

  Future<APIResponse<APIResponse>> forgetPasswordAPI(Map data) async {
    String API = 'https://deliver.eigix.net/api/forgot_password_fleet';
    return http.post(Uri.parse(API), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonData = json.decode(value.body);

        return APIResponse<APIResponse>(
            status: jsonData['status'], message: jsonData['message']);
      }
      return APIResponse<APIResponse>(
        status: APIResponse.fromMap(json.decode(value.body)).status,
        message: APIResponse.fromMap(json.decode(value.body)).message,
      );
    }).onError((error, stackTrace) => APIResponse<APIResponse>(
          status: error.toString(),
          message: stackTrace.toString(),
        ));
  }

  /// Forget Password Opt API:

  Future<APIResponse<APIResponse>> forgetPasswordOtpAPI(Map data) async {
    String API =
        'https://deliver.eigix.net/api/verify_forgot_password_otp_fleet';
    return http.post(Uri.parse(API), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonData = json.decode(value.body);

        return APIResponse<APIResponse>(
            status: jsonData['status'], message: jsonData['message']);
      }
      return APIResponse<APIResponse>(
        status: APIResponse.fromMap(json.decode(value.body)).status,
        message: APIResponse.fromMap(json.decode(value.body)).message,
      );
    }).onError((error, stackTrace) => APIResponse<APIResponse>(
          status: error.toString(),
          message: stackTrace.toString(),
        ));
  }

  /// reset Password  API:

  Future<APIResponse<APIResponse>> resetPasswordAPI(Map data) async {
    String API = 'https://deliver.eigix.net/api/reset_password_fleet';
    return http.post(Uri.parse(API), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonData = json.decode(value.body);

        return APIResponse<APIResponse>(
            status: jsonData['status'], message: jsonData['message']);
      }
      return APIResponse<APIResponse>(
        status: APIResponse.fromMap(json.decode(value.body)).status,
        message: APIResponse.fromMap(json.decode(value.body)).message,
      );
    }).onError((error, stackTrace) => APIResponse<APIResponse>(
          status: error.toString(),
          message: stackTrace.toString(),
        ));
  }

  /// E-mail verification after signup API:

  Future<APIResponse<APIResponse>> verifyEmailAPI(Map data) async {
    String API = 'https://deliver.eigix.net/api/verify_email_fleet';
    return http.post(Uri.parse(API), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonData = json.decode(value.body);

        return APIResponse<APIResponse>(
            status: jsonData['status'], message: jsonData['message']);
      }
      return APIResponse<APIResponse>(
        status: APIResponse.fromMap(json.decode(value.body)).status,
        message: APIResponse.fromMap(json.decode(value.body)).message,
      );
    }).onError((error, stackTrace) => APIResponse<APIResponse>(
          status: error.toString(),
          message: stackTrace.toString(),
        ));
  }

  /// verify otp API:

  Future<APIResponse<APIResponse>> verifyOtpApi(Map data) async {
    String API = 'https://deliver.eigix.net/api/verify_email_otp_fleet';
    return http.post(Uri.parse(API), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonData = json.decode(value.body);

        return APIResponse<APIResponse>(
            status: jsonData['status'], message: jsonData['message']);
      }
      return APIResponse<APIResponse>(
        status: APIResponse.fromMap(json.decode(value.body)).status,
        message: APIResponse.fromMap(json.decode(value.body)).message,
      );
    }).onError((error, stackTrace) => APIResponse<APIResponse>(
          status: error.toString(),
          message: stackTrace.toString(),
        ));
  }

  /// Driving License API:

  Future<APIResponse<APIResponse>> verifyDrivingLicenseAPI(Map data) async {
    String API = 'https://deliver.eigix.net/api/verify_driving_license';
    return http.post(Uri.parse(API), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonData = json.decode(value.body);

        return APIResponse<APIResponse>(
          status: jsonData['status'],
          message: jsonData['message'],
        );
      }
      return APIResponse<APIResponse>(
        status: APIResponse.fromMap(json.decode(value.body)).status,
        message: APIResponse.fromMap(json.decode(value.body)).message,
      );
    }).onError((error, stackTrace) => APIResponse<APIResponse>(
          status: error.toString(),
          message: stackTrace.toString(),
        ));
  }

  /// Get Bike Categories API:

  Future<APIResponse<List<GetAllVehicalsModel>>> getBikeCategoryAPI() {
    String api = 'https://deliver.eigix.net/api/get_vehicles';
    return http
        .get(
      Uri.parse(
        api,
      ),
    )
        .then((value) {
      if (value.statusCode == 200) {
        final jsonResult = jsonDecode(value.body);
        if (jsonResult['data'] != null) {
          final jsonResultArray = <GetAllVehicalsModel>[];
          for (var item in jsonResult['data']) {
            final jsonData = GetAllVehicalsModel.fromJson(item);
            jsonResultArray.add(jsonData);
          }

          return APIResponse<List<GetAllVehicalsModel>>(
            data: jsonResultArray,
            status: jsonResult['status'],
            message: jsonResult['message'],
          );
        } else {
          return APIResponse<List<GetAllVehicalsModel>>(
            data: [],
            status: jsonResult['status'],
            message: jsonResult['message'],
          );
        }
      }
      return APIResponse<List<GetAllVehicalsModel>>(
        status: APIResponse.fromMap(
          jsonDecode(value.body),
        ).status,
        message: APIResponse.fromMap(
          jsonDecode(value.body),
        ).message,
      );
    }).onError(
      (error, stackTrace) => APIResponse<List<GetAllVehicalsModel>>(
        status: error.toString(),
        message: stackTrace.toString(),
      ),
    );
  }

  /// Get all system data API:

  Future<APIResponse<List<GetAllSystemDataModel>>> getALlSystemDataAPI() {
    String api = 'https://deliver.eigix.net/api/get_all_system_data';
    return http
        .get(
      Uri.parse(
        api,
      ),
    )
        .then((value) {
      if (value.statusCode == 200) {
        final jsonResult = jsonDecode(value.body);
        if (jsonResult['data'] != null) {
          final jsonResultArray = <GetAllSystemDataModel>[];
          for (var item in jsonResult['data']) {
            final jsonData = GetAllSystemDataModel.fromJson(item);
            jsonResultArray.add(jsonData);
          }

          return APIResponse<List<GetAllSystemDataModel>>(
            data: jsonResultArray,
            status: jsonResult['status'],
            message: jsonResult['message'],
          );
        } else {
          return APIResponse<List<GetAllSystemDataModel>>(
            data: [],
            status: jsonResult['status'],
            message: jsonResult['message'],
          );
        }
      }
      return APIResponse<List<GetAllSystemDataModel>>(
        status: APIResponse.fromMap(
          jsonDecode(value.body),
        ).status,
        message: APIResponse.fromMap(
          jsonDecode(value.body),
        ).message,
      );
    }).onError(
      (error, stackTrace) => APIResponse<List<GetAllSystemDataModel>>(
        status: error.toString(),
        message: stackTrace.toString(),
      ),
    );
  }

  /// Get booking destinaions status API:

  Future<APIResponse<List<GetBookingDestinationsStatus>>>
      getBookingDestinationsStatusAPI() {
    String api =
        'https://deliver.eigix.net/api/get_bookings_destinations_status';
    return http
        .get(
      Uri.parse(
        api,
      ),
    )
        .then((value) {
      if (value.statusCode == 200) {
        final jsonResult = jsonDecode(value.body);
        if (jsonResult['data'] != null) {
          final jsonResultArray = <GetBookingDestinationsStatus>[];
          for (var item in jsonResult['data']) {
            final jsonData = GetBookingDestinationsStatus.fromJson(item);
            jsonResultArray.add(jsonData);
          }

          return APIResponse<List<GetBookingDestinationsStatus>>(
            data: jsonResultArray,
            status: jsonResult['status'],
            message: jsonResult['message'],
          );
        } else {
          return APIResponse<List<GetBookingDestinationsStatus>>(
            data: [],
            status: jsonResult['status'],
            message: jsonResult['message'],
          );
        }
      }
      return APIResponse<List<GetBookingDestinationsStatus>>(
        status: APIResponse.fromMap(
          jsonDecode(value.body),
        ).status,
        message: APIResponse.fromMap(
          jsonDecode(value.body),
        ).message,
      );
    }).onError(
      (error, stackTrace) => APIResponse<List<GetBookingDestinationsStatus>>(
        status: error.toString(),
        message: stackTrace.toString(),
      ),
    );
  }

  /// Upload CAC Certificate API:

  Future<APIResponse<UploadCACCertificateModel>> uploadCACApi(Map data) async {
    String API = 'https://deliver.eigix.net/api/upload_cac_certificate';
    return http.post(Uri.parse(API), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonData = json.decode(value.body);

        if (jsonData['data'] != null) {
          final itemCat = UploadCACCertificateModel.fromJson(jsonData['data']);
          return APIResponse<UploadCACCertificateModel>(
              data: itemCat,
              status: jsonData['status'],
              message: jsonData['message']);
        } else {
          return APIResponse<UploadCACCertificateModel>(
              data: UploadCACCertificateModel(),
              status: jsonData['status'],
              message: jsonData['message']);
        }
      }
      return APIResponse<UploadCACCertificateModel>(
        status: APIResponse.fromMap(json.decode(value.body)).status,
        message: APIResponse.fromMap(json.decode(value.body)).message,
      );
    }).onError((error, stackTrace) => APIResponse<UploadCACCertificateModel>(
          status: error.toString(),
          message: stackTrace.toString(),
        ));
  }

  /// Add Bike API:

  Future<APIResponse<AddVehicleModel>> addVehicleAPI(Map data) async {
    String API = 'https://deliver.eigix.net/api/add_fleet_vehicle';
    return http.post(Uri.parse(API), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonData = json.decode(value.body);

        if (jsonData['data'] != null) {
          final itemCat = AddVehicleModel.fromJson(jsonData['data']);
          return APIResponse<AddVehicleModel>(
              data: itemCat,
              status: jsonData['status'],
              message: jsonData['message']);
        } else {
          return APIResponse<AddVehicleModel>(
              data: AddVehicleModel(),
              status: jsonData['status'],
              message: jsonData['message']);
        }
      }
      return APIResponse<AddVehicleModel>(
        status: APIResponse.fromMap(json.decode(value.body)).status,
        message: APIResponse.fromMap(json.decode(value.body)).message,
      );
    }).onError((error, stackTrace) => APIResponse<AddVehicleModel>(
          status: error.toString(),
          message: stackTrace.toString(),
        ));
  }

  /// update status of rider API:

  Future<APIResponse<LogInModel>> updateRiderStatusApi(Map data) async {
    String API = 'https://deliver.eigix.net/api/update_rider_status';
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

  /// update notification switch api:

  Future<APIResponse<LogInModel>> updateNotificationStatusApi(Map data) async {
    String API =
        'https://deliver.eigix.net/api/update_notification_switch_fleet';
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

  /// Update Email API:

  Future<APIResponse<LogInModel>> updateEmailApi(Map data) async {
    String API = 'https://deliver.eigix.net/api/update_email_fleet';
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

  /// Update Password API:

  Future<APIResponse<LogInModel>> updatePasswordApi(Map data) async {
    String API = 'https://deliver.eigix.net/api/update_password_fleet';
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

  /// Get Fleet Vehicle By Id API:

  Future<APIResponse<GetFleetVehicleByIdModel>> getFleetVehicleByIdApi(
      Map data) async {
    String API = 'https://deliver.eigix.net/api/get_fleet_vehicle_by_id';
    return http.post(Uri.parse(API), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonData = json.decode(value.body);

        if (jsonData['data'] != null) {
          final itemCat = GetFleetVehicleByIdModel.fromJson(jsonData['data']);

          return APIResponse<GetFleetVehicleByIdModel>(
              data: itemCat,
              status: jsonData['status'],
              message: jsonData['message']);
        } else {
          return APIResponse<GetFleetVehicleByIdModel>(
              data: GetFleetVehicleByIdModel(),
              status: jsonData['status'],
              message: jsonData['message']);
        }
      }
      return APIResponse<GetFleetVehicleByIdModel>(
        status: APIResponse.fromMap(json.decode(value.body)).status,
        message: APIResponse.fromMap(json.decode(value.body)).message,
      );
    }).onError((error, stackTrace) => APIResponse<GetFleetVehicleByIdModel>(
          status: error.toString(),
          message: stackTrace.toString(),
        ));
  }

  /// Get ALl Fleet Vehicle Requests By Id API:

  Future<APIResponse<List<GetFleetVehicleRequestByIdModel>>>
      getAllFleetVehicleRequestByIdApi(Map data) {
    String api =
        'https://deliver.eigix.net/api/get_requests_fleet_vehicle_by_id';
    return http.post(Uri.parse(api), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonResult = jsonDecode(value.body);
        if (jsonResult['data'] != null) {
          final jsonResultArray = <GetFleetVehicleRequestByIdModel>[];
          for (var item in jsonResult['data']) {
            final jsonData = GetFleetVehicleRequestByIdModel.fromJson(item);
            jsonResultArray.add(jsonData);
          }

          return APIResponse<List<GetFleetVehicleRequestByIdModel>>(
            data: jsonResultArray,
            status: jsonResult['status'],
            message: jsonResult['message'],
          );
        } else {
          return APIResponse<List<GetFleetVehicleRequestByIdModel>>(
            data: [],
            status: jsonResult['status'],
            message: jsonResult['message'],
          );
        }
      }
      return APIResponse<List<GetFleetVehicleRequestByIdModel>>(
        status: APIResponse.fromMap(
          jsonDecode(value.body),
        ).status,
        message: APIResponse.fromMap(
          jsonDecode(value.body),
        ).message,
      );
    }).onError(
      (error, stackTrace) => APIResponse<List<GetFleetVehicleRequestByIdModel>>(
        status: error.toString(),
        message: stackTrace.toString(),
      ),
    );
  }

  /// Accept Vehicle Request API:

  Future<APIResponse<AcceptAndRejectRequestedVehicleModel>>
      acceptVehicleRequest(Map data) async {
    String API = 'https://deliver.eigix.net/api/accept_request_fleet_vehicle';
    return http.post(Uri.parse(API), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonData = json.decode(value.body);
        if (jsonData['data'] != null) {
          final itemCat =
              AcceptAndRejectRequestedVehicleModel.fromJson(jsonData['data']);
          return APIResponse<AcceptAndRejectRequestedVehicleModel>(
              data: itemCat,
              status: jsonData['status'],
              message: jsonData['message']);
        } else {
          return APIResponse<AcceptAndRejectRequestedVehicleModel>(
              data: AcceptAndRejectRequestedVehicleModel(),
              status: jsonData['status'],
              message: jsonData['message']);
        }
      }
      return APIResponse<AcceptAndRejectRequestedVehicleModel>(
        status: APIResponse.fromMap(json.decode(value.body)).status,
        message: APIResponse.fromMap(json.decode(value.body)).message,
      );
    }).onError((error, stackTrace) =>
        APIResponse<AcceptAndRejectRequestedVehicleModel>(
          status: error.toString(),
          message: stackTrace.toString(),
        ));
  }

  /// deactivate Vehicle Request API:

  Future<APIResponse<AcceptAndRejectRequestedVehicleModel>>
      deactivateVehicleRequest(Map data) async {
    String API = 'https://deliver.eigix.net/api/deactivate_fleet_vehicle';
    return http.post(Uri.parse(API), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonData = json.decode(value.body);
        if (jsonData['data'] != null) {
          final itemCat =
              AcceptAndRejectRequestedVehicleModel.fromJson(jsonData['data']);
          return APIResponse<AcceptAndRejectRequestedVehicleModel>(
              data: itemCat,
              status: jsonData['status'],
              message: jsonData['message']);
        } else {
          return APIResponse<AcceptAndRejectRequestedVehicleModel>(
              data: AcceptAndRejectRequestedVehicleModel(),
              status: jsonData['status'],
              message: jsonData['message']);
        }
      }
      return APIResponse<AcceptAndRejectRequestedVehicleModel>(
        status: APIResponse.fromMap(json.decode(value.body)).status,
        message: APIResponse.fromMap(json.decode(value.body)).message,
      );
    }).onError((error, stackTrace) =>
        APIResponse<AcceptAndRejectRequestedVehicleModel>(
          status: error.toString(),
          message: stackTrace.toString(),
        ));
  }

  /// Reject Vehicle Request API:

  Future<APIResponse<AcceptAndRejectRequestedVehicleModel>>
      rejectVehicleRequest(Map data) async {
    String API = 'https://deliver.eigix.net/api/reject_request_fleet_vehicle';
    return http.post(Uri.parse(API), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonData = json.decode(value.body);

        if (jsonData['data'] != null) {
          final itemCat =
              AcceptAndRejectRequestedVehicleModel.fromJson(jsonData['data']);
          return APIResponse<AcceptAndRejectRequestedVehicleModel>(
              data: itemCat,
              status: jsonData['status'],
              message: jsonData['message']);
        } else {
          return APIResponse<AcceptAndRejectRequestedVehicleModel>(
              data: AcceptAndRejectRequestedVehicleModel(),
              status: jsonData['status'],
              message: jsonData['message']);
        }
      }
      return APIResponse<AcceptAndRejectRequestedVehicleModel>(
        status: APIResponse.fromMap(json.decode(value.body)).status,
        message: APIResponse.fromMap(json.decode(value.body)).message,
      );
    }).onError((error, stackTrace) =>
        APIResponse<AcceptAndRejectRequestedVehicleModel>(
          status: error.toString(),
          message: stackTrace.toString(),
        ));
  }

  /// Request Bike API:

  Future<APIResponse<RequestBikeModel>> requestBikeAPI(Map data) async {
    String API = 'https://deliver.eigix.net/api/send_request_fleet_vehicle';
    return http.post(Uri.parse(API), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonData = json.decode(value.body);

        if (jsonData['data'] != null) {
          final itemCat = RequestBikeModel.fromJson(jsonData['data']);
          return APIResponse<RequestBikeModel>(
              data: itemCat,
              status: jsonData['status'],
              message: jsonData['message']);
        } else {
          return APIResponse<RequestBikeModel>(
              data: RequestBikeModel(),
              status: jsonData['status'],
              message: jsonData['message']);
        }
      }
      return APIResponse<RequestBikeModel>(
        status: APIResponse.fromMap(json.decode(value.body)).status,
        message: APIResponse.fromMap(json.decode(value.body)).message,
      );
    }).onError((error, stackTrace) => APIResponse<RequestBikeModel>(
          status: error.toString(),
          message: stackTrace.toString(),
        ));
  }

  /// Get All Ratings API:

  Future<APIResponse<List<GetAllRatingsModel>>> getAllRatingsAPI(Map data) {
    String api = 'https://deliver.eigix.net/api/get_ratings_bookings';
    return http.post(Uri.parse(api), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonResult = jsonDecode(value.body);
        if (jsonResult['data'] != null) {
          final jsonResultArray = <GetAllRatingsModel>[];
          for (var item in jsonResult['data']) {
            final jsonData = GetAllRatingsModel.fromJson(item);
            jsonResultArray.add(jsonData);
          }

          return APIResponse<List<GetAllRatingsModel>>(
            data: jsonResultArray,
            status: jsonResult['status'],
            message: jsonResult['message'],
          );
        } else {
          return APIResponse<List<GetAllRatingsModel>>(
            data: [],
            status: jsonResult['status'],
            message: jsonResult['message'],
          );
        }
      }
      return APIResponse<List<GetAllRatingsModel>>(
        status: APIResponse.fromMap(
          jsonDecode(value.body),
        ).status,
        message: APIResponse.fromMap(
          jsonDecode(value.body),
        ).message,
      );
    }).onError(
      (error, stackTrace) => APIResponse<List<GetAllRatingsModel>>(
        status: error.toString(),
        message: stackTrace.toString(),
      ),
    );
  }

  /// InProgress Rides API:

  Future<APIResponse<List<InProgressRidesModel>>> inProgressRidesAPI(Map data) {
    String api = 'https://deliver.eigix.net/api/get_bookings_ongoing_fleet';
    return http.post(Uri.parse(api), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonResult = jsonDecode(value.body);
        if (jsonResult['data'] != null) {
          final jsonResultArray = <InProgressRidesModel>[];
          for (var item in jsonResult['data']) {
            final jsonData = InProgressRidesModel.fromJson(item);
            jsonResultArray.add(jsonData);
          }

          return APIResponse<List<InProgressRidesModel>>(
            data: jsonResultArray,
            status: jsonResult['status'],
            message: jsonResult['message'],
          );
        } else {
          return APIResponse<List<InProgressRidesModel>>(
            data: [],
            status: jsonResult['status'],
            message: jsonResult['message'],
          );
        }
      }
      return APIResponse<List<InProgressRidesModel>>(
        status: APIResponse.fromMap(
          jsonDecode(value.body),
        ).status,
        message: APIResponse.fromMap(
          jsonDecode(value.body),
        ).message,
      );
    }).onError(
      (error, stackTrace) => APIResponse<List<InProgressRidesModel>>(
        status: error.toString(),
        message: stackTrace.toString(),
      ),
    );
  }

  /// Get User Profile API:

  Future<APIResponse<LogInModel>> getUserProfileAPI(Map data) async {
    String API = 'https://deliver.eigix.net/api/get_profile_fleet';
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

  /// Canceled Rides API:

  Future<APIResponse<List<InProgressRidesModel>>> canceledRidesAPI(Map data) {
    String api = 'https://deliver.eigix.net/api/get_bookings_cancelled_fleet';
    return http.post(Uri.parse(api), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonResult = jsonDecode(value.body);
        if (jsonResult['data'] != null) {
          final jsonResultArray = <InProgressRidesModel>[];
          for (var item in jsonResult['data']) {
            final jsonData = InProgressRidesModel.fromJson(item);
            jsonResultArray.add(jsonData);
          }

          return APIResponse<List<InProgressRidesModel>>(
            data: jsonResultArray,
            status: jsonResult['status'],
            message: jsonResult['message'],
          );
        } else {
          return APIResponse<List<InProgressRidesModel>>(
            data: [],
            status: jsonResult['status'],
            message: jsonResult['message'],
          );
        }
      }
      return APIResponse<List<InProgressRidesModel>>(
        status: APIResponse.fromMap(
          jsonDecode(value.body),
        ).status,
        message: APIResponse.fromMap(
          jsonDecode(value.body),
        ).message,
      );
    }).onError(
      (error, stackTrace) => APIResponse<List<InProgressRidesModel>>(
        status: error.toString(),
        message: stackTrace.toString(),
      ),
    );
  }

  /// Completed Rides API:

  Future<APIResponse<List<InProgressRidesModel>>> completedRidesAPI(Map data) {
    String api = 'https://deliver.eigix.net/api/get_bookings_completed_fleet';
    return http.post(Uri.parse(api), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonResult = jsonDecode(value.body);
        if (jsonResult['data'] != null) {
          final jsonResultArray = <InProgressRidesModel>[];
          for (var item in jsonResult['data']) {
            final jsonData = InProgressRidesModel.fromJson(item);
            jsonResultArray.add(jsonData);
          }

          return APIResponse<List<InProgressRidesModel>>(
            data: jsonResultArray,
            status: jsonResult['status'],
            message: jsonResult['message'],
          );
        } else {
          return APIResponse<List<InProgressRidesModel>>(
            data: [],
            status: jsonResult['status'],
            message: jsonResult['message'],
          );
        }
      }
      return APIResponse<List<InProgressRidesModel>>(
        status: APIResponse.fromMap(
          jsonDecode(value.body),
        ).status,
        message: APIResponse.fromMap(
          jsonDecode(value.body),
        ).message,
      );
    }).onError(
      (error, stackTrace) => APIResponse<List<InProgressRidesModel>>(
        status: error.toString(),
        message: stackTrace.toString(),
      ),
    );
  }

  /// Scheduled Rides API:

  Future<APIResponse<List<ScheduledRiderModel>>> scheduledRidesAPI(Map data) {
    String api = 'https://deliver.eigix.net/api/get_bookings_scheduled_fleet';
    return http.post(Uri.parse(api), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonResult = jsonDecode(value.body);
        if (jsonResult['data'] != null) {
          final jsonResultArray = <ScheduledRiderModel>[];
          for (var item in jsonResult['data']) {
            final jsonData = ScheduledRiderModel.fromJson(item);
            jsonResultArray.add(jsonData);
          }

          return APIResponse<List<ScheduledRiderModel>>(
            data: jsonResultArray,
            status: jsonResult['status'],
            message: jsonResult['message'],
          );
        } else {
          return APIResponse<List<ScheduledRiderModel>>(
            data: [],
            status: jsonResult['status'],
            message: jsonResult['message'],
          );
        }
      }
      return APIResponse<List<ScheduledRiderModel>>(
        status: APIResponse.fromMap(
          jsonDecode(value.body),
        ).status,
        message: APIResponse.fromMap(
          jsonDecode(value.body),
        ).message,
      );
    }).onError(
      (error, stackTrace) => APIResponse<List<ScheduledRiderModel>>(
        status: error.toString(),
        message: stackTrace.toString(),
      ),
    );
  }

  /// Get Bike Details API:

  Future<APIResponse<GetAllAvailableVehicles>> getVehicleDetailsForRiderAPI(
      Map data) async {
    String API = 'https://deliver.eigix.net/api/get_fleet_vehicle_as_rider';
    return http.post(Uri.parse(API), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonData = json.decode(value.body);

        if (jsonData['data'] != null) {
          final itemCat = GetAllAvailableVehicles.fromJson(jsonData['data']);
          return APIResponse<GetAllAvailableVehicles>(
              data: itemCat,
              status: jsonData['status'],
              message: jsonData['message']);
        } else {
          return APIResponse<GetAllAvailableVehicles>(
              data: GetAllAvailableVehicles(),
              status: jsonData['status'],
              message: jsonData['message']);
        }
      }
      return APIResponse<GetAllAvailableVehicles>(
        status: APIResponse.fromMap(json.decode(value.body)).status,
        message: APIResponse.fromMap(json.decode(value.body)).message,
      );
    }).onError((error, stackTrace) => APIResponse<GetAllAvailableVehicles>(
          status: error.toString(),
          message: stackTrace.toString(),
        ));
  }

  /// Update Profile API:

  Future<APIResponse<LogInModel>> updateUserProfileApi(Map data) async {
    String API = 'https://deliver.eigix.net/api/update_profile_fleet';
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

  /// Get ALL Notifications API:

  Future<APIResponse<List<GetAllNotificationsModel>>> getAllNotificationsAPI(
      Map data) {
    String api = 'https://deliver.eigix.net/api/all_notifications';
    return http.post(Uri.parse(api), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonResult = jsonDecode(value.body);
        if (jsonResult['data'] != null) {
          final jsonResultArray = <GetAllNotificationsModel>[];
          for (var item in jsonResult['data']) {
            final jsonData = GetAllNotificationsModel.fromJson(item);
            jsonResultArray.add(jsonData);
          }

          return APIResponse<List<GetAllNotificationsModel>>(
            data: jsonResultArray,
            status: jsonResult['status'],
            message: jsonResult['message'],
          );
        } else {
          return APIResponse<List<GetAllNotificationsModel>>(
            data: [],
            status: jsonResult['status'],
            message: jsonResult['message'],
          );
        }
      }
      return APIResponse<List<GetAllNotificationsModel>>(
        status: APIResponse.fromMap(
          jsonDecode(value.body),
        ).status,
        message: APIResponse.fromMap(
          jsonDecode(value.body),
        ).message,
      );
    }).onError(
      (error, stackTrace) => APIResponse<List<GetAllNotificationsModel>>(
        status: error.toString(),
        message: stackTrace.toString(),
      ),
    );
  }

  /// Read Notifications API:

  Future<APIResponse<List<ReadNotificationsModel>>> readNotificationsAPI(
      Map data) {
    String api = 'https://deliver.eigix.net/api/read_notifications';
    return http.post(Uri.parse(api), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonResult = jsonDecode(value.body);
        if (jsonResult['data'] != null) {
          final jsonResultArray = <ReadNotificationsModel>[];
          for (var item in jsonResult['data']) {
            final jsonData = ReadNotificationsModel.fromJson(item);
            jsonResultArray.add(jsonData);
          }

          return APIResponse<List<ReadNotificationsModel>>(
            data: jsonResultArray,
            status: jsonResult['status'],
            message: jsonResult['message'],
          );
        } else {
          return APIResponse<List<ReadNotificationsModel>>(
            data: [],
            status: jsonResult['status'],
            message: jsonResult['message'],
          );
        }
      }
      return APIResponse<List<ReadNotificationsModel>>(
        status: APIResponse.fromMap(
          jsonDecode(value.body),
        ).status,
        message: APIResponse.fromMap(
          jsonDecode(value.body),
        ).message,
      );
    }).onError(
      (error, stackTrace) => APIResponse<List<ReadNotificationsModel>>(
        status: error.toString(),
        message: stackTrace.toString(),
      ),
    );
  }

  /// get All riders API:

  Future<APIResponse<List<GetAllRidersModel>>> getAllRidersApi(Map data) {
    String api = 'https://deliver.eigix.net/api/get_riders_all';
    return http.post(Uri.parse(api), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonResult = jsonDecode(value.body);
        if (jsonResult['data'] != null) {
          final jsonResultArray = <GetAllRidersModel>[];
          for (var item in jsonResult['data']) {
            final jsonData = GetAllRidersModel.fromJson(item);
            jsonResultArray.add(jsonData);
          }

          return APIResponse<List<GetAllRidersModel>>(
            data: jsonResultArray,
            status: jsonResult['status'],
            message: jsonResult['message'],
          );
        } else {
          return APIResponse<List<GetAllRidersModel>>(
            data: [],
            status: jsonResult['status'],
            message: jsonResult['message'],
          );
        }
      }
      return APIResponse<List<GetAllRidersModel>>(
        status: APIResponse.fromMap(
          jsonDecode(value.body),
        ).status,
        message: APIResponse.fromMap(
          jsonDecode(value.body),
        ).message,
      );
    }).onError(
      (error, stackTrace) => APIResponse<List<GetAllRidersModel>>(
        status: error.toString(),
        message: stackTrace.toString(),
      ),
    );
  }

  /// Get ALL Support Messages API:

  Future<APIResponse<List<GetAllSupportMessagesModel>>> getAllSupportMessages(
      Map data) {
    String api = 'https://deliver.eigix.net/api/user_chat_live';
    return http.post(Uri.parse(api), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonResult = jsonDecode(value.body);
        if (jsonResult['data'] != null) {
          final jsonResultArray = <GetAllSupportMessagesModel>[];
          debugPrint("jsonResult ${jsonResult['data']}");
          for (var item in jsonResult['data']) {
            // final jsonData = GetAllSupportMessagesModel.fromJson(item);
            // jsonResultArray.add(jsonData);
            print("jsonResultArray $item");
          }

          // final jsonData = Signin_Signup_Model.fromMap(
          //   jsonResult['data'],
          // );
          return APIResponse<List<GetAllSupportMessagesModel>>(
            data: jsonResultArray,
            status: jsonResult['status'],
            message: jsonResult['message'],
          );
        } else {
          return APIResponse<List<GetAllSupportMessagesModel>>(
            data: [],
            status: jsonResult['status'],
            message: jsonResult['message'],
          );
        }
      }
      return APIResponse<List<GetAllSupportMessagesModel>>(
        status: APIResponse.fromMap(
          jsonDecode(value.body),
        ).status,
        message: APIResponse.fromMap(
          jsonDecode(value.body),
        ).message,
      );
    }).onError(
      (error, stackTrace) => APIResponse<List<GetAllSupportMessagesModel>>(
        status: error.toString(),
        message: stackTrace.toString(),
      ),
    );
  }

  ///Invite riders API:

  Future<APIResponse<APIResponse>> inviteRidersAPI(Map data) async {
    String API = 'https://deliver.eigix.net/api/invite_rider';
    return http.post(Uri.parse(API), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonData = json.decode(value.body);

        return APIResponse<APIResponse>(
            status: jsonData['status'], message: jsonData['message']);
      }
      return APIResponse<APIResponse>(
        status: APIResponse.fromMap(json.decode(value.body)).status,
        message: APIResponse.fromMap(json.decode(value.body)).message,
      );
    }).onError((error, stackTrace) => APIResponse<APIResponse>(
          status: error.toString(),
          message: stackTrace.toString(),
        ));
  }

  /// Start Chat API:

  Future<APIResponse<APIResponse>> startChatAPI(Map data) async {
    String API = 'https://deliver.eigix.net/api/user_chat_live';
    return http.post(Uri.parse(API), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonData = json.decode(value.body);

        return APIResponse<APIResponse>(
            status: jsonData['status'], message: jsonData['message']);
      }
      return APIResponse<APIResponse>(
        status: APIResponse.fromMap(json.decode(value.body)).status,
        message: APIResponse.fromMap(json.decode(value.body)).message,
      );
    }).onError((error, stackTrace) => APIResponse<APIResponse>(
          status: error.toString(),
          message: stackTrace.toString(),
        ));
  }

  /// Get Admin API:

  Future<APIResponse<List<SupportedUserModel>>> getAllAdminsAPI() {
    String api = 'https://deliver.eigix.net/api/get_admin_list';
    return http
        .get(
      Uri.parse(api),
    )
        .then((value) {
      if (value.statusCode == 200) {
        final jsonResult = jsonDecode(value.body);
        if (jsonResult['data'] != null) {
          final jsonResultArray = <SupportedUserModel>[];
          for (var item in jsonResult['data']) {
            final jsonData = SupportedUserModel.fromJson(item);
            jsonResultArray.add(jsonData);
          }

          // final jsonData = Signin_Signup_Model.fromMap(
          //   jsonResult['data'],
          // );
          return APIResponse<List<SupportedUserModel>>(
            data: jsonResultArray,
            status: jsonResult['status'],
            message: jsonResult['message'],
          );
        } else {
          return APIResponse<List<SupportedUserModel>>(
            data: [],
            status: jsonResult['status'],
            message: jsonResult['message'],
          );
        }
      }
      return APIResponse<List<SupportedUserModel>>(
        status: APIResponse.fromMap(
          jsonDecode(value.body),
        ).status,
        message: APIResponse.fromMap(
          jsonDecode(value.body),
        ).message,
      );
    }).onError(
      (error, stackTrace) => APIResponse<List<SupportedUserModel>>(
        status: error.toString(),
        message: stackTrace.toString(),
      ),
    );
  }

  /// Send Message API:

  Future<APIResponse<APIResponse>> sendMessageAPI(Map data) async {
    String API = 'https://deliver.eigix.net/api/user_chat_live';
    return http.post(Uri.parse(API), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonData = json.decode(value.body);

        return APIResponse<APIResponse>(
            status: jsonData['status'], message: jsonData['message']);
      }
      return APIResponse<APIResponse>(
        status: APIResponse.fromMap(json.decode(value.body)).status,
        message: APIResponse.fromMap(json.decode(value.body)).message,
      );
    }).onError((error, stackTrace) => APIResponse<APIResponse>(
          status: error.toString(),
          message: stackTrace.toString(),
        ));
  }

  /// Get ALL Client Requests API:

  Future<APIResponse<List<ShowBookingsModel>>> getAllClientRequestsAPI(
      Map data) {
    String api = 'https://deliver.eigix.net/api/get_requests_bookings';
    return http.post(Uri.parse(api), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonResult = jsonDecode(value.body);
        if (jsonResult['data'] != null) {
          final jsonResultArray = <ShowBookingsModel>[];
          for (var item in jsonResult['data']) {
            final jsonData = ShowBookingsModel.fromJson(item);
            jsonResultArray.add(jsonData);
          }

          return APIResponse<List<ShowBookingsModel>>(
            data: jsonResultArray,
            status: jsonResult['status'],
            message: jsonResult['message'],
          );
        } else {
          return APIResponse<List<ShowBookingsModel>>(
            data: [],
            status: jsonResult['status'],
            message: jsonResult['message'],
          );
        }
      }
      return APIResponse<List<ShowBookingsModel>>(
        status: APIResponse.fromMap(
          jsonDecode(value.body),
        ).status,
        message: APIResponse.fromMap(
          jsonDecode(value.body),
        ).message,
      );
    }).onError(
      (error, stackTrace) => APIResponse<List<ShowBookingsModel>>(
        status: error.toString(),
        message: stackTrace.toString(),
      ),
    );
  }

  /// Accept ride request API:

  Future<APIResponse<ShowBookingsModel>> acceptRideRequest(Map data) async {
    String API = 'https://deliver.eigix.net/api/accept_request_booking';
    return http.post(Uri.parse(API), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonData = json.decode(value.body);
        if (jsonData['data'] != null) {
          final itemCat = ShowBookingsModel.fromJson(jsonData['data']);
          return APIResponse<ShowBookingsModel>(
              data: itemCat,
              status: jsonData['status'],
              message: jsonData['message']);
        } else {
          return APIResponse<ShowBookingsModel>(
              data: ShowBookingsModel(),
              status: jsonData['status'],
              message: jsonData['message']);
        }
      }
      return APIResponse<ShowBookingsModel>(
        status: APIResponse.fromMap(json.decode(value.body)).status,
        message: APIResponse.fromMap(json.decode(value.body)).message,
      );
    }).onError((error, stackTrace) => APIResponse<ShowBookingsModel>(
          status: error.toString(),
          message: stackTrace.toString(),
        ));
  }

  /// start user to user chat API:

  Future<APIResponse<APIResponse>> startUserToUserChatAPI(Map data) async {
    String API = 'https://deliver.eigix.net/api/user_chat';
    return http.post(Uri.parse(API), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonData = json.decode(value.body);

        return APIResponse<APIResponse>(
            status: jsonData['status'], message: jsonData['message']);
      }
      return APIResponse<APIResponse>(
        status: APIResponse.fromMap(json.decode(value.body)).status,
        message: APIResponse.fromMap(json.decode(value.body)).message,
      );
    }).onError((error, stackTrace) => APIResponse<APIResponse>(
          status: error.toString(),
          message: stackTrace.toString(),
        ));
  }

  /// get user to user chat API:

  Future<APIResponse<List<GetAllUserToUserChatModel>>> getAllUserToUserChatAPI(
      Map data) {
    String api = 'https://deliver.eigix.net/api/user_chat';
    return http.post(Uri.parse(api), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonResult = jsonDecode(value.body);
        if (jsonResult['data'] != null) {
          final jsonResultArray = <GetAllUserToUserChatModel>[];
          for (var item in jsonResult['data']) {
            final jsonData = GetAllUserToUserChatModel.fromJson(item);
            jsonResultArray.add(jsonData);
          }

          return APIResponse<List<GetAllUserToUserChatModel>>(
            data: jsonResultArray,
            status: jsonResult['status'],
            message: jsonResult['message'],
          );
        } else {
          return APIResponse<List<GetAllUserToUserChatModel>>(
            data: [],
            status: jsonResult['status'],
            message: jsonResult['message'],
          );
        }
      }
      return APIResponse<List<GetAllUserToUserChatModel>>(
        status: APIResponse.fromMap(
          jsonDecode(value.body),
        ).status,
        message: APIResponse.fromMap(
          jsonDecode(value.body),
        ).message,
      );
    }).onError(
      (error, stackTrace) => APIResponse<List<GetAllUserToUserChatModel>>(
        status: error.toString(),
        message: stackTrace.toString(),
      ),
    );
  }

  /// send user to user chat api:

  Future<APIResponse<APIResponse>> sendUserToUserChatAPI(Map data) async {
    String API = 'https://deliver.eigix.net/api/user_chat';
    return http.post(Uri.parse(API), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonData = json.decode(value.body);

        return APIResponse<APIResponse>(
            status: jsonData['status'], message: jsonData['message']);
      }
      return APIResponse<APIResponse>(
        status: APIResponse.fromMap(json.decode(value.body)).status,
        message: APIResponse.fromMap(json.decode(value.body)).message,
      );
    }).onError((error, stackTrace) => APIResponse<APIResponse>(
          status: error.toString(),
          message: stackTrace.toString(),
        ));
  }

  /// Reject ride request API:

  Future<APIResponse<ShowBookingsModel>> rejectRideRequest(Map data) async {
    String API = 'https://deliver.eigix.net/api/reject_request_booking';
    return http.post(Uri.parse(API), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonData = json.decode(value.body);
        if (jsonData['data'] != null) {
          final itemCat = ShowBookingsModel.fromJson(jsonData['data']);
          return APIResponse<ShowBookingsModel>(
              data: itemCat,
              status: jsonData['status'],
              message: jsonData['message']);
        } else {
          return APIResponse<ShowBookingsModel>(
              data: ShowBookingsModel(),
              status: jsonData['status'],
              message: jsonData['message']);
        }
      }
      return APIResponse<ShowBookingsModel>(
        status: APIResponse.fromMap(json.decode(value.body)).status,
        message: APIResponse.fromMap(json.decode(value.body)).message,
      );
    }).onError((error, stackTrace) => APIResponse<ShowBookingsModel>(
          status: error.toString(),
          message: stackTrace.toString(),
        ));
  }

  /// parcel picked API:

  Future<APIResponse<ShowBookingsModel>> parcelPickedAPI(Map data) async {
    String API = 'https://deliver.eigix.net/api/start_booking_ride';
    return http.post(Uri.parse(API), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonData = json.decode(value.body);

        if (jsonData['data'] != null) {
          final itemCat = ShowBookingsModel.fromJson(jsonData['data']);

          return APIResponse<ShowBookingsModel>(
              data: itemCat,
              status: jsonData['status'],
              message: jsonData['message']);
        } else {
          return APIResponse<ShowBookingsModel>(
              data: ShowBookingsModel(),
              status: jsonData['status'],
              message: jsonData['message']);
        }
      }
      return APIResponse<ShowBookingsModel>(
        status: APIResponse.fromMap(json.decode(value.body)).status,
        message: APIResponse.fromMap(json.decode(value.body)).message,
      );
    }).onError((error, stackTrace) => APIResponse<ShowBookingsModel>(
          status: error.toString(),
          message: stackTrace.toString(),
        ));
  }

  /// Start ride request API:

  Future<APIResponse<ShowBookingsModel>> startRideRequest(Map data) async {
    String API = 'https://deliver.eigix.net/api/start_booking_ride';
    return http.post(Uri.parse(API), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonData = json.decode(value.body);

        if (jsonData['data'] != null) {
          final itemCat = ShowBookingsModel.fromJson(jsonData['data']);

          return APIResponse<ShowBookingsModel>(
              data: itemCat,
              status: jsonData['status'],
              message: jsonData['message']);
        } else {
          return APIResponse<ShowBookingsModel>(
              data: ShowBookingsModel(),
              status: jsonData['status'],
              message: jsonData['message']);
        }
      }
      return APIResponse<ShowBookingsModel>(
        status: APIResponse.fromMap(json.decode(value.body)).status,
        message: APIResponse.fromMap(json.decode(value.body)).message,
      );
    }).onError((error, stackTrace) => APIResponse<ShowBookingsModel>(
          status: error.toString(),
          message: stackTrace.toString(),
        ));
  }

  /// End ride request API:

  Future<APIResponse<ShowBookingsModel>> endRideRequest(Map data) async {
    String API = 'https://deliver.eigix.net/api/end_booking_ride';
    return http.post(Uri.parse(API), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonData = json.decode(value.body);

        if (jsonData['data'] != null) {
          final itemCat = ShowBookingsModel.fromJson(jsonData['data']);

          return APIResponse<ShowBookingsModel>(
              data: itemCat,
              status: jsonData['status'],
              message: jsonData['message']);
        } else {
          return APIResponse<ShowBookingsModel>(
              data: ShowBookingsModel(),
              status: jsonData['status'],
              message: jsonData['message']);
        }
      }
      return APIResponse<ShowBookingsModel>(
        status: APIResponse.fromMap(json.decode(value.body)).status,
        message: APIResponse.fromMap(json.decode(value.body)).message,
      );
    }).onError((error, stackTrace) => APIResponse<ShowBookingsModel>(
          status: error.toString(),
          message: stackTrace.toString(),
        ));
  }

  /// Get All Vehicles on Fleet API:

  Future<APIResponse<List<GetAllVehiclesFleetModel>>> getAllVehiclesFleetApi(
      Map data) {
    String api = 'https://deliver.eigix.net/api/get_fleet_vehicles_all';
    return http.post(Uri.parse(api), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonResult = jsonDecode(value.body);
        if (jsonResult['data'] != null) {
          final jsonResultArray = <GetAllVehiclesFleetModel>[];
          for (var item in jsonResult['data']) {
            final jsonData = GetAllVehiclesFleetModel.fromJson(item);
            jsonResultArray.add(jsonData);
          }

          // final jsonData = Signin_Signup_Model.fromMap(
          //   jsonResult['data'],
          // );
          return APIResponse<List<GetAllVehiclesFleetModel>>(
            data: jsonResultArray,
            status: jsonResult['status'],
            message: jsonResult['message'],
          );
        } else {
          return APIResponse<List<GetAllVehiclesFleetModel>>(
            data: [],
            status: jsonResult['status'],
            message: jsonResult['message'],
          );
        }
      }
      return APIResponse<List<GetAllVehiclesFleetModel>>(
        status: APIResponse.fromMap(
          jsonDecode(value.body),
        ).status,
        message: APIResponse.fromMap(
          jsonDecode(value.body),
        ).message,
      );
    }).onError(
      (error, stackTrace) => APIResponse<List<GetAllVehiclesFleetModel>>(
        status: error.toString(),
        message: stackTrace.toString(),
      ),
    );
  }

  /// Get All Available Vehicles on Fleet API:

  Future<APIResponse<List<GetAllAvailableVehicles>>> getAllAvailableVehiclesApi(
      Map data) {
    String api = 'https://deliver.eigix.net/api/get_fleet_vehicles_available';
    return http.post(Uri.parse(api), body: data).then((value) {
      if (value.statusCode == 200) {
        final jsonResult = jsonDecode(value.body);
        if (jsonResult['data'] != null) {
          final jsonResultArray = <GetAllAvailableVehicles>[];
          for (var item in jsonResult['data']) {
            final jsonData = GetAllAvailableVehicles.fromJson(item);
            jsonResultArray.add(jsonData);
          }

          // final jsonData = Signin_Signup_Model.fromMap(
          //   jsonResult['data'],
          // );
          return APIResponse<List<GetAllAvailableVehicles>>(
            data: jsonResultArray,
            status: jsonResult['status'],
            message: jsonResult['message'],
          );
        } else {
          return APIResponse<List<GetAllAvailableVehicles>>(
            data: [],
            status: jsonResult['status'],
            message: jsonResult['message'],
          );
        }
      }
      return APIResponse<List<GetAllAvailableVehicles>>(
        status: APIResponse.fromMap(
          jsonDecode(value.body),
        ).status,
        message: APIResponse.fromMap(
          jsonDecode(value.body),
        ).message,
      );
    }).onError(
      (error, stackTrace) => APIResponse<List<GetAllAvailableVehicles>>(
        status: error.toString(),
        message: stackTrace.toString(),
      ),
    );
  }
}
