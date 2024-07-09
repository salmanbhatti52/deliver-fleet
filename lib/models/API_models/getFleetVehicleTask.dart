// To parse this JSON data, do
//
//     final fleetTaskUpcomingModel = fleetTaskUpcomingModelFromJson(jsonString);

import 'dart:convert';

FleetTaskUpcomingModel fleetTaskUpcomingModelFromJson(String str) => FleetTaskUpcomingModel.fromJson(json.decode(str));

String fleetTaskUpcomingModelToJson(FleetTaskUpcomingModel data) => json.encode(data.toJson());

class FleetTaskUpcomingModel {
    String? status;
    List<Datum>? data;

    FleetTaskUpcomingModel({
         this.status,
         this.data,
    });

    factory FleetTaskUpcomingModel.fromJson(Map<String, dynamic> json) => FleetTaskUpcomingModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int usersFleetVehiclesTasksId;
    int usersFleetVehiclesId;
    int usersFleetId;
    String name;
    String description;
    DateTime taskDate;
    dynamic companyName;
    dynamic location;
    dynamic totalAmount;
    dynamic invoice;
    DateTime dateAdded;
    dynamic dateModified;
    String status;
    UsersFleetVehicles usersFleetVehicles;
    UsersFleet usersFleet;

    Datum({
        required this.usersFleetVehiclesTasksId,
        required this.usersFleetVehiclesId,
        required this.usersFleetId,
        required this.name,
        required this.description,
        required this.taskDate,
        required this.companyName,
        required this.location,
        required this.totalAmount,
        required this.invoice,
        required this.dateAdded,
        required this.dateModified,
        required this.status,
        required this.usersFleetVehicles,
        required this.usersFleet,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        usersFleetVehiclesTasksId: json["users_fleet_vehicles_tasks_id"],
        usersFleetVehiclesId: json["users_fleet_vehicles_id"],
        usersFleetId: json["users_fleet_id"],
        name: json["name"],
        description: json["description"],
        taskDate: DateTime.parse(json["task_date"]),
        companyName: json["company_name"],
        location: json["location"],
        totalAmount: json["total_amount"],
        invoice: json["invoice"],
        dateAdded: DateTime.parse(json["date_added"]),
        dateModified: json["date_modified"],
        status: json["status"],
        usersFleetVehicles: UsersFleetVehicles.fromJson(json["users_fleet_vehicles"]),
        usersFleet: UsersFleet.fromJson(json["users_fleet"]),
    );

    Map<String, dynamic> toJson() => {
        "users_fleet_vehicles_tasks_id": usersFleetVehiclesTasksId,
        "users_fleet_vehicles_id": usersFleetVehiclesId,
        "users_fleet_id": usersFleetId,
        "name": name,
        "description": description,
        "task_date": "${taskDate.year.toString().padLeft(4, '0')}-${taskDate.month.toString().padLeft(2, '0')}-${taskDate.day.toString().padLeft(2, '0')}",
        "company_name": companyName,
        "location": location,
        "total_amount": totalAmount,
        "invoice": invoice,
        "date_added": dateAdded.toIso8601String(),
        "date_modified": dateModified,
        "status": status,
        "users_fleet_vehicles": usersFleetVehicles.toJson(),
        "users_fleet": usersFleet.toJson(),
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
    String userTypeSwitched;
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
        required this.userTypeSwitched,
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
        userTypeSwitched: json["user_type_switched"],
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
        "user_type_switched": userTypeSwitched,
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
    UsersFleet usersFleet;
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
        required this.usersFleet,
        required this.vehicles,
    });

    factory UsersFleetVehicles.fromJson(Map<String, dynamic> json) => UsersFleetVehicles(
        usersFleetVehiclesId: json["users_fleet_vehicles_id"],
        usersFleetId: json["users_fleet_id"],
        vehiclesId: json["vehicles_id"],
        model: json["model"],
        color: json["color"],
        vehicleRegistrationNo: json["vehicle_registration_no"],
        vehicleIdentificationNo: json["vehicle_identification_no"],
        vehicleLicenseExpiryDate: DateTime.parse(json["vehicle_license_expiry_date"]),
        vehicleInsuranceExpiryDate: DateTime.parse(json["vehicle_insurance_expiry_date"]),
        rwcExpiryDate: DateTime.parse(json["rwc_expiry_date"]),
        cost: json["cost"],
        manufactureYear: json["manufacture_year"],
        image: json["image"],
        dateAdded: DateTime.parse(json["date_added"]),
        dateModified: json["date_modified"],
        status: json["status"],
        usersFleet: UsersFleet.fromJson(json["users_fleet"]),
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
        "vehicle_license_expiry_date": "${vehicleLicenseExpiryDate.year.toString().padLeft(4, '0')}-${vehicleLicenseExpiryDate.month.toString().padLeft(2, '0')}-${vehicleLicenseExpiryDate.day.toString().padLeft(2, '0')}",
        "vehicle_insurance_expiry_date": "${vehicleInsuranceExpiryDate.year.toString().padLeft(4, '0')}-${vehicleInsuranceExpiryDate.month.toString().padLeft(2, '0')}-${vehicleInsuranceExpiryDate.day.toString().padLeft(2, '0')}",
        "rwc_expiry_date": "${rwcExpiryDate.year.toString().padLeft(4, '0')}-${rwcExpiryDate.month.toString().padLeft(2, '0')}-${rwcExpiryDate.day.toString().padLeft(2, '0')}",
        "cost": cost,
        "manufacture_year": manufactureYear,
        "image": image,
        "date_added": dateAdded.toIso8601String(),
        "date_modified": dateModified,
        "status": status,
        "users_fleet": usersFleet.toJson(),
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

class ServiceTypes {
    int serviceTypesId;
    String name;
    DateTime dateAdded;
    dynamic dateModified;
    String status;

    ServiceTypes({
        required this.serviceTypesId,
        required this.name,
        required this.dateAdded,
        required this.dateModified,
        required this.status,
    });

    factory ServiceTypes.fromJson(Map<String, dynamic> json) => ServiceTypes(
        serviceTypesId: json["service_types_id"],
        name: json["name"],
        dateAdded: DateTime.parse(json["date_added"]),
        dateModified: json["date_modified"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "service_types_id": serviceTypesId,
        "name": name,
        "date_added": dateAdded.toIso8601String(),
        "date_modified": dateModified,
        "status": status,
    };
}
