// To parse this JSON data, do
//
//     final getOnGoingRides = getOnGoingRidesFromJson(jsonString);

import 'dart:convert';

GetOnGoingRides getOnGoingRidesFromJson(String str) =>
    GetOnGoingRides.fromJson(json.decode(str));

String getOnGoingRidesToJson(GetOnGoingRides data) =>
    json.encode(data.toJson());

class GetOnGoingRides {
  String? status;
  List<Datum>? data;

  GetOnGoingRides({
    this.status,
    this.data,
  });

  factory GetOnGoingRides.fromJson(Map<String, dynamic> json) =>
      GetOnGoingRides(
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
  int bookingsFleetId;
  int bookingsId;
  int bookingsDestinationsId;
  int usersFleetId;
  int vehiclesId;
  int bookingsCancellationsReasonsId;
  int parcelHandshakeReasonsId;
  String fleetAmount;
  String? dateAdded;
  String? dateModified;
  String status;
  Bookings bookings;
  UsersFleetVehicles usersFleetVehicles;
  UsersFleet usersFleet;

  Datum({
    required this.bookingsFleetId,
    required this.bookingsId,
    required this.bookingsDestinationsId,
    required this.usersFleetId,
    required this.vehiclesId,
    required this.bookingsCancellationsReasonsId,
    required this.parcelHandshakeReasonsId,
    required this.fleetAmount,
    required this.dateAdded,
    this.dateModified,
    required this.status,
    required this.bookings,
    required this.usersFleetVehicles,
    required this.usersFleet,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        bookingsFleetId: json["bookings_fleet_id"],
        bookingsId: json["bookings_id"],
        bookingsDestinationsId: json["bookings_destinations_id"],
        usersFleetId: json["users_fleet_id"],
        vehiclesId: json["vehicles_id"],
        bookingsCancellationsReasonsId:
            json["bookings_cancellations_reasons_id"],
        parcelHandshakeReasonsId: json["parcel_handshake_reasons_id"],
        fleetAmount: json["fleet_amount"],
        dateAdded: json["date_added"],
        dateModified: json["date_modified"],
        status: json["status"],
        bookings: Bookings.fromJson(json["bookings"]),
        usersFleetVehicles:
            UsersFleetVehicles.fromJson(json["users_fleet_vehicles"]),
        usersFleet: UsersFleet.fromJson(json["users_fleet"]),
      );

  Map<String, dynamic> toJson() => {
        "bookings_fleet_id": bookingsFleetId,
        "bookings_id": bookingsId,
        "bookings_destinations_id": bookingsDestinationsId,
        "users_fleet_id": usersFleetId,
        "vehicles_id": vehiclesId,
        "bookings_cancellations_reasons_id": bookingsCancellationsReasonsId,
        "parcel_handshake_reasons_id": parcelHandshakeReasonsId,
        "fleet_amount": fleetAmount,
        "date_added": dateAdded,
        "date_modified": dateModified,
        "status": status,
        "bookings": bookings.toJson(),
        "users_fleet_vehicles": usersFleetVehicles.toJson(),
        "users_fleet": usersFleet.toJson(),
      };
}

class Bookings {
  int bookingsId;
  int usersCustomersId;
  int bookingsTypesId;
  String deliveryType;
  String scheduled;
  dynamic deliveryDate;
  dynamic deliveryTime;
  String totalDeliveryCharges;
  String totalVatCharges;
  String totalCharges;
  String totalDiscount;
  String totalDiscountedCharges;
  int paymentGatewaysId;
  String paymentBy;
  String paymentStatus;
  DateTime dateAdded;
  DateTime dateModified;
  String status;
  BookingsTypes bookingsTypes;
  PaymentGateways paymentGateways;
  UsersCustomers usersCustomers;
  List<BookingsDestination> bookingsDestinations;

  Bookings({
    required this.bookingsId,
    required this.usersCustomersId,
    required this.bookingsTypesId,
    required this.deliveryType,
    required this.scheduled,
    required this.deliveryDate,
    required this.deliveryTime,
    required this.totalDeliveryCharges,
    required this.totalVatCharges,
    required this.totalCharges,
    required this.totalDiscount,
    required this.totalDiscountedCharges,
    required this.paymentGatewaysId,
    required this.paymentBy,
    required this.paymentStatus,
    required this.dateAdded,
    required this.dateModified,
    required this.status,
    required this.bookingsTypes,
    required this.paymentGateways,
    required this.usersCustomers,
    required this.bookingsDestinations,
  });

  factory Bookings.fromJson(Map<String, dynamic> json) => Bookings(
        bookingsId: json["bookings_id"],
        usersCustomersId: json["users_customers_id"],
        bookingsTypesId: json["bookings_types_id"],
        deliveryType: json["delivery_type"],
        scheduled: json["scheduled"],
        deliveryDate: json["delivery_date"],
        deliveryTime: json["delivery_time"],
        totalDeliveryCharges: json["total_delivery_charges"],
        totalVatCharges: json["total_vat_charges"],
        totalCharges: json["total_charges"],
        totalDiscount: json["total_discount"] ?? "0",
        totalDiscountedCharges: json["total_discounted_charges"] ?? "0",
        paymentGatewaysId: json["payment_gateways_id"],
        paymentBy: json["payment_by"],
        paymentStatus: json["payment_status"],
        dateAdded: DateTime.parse(json["date_added"]),
        dateModified: DateTime.parse(json["date_modified"]),
        status: json["status"],
        bookingsTypes: BookingsTypes.fromJson(json["bookings_types"]),
        paymentGateways: PaymentGateways.fromJson(json["payment_gateways"]),
        usersCustomers: UsersCustomers.fromJson(json["users_customers"]),
        bookingsDestinations: List<BookingsDestination>.from(
            json["bookings_destinations"]
                .map((x) => BookingsDestination.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bookings_id": bookingsId,
        "users_customers_id": usersCustomersId,
        "bookings_types_id": bookingsTypesId,
        "delivery_type": deliveryType,
        "scheduled": scheduled,
        "delivery_date": deliveryDate,
        "delivery_time": deliveryTime,
        "total_delivery_charges": totalDeliveryCharges,
        "total_vat_charges": totalVatCharges,
        "total_charges": totalCharges,
        "total_discount": totalDiscount,
        "total_discounted_charges": totalDiscountedCharges,
        "payment_gateways_id": paymentGatewaysId,
        "payment_by": paymentBy,
        "payment_status": paymentStatus,
        "date_added": dateAdded.toIso8601String(),
        "date_modified": dateModified.toIso8601String(),
        "status": status,
        "bookings_types": bookingsTypes.toJson(),
        "payment_gateways": paymentGateways.toJson(),
        "users_customers": usersCustomers.toJson(),
        "bookings_destinations":
            List<dynamic>.from(bookingsDestinations.map((x) => x.toJson())),
      };
}

class BookingsDestination {
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
  String destinTotalCharges;
  String destinDiscount;
  String destinDiscountedCharges;
  String receiverName;
  String receiverPhone;
  String passcode;
  int bookingsDestinationsStatusId;
  ServiceTypes bookingsDestinationsStatus;

  BookingsDestination({
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
    required this.destinTotalCharges,
    required this.destinDiscount,
    required this.destinDiscountedCharges,
    required this.receiverName,
    required this.receiverPhone,
    required this.passcode,
    required this.bookingsDestinationsStatusId,
    required this.bookingsDestinationsStatus,
  });

  factory BookingsDestination.fromJson(Map<String, dynamic> json) =>
      BookingsDestination(
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
        destinTotalCharges: json["destin_total_charges"],
        destinDiscount: json["destin_discount"] ?? "",
        destinDiscountedCharges: json["destin_discounted_charges"] ?? "",
        receiverName: json["receiver_name"],
        receiverPhone: json["receiver_phone"],
        passcode: json["passcode"],
        bookingsDestinationsStatusId: json["bookings_destinations_status_id"],
        bookingsDestinationsStatus:
            ServiceTypes.fromJson(json["bookings_destinations_status"]),
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
        "destin_total_charges": destinTotalCharges,
        "destin_discount": destinDiscount,
        "destin_discounted_charges": destinDiscountedCharges,
        "receiver_name": receiverName,
        "receiver_phone": receiverPhone,
        "passcode": passcode,
        "bookings_destinations_status_id": bookingsDestinationsStatusId,
        "bookings_destinations_status": bookingsDestinationsStatus.toJson(),
      };
}

class ServiceTypes {
  int? bookingsDestinationsStatusId;
  String name;
  String dateAdded;
  dynamic dateModified;
  String status;
  int? serviceTypesId;

  ServiceTypes({
    this.bookingsDestinationsStatusId,
    required this.name,
    required this.dateAdded,
    required this.dateModified,
    required this.status,
    this.serviceTypesId,
  });

  factory ServiceTypes.fromJson(Map<String, dynamic> json) => ServiceTypes(
        bookingsDestinationsStatusId: json["bookings_destinations_status_id"],
        name: json["name"],
        dateAdded: json["date_added"],
        dateModified: json["date_modified"],
        status: json["status"],
        serviceTypesId: json["service_types_id"],
      );

  Map<String, dynamic> toJson() => {
        "bookings_destinations_status_id": bookingsDestinationsStatusId,
        "name": name,
        "date_added": dateAdded,
        "date_modified": dateModified,
        "status": status,
        "service_types_id": serviceTypesId,
      };
}

class BookingsTypes {
  int bookingsTypesId;
  String name;
  String sameDay;
  String dateAdded;
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
        dateAdded: json["date_added"],
        dateModified: json["date_modified"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "bookings_types_id": bookingsTypesId,
        "name": name,
        "same_day": sameDay,
        "date_added": dateAdded,
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
  dynamic dateModified;
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
        dateModified: json["date_modified"],
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
        "date_modified": dateModified,
        "status": status,
      };
}

class UsersFleet {
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
  DateTime? dateAdded;
  DateTime? dateModified;
  String? status;

  UsersFleet({
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
        "date_added": dateAdded!.toIso8601String(),
        "date_modified": dateModified!.toIso8601String(),
        "status": status,
      };
}

class UsersFleetVehicles {
  int usersFleetVehiclesId;
  int usersFleetId;
  int vehiclesId;
  String model;
  String color;
  String vehicleRegistrationNo;
  String vehicleIdentificationNo;
  DateTime vehicleLicenseExpiryDate;
  DateTime vehicleInsuranceExpiryDate;
  DateTime rwcExpiryDate;
  dynamic cost;
  String manufactureYear;
  String image;
  DateTime dateAdded;
  dynamic dateModified;
  String status;
  Vehicles vehicles;

  UsersFleetVehicles({
    required this.usersFleetVehiclesId,
    required this.usersFleetId,
    required this.vehiclesId,
    required this.model,
    required this.color,
    required this.vehicleRegistrationNo,
    required this.vehicleIdentificationNo,
    required this.vehicleLicenseExpiryDate,
    required this.vehicleInsuranceExpiryDate,
    required this.rwcExpiryDate,
    required this.cost,
    required this.manufactureYear,
    required this.image,
    required this.dateAdded,
    required this.dateModified,
    required this.status,
    required this.vehicles,
  });

  factory UsersFleetVehicles.fromJson(Map<String, dynamic> json) =>
      UsersFleetVehicles(
        usersFleetVehiclesId: json["users_fleet_vehicles_id"],
        usersFleetId: json["users_fleet_id"],
        vehiclesId: json["vehicles_id"],
        model: json["model"],
        color: json["color"],
        vehicleRegistrationNo: json["vehicle_registration_no"],
        vehicleIdentificationNo: json["vehicle_identification_no"],
        vehicleLicenseExpiryDate:
            DateTime.parse(json["vehicle_license_expiry_date"]),
        vehicleInsuranceExpiryDate:
            DateTime.parse(json["vehicle_insurance_expiry_date"]),
        rwcExpiryDate: DateTime.parse(json["rwc_expiry_date"]),
        cost: json["cost"],
        manufactureYear: json["manufacture_year"],
        image: json["image"],
        dateAdded: DateTime.parse(json["date_added"]),
        dateModified: json["date_modified"],
        status: json["status"],
        vehicles: Vehicles.fromJson(json["vehicles"]),
      );

  Map<String, dynamic> toJson() => {
        "users_fleet_vehicles_id": usersFleetVehiclesId,
        "users_fleet_id": usersFleetId,
        "vehicles_id": vehiclesId,
        "model": model,
        "color": color,
        "vehicle_registration_no": vehicleRegistrationNo,
        "vehicle_identification_no": vehicleIdentificationNo,
        "vehicle_license_expiry_date":
            "${vehicleLicenseExpiryDate.year.toString().padLeft(4, '0')}-${vehicleLicenseExpiryDate.month.toString().padLeft(2, '0')}-${vehicleLicenseExpiryDate.day.toString().padLeft(2, '0')}",
        "vehicle_insurance_expiry_date":
            "${vehicleInsuranceExpiryDate.year.toString().padLeft(4, '0')}-${vehicleInsuranceExpiryDate.month.toString().padLeft(2, '0')}-${vehicleInsuranceExpiryDate.day.toString().padLeft(2, '0')}",
        "rwc_expiry_date":
            "${rwcExpiryDate.year.toString().padLeft(4, '0')}-${rwcExpiryDate.month.toString().padLeft(2, '0')}-${rwcExpiryDate.day.toString().padLeft(2, '0')}",
        "cost": cost,
        "manufacture_year": manufactureYear,
        "image": image,
        "date_added": dateAdded.toIso8601String(),
        "date_modified": dateModified,
        "status": status,
        "vehicles": vehicles.toJson(),
      };
}

class Vehicles {
  int vehiclesId;
  int serviceTypesId;
  String name;
  String weightAllowed;
  String numberOfParcels;
  String amount;
  String tollgateAmount;
  String cancellationAmount;
  DateTime dateAdded;
  DateTime dateModified;
  String status;
  ServiceTypes serviceTypes;

  Vehicles({
    required this.vehiclesId,
    required this.serviceTypesId,
    required this.name,
    required this.weightAllowed,
    required this.numberOfParcels,
    required this.amount,
    required this.tollgateAmount,
    required this.cancellationAmount,
    required this.dateAdded,
    required this.dateModified,
    required this.status,
    required this.serviceTypes,
  });

  factory Vehicles.fromJson(Map<String, dynamic> json) => Vehicles(
        vehiclesId: json["vehicles_id"],
        serviceTypesId: json["service_types_id"],
        name: json["name"],
        weightAllowed: json["weight_allowed"],
        numberOfParcels: json["number_of_parcels"],
        amount: json["amount"],
        tollgateAmount: json["tollgate_amount"],
        cancellationAmount: json["cancellation_amount"],
        dateAdded: DateTime.parse(json["date_added"]),
        dateModified: DateTime.parse(json["date_modified"]),
        status: json["status"],
        serviceTypes: ServiceTypes.fromJson(json["service_types"]),
      );

  Map<String, dynamic> toJson() => {
        "vehicles_id": vehiclesId,
        "service_types_id": serviceTypesId,
        "name": name,
        "weight_allowed": weightAllowed,
        "number_of_parcels": numberOfParcels,
        "amount": amount,
        "tollgate_amount": tollgateAmount,
        "cancellation_amount": cancellationAmount,
        "date_added": dateAdded.toIso8601String(),
        "date_modified": dateModified.toIso8601String(),
        "status": status,
        "service_types": serviceTypes.toJson(),
      };
}
