// To parse this JSON data, do
//
//     final checkPhoneNumberModel = checkPhoneNumberModelFromJson(jsonString);

import 'dart:convert';

CheckPhoneNumberModel checkPhoneNumberModelFromJson(String str) => CheckPhoneNumberModel.fromJson(json.decode(str));

String checkPhoneNumberModelToJson(CheckPhoneNumberModel data) => json.encode(data.toJson());

class CheckPhoneNumberModel {
  String? status;
  String? message;
  Data? data;

  CheckPhoneNumberModel({
    this.status,
    this.message,
    this.data,
  });

  factory CheckPhoneNumberModel.fromJson(Map<String, dynamic> json) => CheckPhoneNumberModel(
    status: json["status"],
    message : json["message"] != null ? json["message"] : null,
    data:json["data"] != null ? Data.fromJson(json["data"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data!.toJson(),
  };
}

class Data {
  int? usersFleetId;
  String? oneSignalId;
  String? userType;
  String? walletAmount;
  dynamic availability;
  dynamic onlineStatus;
  dynamic lastActivity;
  String? bookingsRatings;
  int?   parentId;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  dynamic password;
  dynamic profilePic;
  dynamic address;
  String? nationalIdentificationNo;
  dynamic drivingLicenseNo;
  dynamic drivingLicenseFrontImage;
  dynamic drivingLicenseBackImage;
  dynamic cacCertificate;
  String? latitude;
  String? longitude;
  dynamic googleAccessToken;
  String? accountType;
  String? socialAccountType;
  String? badgeVerified;
  String? notifications;
  String? messages;
  dynamic updateProfile;
  dynamic verifyEmailOtp;
  dynamic verifyEmailOtpCreatedAt;
  dynamic emailVerified;
  dynamic verifyPhoneOtp;
  dynamic verifyPhoneOtpCreatedAt;
  dynamic phoneVerified;
  dynamic forgotPwdOtp;
  dynamic forgotPwdOtpCreatedAt;
  DateTime? dateAdded;
  DateTime? dateModified;
  String? status;

  Data({
    this.usersFleetId,
    this.oneSignalId,
    this.userType,
    this.walletAmount,
    this.availability,
    this.onlineStatus,
    this.lastActivity,
    this.bookingsRatings,
    this.parentId,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.password,
    this.profilePic,
    this.address,
    this.nationalIdentificationNo,
    this.drivingLicenseNo,
    this.drivingLicenseFrontImage,
    this.drivingLicenseBackImage,
    this.cacCertificate,
    this.latitude,
    this.longitude,
    this.googleAccessToken,
    this.accountType,
    this.socialAccountType,
    this.badgeVerified,
    this.notifications,
    this.messages,
    this.updateProfile,
    this.verifyEmailOtp,
    this.verifyEmailOtpCreatedAt,
    this.emailVerified,
    this.verifyPhoneOtp,
    this.verifyPhoneOtpCreatedAt,
    this.phoneVerified,
    this.forgotPwdOtp,
    this.forgotPwdOtpCreatedAt,
    this.dateAdded,
    this.dateModified,
    this.status,
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
    "date_added": dateAdded!.toIso8601String(),
    "date_modified": dateModified!.toIso8601String(),
    "status": status,
  };
}
