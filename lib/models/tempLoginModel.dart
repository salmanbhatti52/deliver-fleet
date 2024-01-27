// To parse this JSON data, do
//
//     final tempLoginModel = tempLoginModelFromJson(jsonString);

import 'dart:convert';

TempLoginModel tempLoginModelFromJson(String str) =>
    TempLoginModel.fromJson(json.decode(str));

String tempLoginModelToJson(TempLoginModel data) => json.encode(data.toJson());

class TempLoginModel {
  String? status;
  String? message;
  Data? data;

  TempLoginModel({
    this.status,
    this.message,
    this.data,
  });

  factory TempLoginModel.fromJson(Map<String, dynamic> json) => TempLoginModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  int usersFleetId;
  String oneSignalId;
  String userType;
  String walletAmount;
  dynamic availability;
  dynamic onlineStatus;
  dynamic lastActivity;
  String bookingsRatings;
  int parentId;
  String firstName;
  String lastName;
  String phone;
  String email;
  String password;
  dynamic profilePic;
  dynamic address;
  String nationalIdentificationNo;
  dynamic drivingLicenseNo;
  dynamic drivingLicenseFrontImage;
  dynamic drivingLicenseBackImage;
  dynamic cacCertificate;
  String latitude;
  String longitude;
  dynamic googleAccessToken;
  String accountType;
  String socialAccountType;
  String badgeVerified;
  String notifications;
  String messages;
  dynamic updateProfile;
  dynamic verifyEmailOtp;
  dynamic verifyEmailOtpCreatedAt;
  dynamic emailVerified;
  dynamic verifyPhoneOtp;
  dynamic verifyPhoneOtpCreatedAt;
  dynamic phoneVerified;
  dynamic forgotPwdOtp;
  dynamic forgotPwdOtpCreatedAt;
  DateTime dateAdded;
  DateTime dateModified;
  String status;

  Data({
    required this.usersFleetId,
    required this.oneSignalId,
    required this.userType,
    required this.walletAmount,
    required this.availability,
    required this.onlineStatus,
    required this.lastActivity,
    required this.bookingsRatings,
    required this.parentId,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.password,
    required this.profilePic,
    required this.address,
    required this.nationalIdentificationNo,
    required this.drivingLicenseNo,
    required this.drivingLicenseFrontImage,
    required this.drivingLicenseBackImage,
    required this.cacCertificate,
    required this.latitude,
    required this.longitude,
    required this.googleAccessToken,
    required this.accountType,
    required this.socialAccountType,
    required this.badgeVerified,
    required this.notifications,
    required this.messages,
    required this.updateProfile,
    required this.verifyEmailOtp,
    required this.verifyEmailOtpCreatedAt,
    required this.emailVerified,
    required this.verifyPhoneOtp,
    required this.verifyPhoneOtpCreatedAt,
    required this.phoneVerified,
    required this.forgotPwdOtp,
    required this.forgotPwdOtpCreatedAt,
    required this.dateAdded,
    required this.dateModified,
    required this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        usersFleetId: json["users_fleet_id"],
        oneSignalId: json["one_signal_id"],
        userType: json["user_type"],
        walletAmount: json["wallet_amount"],
        availability: json["availability"],
        onlineStatus: json["online_status"],
        lastActivity: json["last_activity"],
        bookingsRatings: json["bookings_ratings"],
        parentId: json["parent_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        email: json["email"],
        password: json["password"],
        profilePic: json["profile_pic"],
        address: json["address"],
        nationalIdentificationNo: json["national_identification_no"],
        drivingLicenseNo: json["driving_license_no"],
        drivingLicenseFrontImage: json["driving_license_front_image"],
        drivingLicenseBackImage: json["driving_license_back_image"],
        cacCertificate: json["cac_certificate"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        googleAccessToken: json["google_access_token"],
        accountType: json["account_type"],
        socialAccountType: json["social_account_type"],
        badgeVerified: json["badge_verified"],
        notifications: json["notifications"],
        messages: json["messages"],
        updateProfile: json["update_profile"],
        verifyEmailOtp: json["verify_email_otp"],
        verifyEmailOtpCreatedAt: json["verify_email_otp_created_at"],
        emailVerified: json["email_verified"],
        verifyPhoneOtp: json["verify_phone_otp"],
        verifyPhoneOtpCreatedAt: json["verify_phone_otp_created_at"],
        phoneVerified: json["phone_verified"],
        forgotPwdOtp: json["forgot_pwd_otp"],
        forgotPwdOtpCreatedAt: json["forgot_pwd_otp_created_at"],
        dateAdded: DateTime.parse(json["date_added"]),
        dateModified: DateTime.parse(json["date_modified"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "users_fleet_id": usersFleetId,
        "one_signal_id": oneSignalId,
        "user_type": userType,
        "wallet_amount": walletAmount,
        "availability": availability,
        "online_status": onlineStatus,
        "last_activity": lastActivity,
        "bookings_ratings": bookingsRatings,
        "parent_id": parentId,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "email": email,
        "password": password,
        "profile_pic": profilePic,
        "address": address,
        "national_identification_no": nationalIdentificationNo,
        "driving_license_no": drivingLicenseNo,
        "driving_license_front_image": drivingLicenseFrontImage,
        "driving_license_back_image": drivingLicenseBackImage,
        "cac_certificate": cacCertificate,
        "latitude": latitude,
        "longitude": longitude,
        "google_access_token": googleAccessToken,
        "account_type": accountType,
        "social_account_type": socialAccountType,
        "badge_verified": badgeVerified,
        "notifications": notifications,
        "messages": messages,
        "update_profile": updateProfile,
        "verify_email_otp": verifyEmailOtp,
        "verify_email_otp_created_at": verifyEmailOtpCreatedAt,
        "email_verified": emailVerified,
        "verify_phone_otp": verifyPhoneOtp,
        "verify_phone_otp_created_at": verifyPhoneOtpCreatedAt,
        "phone_verified": phoneVerified,
        "forgot_pwd_otp": forgotPwdOtp,
        "forgot_pwd_otp_created_at": forgotPwdOtpCreatedAt,
        "date_added": dateAdded.toIso8601String(),
        "date_modified": dateModified.toIso8601String(),
        "status": status,
      };
}
