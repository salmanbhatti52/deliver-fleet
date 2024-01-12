// To parse this JSON data, do
//
//     final getSupportChatModel = getSupportChatModelFromJson(jsonString);

import 'dart:convert';

GetSupportChatModel getSupportChatModelFromJson(String str) => GetSupportChatModel.fromJson(json.decode(str));

String getSupportChatModelToJson(GetSupportChatModel data) => json.encode(data.toJson());

class GetSupportChatModel {
  String? status;
  List<Datum>? data;

  GetSupportChatModel({
    this.status,
    this.data,
  });

  factory GetSupportChatModel.fromJson(Map<String, dynamic> json) => GetSupportChatModel(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? chatMessagesLiveId;
  String? senderType;
  String? receiverType;
  int? senderId;
  int? receiverId;
  String? messageType;
  String? message;
  String? sendDate;
  String? sendTime;
  String? dateAdded;
  dynamic dateRead;
  String? status;
  SenderData? senderData;
  ReceiverData? receiverData;

  Datum({
    this.chatMessagesLiveId,
    this.senderType,
    this.receiverType,
    this.senderId,
    this.receiverId,
    this.messageType,
    this.message,
    this.sendDate,
    this.sendTime,
    this.dateAdded,
    this.dateRead,
    this.status,
    this.senderData,
    this.receiverData,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    chatMessagesLiveId: json["chat_messages_live_id"],
    senderType: json["sender_type"],
    receiverType: json["receiver_type"],
    senderId: json["sender_id"],
    receiverId: json["receiver_id"],
    messageType: json["message_type"],
    message: json["message"],
    sendDate: json["send_date"],
    sendTime: json["send_time"],
    dateAdded: json["date_added"],
    dateRead: json["date_read"],
    status: json["status"],
    senderData: SenderData.fromJson(json["sender_data"]),
    receiverData: ReceiverData.fromJson(json["receiver_data"]),
  );

  Map<String, dynamic> toJson() => {
    "chat_messages_live_id": chatMessagesLiveId,
    "sender_type": senderType,
    "receiver_type": receiverType,
    "sender_id": senderId,
    "receiver_id": receiverId,
    "message_type": messageType,
    "message": message,
    "send_date": sendDate,
    "send_time": sendTime,
    "date_added": dateAdded,
    "date_read": dateRead,
    "status": status,
    "sender_data": senderData?.toJson(),
    "receiver_data": receiverData?.toJson(),
  };
}

class ReceiverData {
  int? usersSystemId;
  int? usersSystemRolesId;
  String? firstName;
  String? email;
  String? password;
  String? mobile;
  String? city;
  String? address;
  String? userImage;
  String? isDeleted;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  String? status;

  ReceiverData({
    this.usersSystemId,
    this.usersSystemRolesId,
    this.firstName,
    this.email,
    this.password,
    this.mobile,
    this.city,
    this.address,
    this.userImage,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.status,
  });

  factory ReceiverData.fromJson(Map<String, dynamic> json) => ReceiverData(
    usersSystemId: json["users_system_id"],
    usersSystemRolesId: json["users_system_roles_id"],
    firstName: json["first_name"],
    email: json["email"],
    password: json["password"],
    mobile: json["mobile"],
    city: json["city"],
    address: json["address"],
    userImage: json["user_image"],
    isDeleted: json["is_deleted"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "users_system_id": usersSystemId,
    "users_system_roles_id": usersSystemRolesId,
    "first_name": firstName,
    "email": email,
    "password": password,
    "mobile": mobile,
    "city": city,
    "address": address,
    "user_image": userImage,
    "is_deleted": isDeleted,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "status": status,
  };
}

class SenderData {
  int? usersFleetId;
  String? oneSignalId;
  String? userType;
  String? walletAmount;
  String? availability;
  String? onlineStatus;
  dynamic lastActivity;
  String? bookingsRatings;
  int? parentId;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  dynamic password;
  String? profilePic;
  String? address;
  String? nationalIdentificationNo;
  String? drivingLicenseNo;
  String? drivingLicenseFrontImage;
  String? drivingLicenseBackImage;
  dynamic cacCertificate;
  String? latitude;
  String? longitude;
  dynamic googleAccessToken;
  String? accountType;
  String? socialAccountType;
  String? badgeVerified;
  String? notifications;
  String? messages;
  String? updateProfile;
  dynamic verifyEmailOtp;
  dynamic verifyEmailOtpCreatedAt;
  dynamic emailVerified;
  dynamic verifyPhoneOtp;
  dynamic verifyPhoneOtpCreatedAt;
  dynamic phoneVerified;
  dynamic forgotPwdOtp;
  dynamic forgotPwdOtpCreatedAt;
  String? dateAdded;
  String? dateModified;
  String? status;

  SenderData({
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

  factory SenderData.fromJson(Map<String, dynamic> json) => SenderData(
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
    dateAdded: json["date_added"],
    dateModified: json["date_modified"],
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
    "date_added": dateAdded,
    "date_modified": dateModified,
    "status": status,
  };
}
