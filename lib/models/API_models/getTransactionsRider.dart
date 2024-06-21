// To parse this JSON data, do
//
//     final getTransactionsRider = getTransactionsRiderFromJson(jsonString);

import 'dart:convert';

GetTransactionsRider getTransactionsRiderFromJson(String str) =>
    GetTransactionsRider.fromJson(json.decode(str));

String getTransactionsRiderToJson(GetTransactionsRider data) =>
    json.encode(data.toJson());

class GetTransactionsRider {
  String? status;
  List<Datum>? data;

  GetTransactionsRider({
    this.status,
    this.data,
  });

  factory GetTransactionsRider.fromJson(Map<String, dynamic> json) =>
      GetTransactionsRider(
        status: json["status"],
        data: json["data"] != null
            ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int transactionsId;
  String transactionType;
  dynamic usersCustomersId;
  int usersFleetId;
  dynamic parentId;
  int bookingsId;
  int bookingsDestinationsId;
  dynamic tokenId;
  String totalAmount;
  dynamic fleetShare;
  String adminShare;
  String grandTotal;
  String narration;
  DateTime dateAdded;
  dynamic dateModified;
  String status;
  UsersFleet usersFleet;
  Bookings bookings;

  Datum({
    required this.transactionsId,
    required this.transactionType,
    required this.usersCustomersId,
    required this.usersFleetId,
    required this.parentId,
    required this.bookingsId,
    required this.bookingsDestinationsId,
    required this.tokenId,
    required this.totalAmount,
    required this.fleetShare,
    required this.adminShare,
    required this.grandTotal,
    required this.narration,
    required this.dateAdded,
    required this.dateModified,
    required this.status,
    required this.usersFleet,
    required this.bookings,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        transactionsId: json["transactions_id"],
        transactionType: json["transaction_type"],
        usersCustomersId: json["users_customers_id"],
        usersFleetId: json["users_fleet_id"],
        parentId: json["parent_id"],
        bookingsId: json["bookings_id"],
        bookingsDestinationsId: json["bookings_destinations_id"],
        tokenId: json["token_id"],
        totalAmount: json["total_amount"],
        fleetShare: json["fleet_share"],
        adminShare: json["admin_share"],
        grandTotal: json["grand_total"],
        narration: json["narration"],
        dateAdded: DateTime.parse(json["date_added"]),
        dateModified: json["date_modified"],
        status: json["status"],
        usersFleet: UsersFleet.fromJson(json["users_fleet"]),
        bookings: Bookings.fromJson(json["bookings"]),
      );

  Map<String, dynamic> toJson() => {
        "transactions_id": transactionsId,
        "transaction_type": transactionType,
        "users_customers_id": usersCustomersId,
        "users_fleet_id": usersFleetId,
        "parent_id": parentId,
        "bookings_id": bookingsId,
        "bookings_destinations_id": bookingsDestinationsId,
        "token_id": tokenId,
        "total_amount": totalAmount,
        "fleet_share": fleetShare,
        "admin_share": adminShare,
        "grand_total": grandTotal,
        "narration": narration,
        "date_added": dateAdded.toIso8601String(),
        "date_modified": dateModified,
        "status": status,
        "users_fleet": usersFleet.toJson(),
        "bookings": bookings.toJson(),
      };
}

class Bookings {
  int? bookingsId;
  int? usersCustomersId;
  int? bookingsTypesId;
  String? deliveryType;
  String? scheduled;
  dynamic deliveryDate;
  dynamic deliveryTime;
  String? serviceRunning;
  String? totalDeliveryCharges;
  String? totalVatCharges;
  String? totalSvcRunningCharges;
  dynamic totalTollgateCharges;
  String? totalCharges;
  dynamic totalDiscount;
  dynamic totalDiscountedCharges;
  int? paymentGatewaysId;
  String? paymentBy;
  String? paymentStatus;
  int? bookingsCancellationsReasonsId;
  DateTime? dateAdded;
  DateTime? dateModified;
  String? status;
  UsersCustomers? usersCustomers;
  BookingsTypes? bookingsTypes;
  PaymentGateways? paymentGateways;
  BookingsDestinations? bookingsDestinations;

  Bookings({
    this.bookingsId,
    this.usersCustomersId,
    this.bookingsTypesId,
    this.deliveryType,
    this.scheduled,
    this.deliveryDate,
    this.deliveryTime,
    this.serviceRunning,
    this.totalDeliveryCharges,
    this.totalVatCharges,
    this.totalSvcRunningCharges,
    this.totalTollgateCharges,
    this.totalCharges,
    this.totalDiscount,
    this.totalDiscountedCharges,
    this.paymentGatewaysId,
    this.paymentBy,
    this.paymentStatus,
    this.bookingsCancellationsReasonsId,
    this.dateAdded,
    this.dateModified,
    this.status,
    this.usersCustomers,
    this.bookingsTypes,
    this.paymentGateways,
    this.bookingsDestinations,
  });

  factory Bookings.fromJson(Map<String, dynamic> json) => Bookings(
        bookingsId: json["bookings_id"],
        usersCustomersId: json["users_customers_id"],
        bookingsTypesId: json["bookings_types_id"],
        deliveryType: json["delivery_type"],
        scheduled: json["scheduled"],
        deliveryDate: json["delivery_date"],
        deliveryTime: json["delivery_time"],
        serviceRunning: json["service_running"],
        totalDeliveryCharges: json["total_delivery_charges"],
        totalVatCharges: json["total_vat_charges"],
        totalSvcRunningCharges: json["total_svc_running_charges"],
        totalTollgateCharges: json["total_tollgate_charges"],
        totalCharges: json["total_charges"],
        totalDiscount: json["total_discount"],
        totalDiscountedCharges: json["total_discounted_charges"],
        paymentGatewaysId: json["payment_gateways_id"],
        paymentBy: json["payment_by"],
        paymentStatus: json["payment_status"],
        bookingsCancellationsReasonsId:
            json["bookings_cancellations_reasons_id"],
        dateAdded: DateTime.parse(json["date_added"]),
        dateModified: DateTime.parse(json["date_modified"]),
        status: json["status"],
        usersCustomers: UsersCustomers.fromJson(json["users_customers"]),
        bookingsTypes: BookingsTypes.fromJson(json["bookings_types"]),
        paymentGateways: PaymentGateways.fromJson(json["payment_gateways"]),
        bookingsDestinations:
            BookingsDestinations.fromJson(json["bookings_destinations"]),
      );

  Map<String, dynamic> toJson() => {
        "bookings_id": bookingsId,
        "users_customers_id": usersCustomersId,
        "bookings_types_id": bookingsTypesId,
        "delivery_type": deliveryType,
        "scheduled": scheduled,
        "delivery_date": deliveryDate,
        "delivery_time": deliveryTime,
        "service_running": serviceRunning,
        "total_delivery_charges": totalDeliveryCharges,
        "total_vat_charges": totalVatCharges,
        "total_svc_running_charges": totalSvcRunningCharges,
        "total_tollgate_charges": totalTollgateCharges,
        "total_charges": totalCharges,
        "total_discount": totalDiscount,
        "total_discounted_charges": totalDiscountedCharges,
        "payment_gateways_id": paymentGatewaysId,
        "payment_by": paymentBy,
        "payment_status": paymentStatus,
        "bookings_cancellations_reasons_id": bookingsCancellationsReasonsId,
        "date_added": dateAdded!.toIso8601String(),
        "date_modified": dateModified!.toIso8601String(),
        "status": status,
        "users_customers": usersCustomers!.toJson(),
        "bookings_types": bookingsTypes!.toJson(),
        "payment_gateways": paymentGateways!.toJson(),
        "bookings_destinations": bookingsDestinations!.toJson(),
      };
}

class BookingsDestinations {
  int bookingsDestinationsId;
  int bookingsId;
  String pickupAddress;
  String pickupLatitude;
  String pickupLongitude;
  String destinAddress;
  String destinLatitude;
  String destinLongitude;
  String destinDistance;
  String destinTime;
  String destinDeliveryCharges;
  String destinVatCharges;
  String svcRunningCharges;
  String tollgateCharges;
  String destinTotalCharges;
  String destinDiscount;
  String destinDiscountedCharges;
  String paymentStatus;
  String receiverName;
  String receiverPhone;
  String passcode;
  int bookingsDestinationsStatusId;
  String? pickupTime;
  String? deliveredTime;

  BookingsDestinations({
    required this.bookingsDestinationsId,
    required this.bookingsId,
    required this.pickupAddress,
    required this.pickupLatitude,
    required this.pickupLongitude,
    required this.destinAddress,
    required this.destinLatitude,
    required this.destinLongitude,
    required this.destinDistance,
    required this.destinTime,
    required this.destinDeliveryCharges,
    required this.destinVatCharges,
    required this.svcRunningCharges,
    required this.tollgateCharges,
    required this.destinTotalCharges,
    required this.destinDiscount,
    required this.destinDiscountedCharges,
    required this.paymentStatus,
    required this.receiverName,
    required this.receiverPhone,
    required this.passcode,
    required this.bookingsDestinationsStatusId,
    this.pickupTime,
    this.deliveredTime,
  });

  factory BookingsDestinations.fromJson(Map<String, dynamic> json) =>
      BookingsDestinations(
        bookingsDestinationsId: json["bookings_destinations_id"],
        bookingsId: json["bookings_id"],
        pickupAddress: json["pickup_address"],
        pickupLatitude: json["pickup_latitude"],
        pickupLongitude: json["pickup_longitude"],
        destinAddress: json["destin_address"],
        destinLatitude: json["destin_latitude"],
        destinLongitude: json["destin_longitude"],
        destinDistance: json["destin_distance"],
        destinTime: json["destin_time"],
        destinDeliveryCharges: json["destin_delivery_charges"],
        destinVatCharges: json["destin_vat_charges"],
        svcRunningCharges: json["svc_running_charges"],
        tollgateCharges: json["tollgate_charges"],
        destinTotalCharges: json["destin_total_charges"],
        destinDiscount: json["destin_discount"],
        destinDiscountedCharges: json["destin_discounted_charges"],
        paymentStatus: json["payment_status"],
        receiverName: json["receiver_name"],
        receiverPhone: json["receiver_phone"],
        passcode: json["passcode"],
        bookingsDestinationsStatusId: json["bookings_destinations_status_id"],
        pickupTime: json["pickup_time"],
        deliveredTime: json["delivered_time"],
      );

  Map<String, dynamic> toJson() => {
        "bookings_destinations_id": bookingsDestinationsId,
        "bookings_id": bookingsId,
        "pickup_address": pickupAddress,
        "pickup_latitude": pickupLatitude,
        "pickup_longitude": pickupLongitude,
        "destin_address": destinAddress,
        "destin_latitude": destinLatitude,
        "destin_longitude": destinLongitude,
        "destin_distance": destinDistance,
        "destin_time": destinTime,
        "destin_delivery_charges": destinDeliveryCharges,
        "destin_vat_charges": destinVatCharges,
        "svc_running_charges": svcRunningCharges,
        "tollgate_charges": tollgateCharges,
        "destin_total_charges": destinTotalCharges,
        "destin_discount": destinDiscount,
        "destin_discounted_charges": destinDiscountedCharges,
        "payment_status": paymentStatus,
        "receiver_name": receiverName,
        "receiver_phone": receiverPhone,
        "passcode": passcode,
        "bookings_destinations_status_id": bookingsDestinationsStatusId,
        "pickup_time": pickupTime,
        "delivered_time": deliveredTime,
      };
}

class BookingsTypes {
  int bookingsTypesId;
  String name;
  String sameDay;
  DateTime dateAdded;
  dynamic dateModified;
  String status;

  BookingsTypes({
    required this.bookingsTypesId,
    required this.name,
    required this.sameDay,
    required this.dateAdded,
    required this.dateModified,
    required this.status,
  });

  factory BookingsTypes.fromJson(Map<String, dynamic> json) => BookingsTypes(
        bookingsTypesId: json["bookings_types_id"],
        name: json["name"],
        sameDay: json["same_day"],
        dateAdded: DateTime.parse(json["date_added"]),
        dateModified: json["date_modified"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "bookings_types_id": bookingsTypesId,
        "name": name,
        "same_day": sameDay,
        "date_added": dateAdded.toIso8601String(),
        "date_modified": dateModified,
        "status": status,
      };
}

class PaymentGateways {
  int paymentGatewaysId;
  String paymentType;
  String name;
  String status;

  PaymentGateways({
    required this.paymentGatewaysId,
    required this.paymentType,
    required this.name,
    required this.status,
  });

  factory PaymentGateways.fromJson(Map<String, dynamic> json) =>
      PaymentGateways(
        paymentGatewaysId: json["payment_gateways_id"],
        paymentType: json["payment_type"],
        name: json["name"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "payment_gateways_id": paymentGatewaysId,
        "payment_type": paymentType,
        "name": name,
        "status": status,
      };
}

class UsersCustomers {
  int usersCustomersId;
  String oneSignalId;
  String walletAmount;
  dynamic lastActivity;
  dynamic bookingsRatings;
  String firstName;
  String lastName;
  String phone;
  String email;
  dynamic password;
  String profilePic;
  String latitude;
  String longitude;
  dynamic googleAccessToken;
  String accountType;
  String socialAccountType;
  dynamic badgeVerified;
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

  UsersCustomers({
    required this.usersCustomersId,
    required this.oneSignalId,
    required this.walletAmount,
    required this.lastActivity,
    required this.bookingsRatings,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.password,
    required this.profilePic,
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

  factory UsersCustomers.fromJson(Map<String, dynamic> json) => UsersCustomers(
        usersCustomersId: json["users_customers_id"],
        oneSignalId: json["one_signal_id"],
        walletAmount: json["wallet_amount"],
        lastActivity: json["last_activity"],
        bookingsRatings: json["bookings_ratings"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        email: json["email"],
        password: json["password"],
        profilePic: json["profile_pic"],
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
        "users_customers_id": usersCustomersId,
        "one_signal_id": oneSignalId,
        "wallet_amount": walletAmount,
        "last_activity": lastActivity,
        "bookings_ratings": bookingsRatings,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "email": email,
        "password": password,
        "profile_pic": profilePic,
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

class UsersFleet {
  int usersFleetId;
  String oneSignalId;
  String userType;
  String walletAmount;
  String availability;
  String onlineStatus;
  dynamic lastActivity;
  String bookingsRatings;
  int parentId;
  String firstName;
  String lastName;
  String phone;
  String email;
  dynamic password;
  String profilePic;
  String address;
  String nationalIdentificationNo;
  String drivingLicenseNo;
  String drivingLicenseFrontImage;
  String drivingLicenseBackImage;
  dynamic cacCertificate;
  String latitude;
  String longitude;
  dynamic googleAccessToken;
  String accountType;
  String socialAccountType;
  String badgeVerified;
  String notifications;
  String messages;
  String updateProfile;
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

  UsersFleet({
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

  factory UsersFleet.fromJson(Map<String, dynamic> json) => UsersFleet(
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
