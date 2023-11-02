import 'package:deliver_partner/models/API%20models/GetAllVehicalsModel.dart';
import 'package:deliver_partner/models/API%20models/LogInModel.dart';

class ShowBookingsModel {
  int? bookings_fleet_id,
      bookings_id,
      bookings_destinations_id,
      users_fleet_id,
      vehicles_id;

  String? reason, fleet_amount, date_added, date_modified, status;

  BookingModel? bookings;
  GetAllVehicalsModel? vehicles;
  LogInModel? users_fleet;

  ShowBookingsModel(
      {this.bookings_fleet_id,
      this.bookings_id,
      this.bookings_destinations_id,
      this.users_fleet_id,
      this.vehicles_id,
      this.reason,
      this.fleet_amount,
      this.date_added,
      this.date_modified,
      this.status,
      this.bookings,
      this.vehicles,
      this.users_fleet});

  Map<String, dynamic> toJson() {
    return {
      "bookings_fleet_id": bookings_fleet_id,
      "bookings_id": bookings_id,
      "bookings_destinations_id": bookings_destinations_id,
      "users_fleet_id": users_fleet_id,
      "vehicles_id": vehicles_id,
      "reason": reason,
      "fleet_amount": fleet_amount,
      "date_added": date_added,
      "date_modified": date_modified,
      "status": status,
      "bookings": bookings,
      "vehicles": vehicles,
      "users_fleet": users_fleet,
    };
  }

  factory ShowBookingsModel.fromJson(Map<String, dynamic> json) {
    return ShowBookingsModel(
      bookings_fleet_id: json["bookings_fleet_id"] ?? -1,
      bookings_id: json["bookings_id"] ?? -1,
      bookings_destinations_id: json["bookings_destinations_id"] ?? -1,
      users_fleet_id: json["users_fleet_id"] ?? -1,
      vehicles_id: json["vehicles_id"] ?? -1,
      reason: json["reason"] ?? '',
      fleet_amount: json["fleet_amount"] ?? '',
      date_added: json["date_added"] ?? '',
      date_modified: json["date_modified"] ?? '',
      status: json["status"] ?? '',
      bookings: BookingModel.fromJson(json["bookings"] ?? BookingModel()),
      vehicles: GetAllVehicalsModel.fromJson(json["vehicles"] ?? Map()),
      users_fleet: LogInModel.fromJson(json["users_fleet"] ?? Map()),
    );
  }
//
}

class BookingsTypesModel {
  int? bookings_types_id;

  String? name, same_day, status;

  BookingsTypesModel(
      {this.bookings_types_id, this.name, this.same_day, this.status});

  Map<String, dynamic> toJson() {
    return {
      "bookings_types_id": bookings_types_id,
      "name": name,
      "same_day": same_day,
      "status": status,
    };
  }

  factory BookingsTypesModel.fromJson(Map<String, dynamic> json) {
    return BookingsTypesModel(
      bookings_types_id: json["bookings_types_id"] ?? -1,
      name: json["name"] ?? '',
      same_day: json["same_day"] ?? '',
      status: json["status"] ?? '',
    );
  }
//
}

class PaymentGateways {
  int? payment_gateways_id;
  String? payment_type, name, status;

  PaymentGateways(
      {this.payment_gateways_id, this.payment_type, this.name, this.status});

  Map<String, dynamic> toJson() {
    return {
      "payment_gateways_id": payment_gateways_id,
      "payment_type": payment_type,
      "name": name,
      "status": status,
    };
  }

  factory PaymentGateways.fromJson(Map<String, dynamic> json) {
    return PaymentGateways(
      payment_gateways_id: json["payment_gateways_id"] ?? -1,
      payment_type: json["payment_type"] ?? '',
      name: json["name"] ?? '',
      status: json["status"] ?? '',
    );
  }
//
}

class BookingDestinationStatus {
  int? bookings_destinations_status_id;
  String? name, status;

  BookingDestinationStatus(
      {this.bookings_destinations_status_id, this.name, this.status});

  factory BookingDestinationStatus.fromJson(Map<String, dynamic> json) {
    return BookingDestinationStatus(
      bookings_destinations_status_id: json["bookings_destinations_status_id"],
      name: json["name"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "bookings_destinations_status_id": bookings_destinations_status_id,
      "name": name,
      "status": status,
    };
  }
}

class BookingDestinations {
  int? bookings_destinations_id, bookings_id, bookings_destinations_status_id;
  String? pickup_address,
      pickup_latitude,
      pickup_longitude,
      destin_address,
      destin_latitude,
      destin_longitude,
      destin_distance,
      destin_time,
      destin_delivery_charges,
      destin_vat_charges,
      destin_total_charges,
      destin_discount,
      destin_discounted_charges,
      receiver_name,
      receiver_phone;
  BookingDestinationStatus? bookings_destinations_status;

  BookingDestinations({
    this.bookings_destinations_id,
    this.bookings_id,
    this.pickup_address,
    this.pickup_latitude,
    this.pickup_longitude,
    this.destin_address,
    this.destin_latitude,
    this.destin_longitude,
    this.destin_distance,
    this.destin_time,
    this.destin_delivery_charges,
    this.destin_vat_charges,
    this.destin_total_charges,
    this.destin_discount,
    this.destin_discounted_charges,
    this.receiver_name,
    this.receiver_phone,
    this.bookings_destinations_status_id,
    this.bookings_destinations_status,
  });

  Map<String, dynamic> toJson() {
    return {
      "bookings_destinations_id": bookings_destinations_id,
      "bookings_id": bookings_id,
      "pickup_address": pickup_address,
      "pickup_latitude": pickup_latitude,
      "pickup_longitude": pickup_longitude,
      "destin_address": destin_address,
      "destin_latitude": destin_latitude,
      "destin_longitude": destin_longitude,
      "destin_distance": destin_distance,
      "destin_time": destin_time,
      "destin_delivery_charges": destin_delivery_charges,
      "destin_vat_charges": destin_vat_charges,
      "destin_total_charges": destin_total_charges,
      "destin_discount": destin_discount,
      "destin_discounted_charges": destin_discounted_charges,
      "receiver_name": receiver_name,
      "receiver_phone": receiver_phone,
      "bookings_destinations_status_id": bookings_destinations_status_id,
      "bookings_destinations_status": bookings_destinations_status,
    };
  }

  factory BookingDestinations.fromJson(Map<String, dynamic> json) {
    return BookingDestinations(
      bookings_destinations_id: json["bookings_destinations_id"] ?? -1,
      bookings_id: json["bookings_id"] ?? -1,
      bookings_destinations_status_id:
          json["bookings_destinations_status_id"] ?? -1,
      pickup_address: json["pickup_address"] ?? '',
      pickup_latitude: json["pickup_latitude"] ?? '',
      pickup_longitude: json["pickup_longitude"] ?? '',
      destin_address: json["destin_address"] ?? "",
      destin_latitude: json["destin_latitude"] ?? "",
      destin_longitude: json["destin_longitude"] ?? "",
      destin_distance: json["destin_distance"] ?? "",
      destin_time: json["destin_time"] ?? "",
      destin_delivery_charges: json["destin_delivery_charges"] ?? "",
      destin_vat_charges: json["destin_vat_charges"] ?? "",
      destin_total_charges: json["destin_total_charges"] ?? "",
      destin_discount: json["destin_discount"] ?? "",
      destin_discounted_charges: json["destin_discounted_charges"] ?? "",
      receiver_name: json["receiver_name"] ?? "",
      receiver_phone: json["receiver_phone"] ?? "",
      bookings_destinations_status: BookingDestinationStatus.fromJson(
          json["bookings_destinations_status"] ?? Map()),
    );
  }
//
}

class CustomersModel {
  int? users_customers_id;
  String? one_signal_id,
      wallet_amount,
      last_activity,
      bookings_ratings,
      first_name,
      last_name,
      phone,
      email,
      password,
      profile_pic,
      latitude,
      longitude,
      google_access_token,
      account_type,
      social_account_type,
      badge_verified,
      notifications,
      messages,
      verify_email_otp,
      update_profile,
      verify_email_otp_created_at,
      email_verified,
      verify_phone_otp,
      verify_phone_otp_created_at,
      phone_verified,
      forgot_pwd_otp,
      forgot_pwd_otp_created_at,
      date_added,
      date_modified,
      status;

  CustomersModel(
      {this.users_customers_id,
      this.one_signal_id,
      this.wallet_amount,
      this.last_activity,
      this.bookings_ratings,
      this.first_name,
      this.last_name,
      this.phone,
      this.email,
      this.password,
      this.profile_pic,
      this.latitude,
      this.longitude,
      this.google_access_token,
      this.account_type,
      this.social_account_type,
      this.badge_verified,
      this.notifications,
      this.messages,
      this.verify_email_otp,
      this.update_profile,
      this.verify_email_otp_created_at,
      this.email_verified,
      this.verify_phone_otp,
      this.verify_phone_otp_created_at,
      this.phone_verified,
      this.forgot_pwd_otp,
      this.forgot_pwd_otp_created_at,
      this.date_added,
      this.date_modified,
      this.status});

  Map<String, dynamic> toJson() {
    return {
      "users_customers_id": users_customers_id,
      "one_signal_id": one_signal_id,
      "wallet_amount": wallet_amount,
      "last_activity": last_activity,
      "bookings_ratings": bookings_ratings,
      "first_name": first_name,
      "last_name": last_name,
      "phone": phone,
      "email": email,
      "password": password,
      "profile_pic": profile_pic,
      "latitude": latitude,
      "longitude": longitude,
      "google_access_token": google_access_token,
      "account_type": account_type,
      "social_account_type": social_account_type,
      "badge_verified": badge_verified,
      "notifications": notifications,
      "messages": messages,
      "verify_email_otp": verify_email_otp,
      "update_profile": update_profile,
      "verify_email_otp_created_at": verify_email_otp_created_at,
      "email_verified": email_verified,
      "verify_phone_otp": verify_phone_otp,
      "verify_phone_otp_created_at": verify_phone_otp_created_at,
      "phone_verified": phone_verified,
      "forgot_pwd_otp": forgot_pwd_otp,
      "forgot_pwd_otp_created_at": forgot_pwd_otp_created_at,
      "date_added": date_added,
      "date_modified": date_modified,
      "status": status,
    };
  }

  factory CustomersModel.fromJson(Map<String, dynamic> json) {
    return CustomersModel(
      users_customers_id: json["users_customers_id"] ?? -1,
      one_signal_id: json["one_signal_id"] ?? '',
      wallet_amount: json["wallet_amount"] ?? '',
      last_activity: json["last_activity"] ?? '',
      bookings_ratings: json["bookings_ratings"] ?? '',
      first_name: json["first_name"] ?? '',
      last_name: json["last_name"] ?? '',
      phone: json["phone"] ?? '',
      email: json["email"] ?? '',
      password: json["password"] ?? '',
      profile_pic: json["profile_pic"] ?? '',
      latitude: json["latitude"] ?? '0.0',
      longitude: json["longitude"] ?? '0.0',
      google_access_token: json["google_access_token"] ?? '',
      account_type: json["account_type"] ?? '',
      social_account_type: json["social_account_type"] ?? '',
      badge_verified: json["badge_verified"] ?? '',
      notifications: json["notifications"] ?? '',
      messages: json["messages"] ?? '',
      verify_email_otp: json["verify_email_otp"] ?? '',
      update_profile: json["update_profile"] ?? '',
      verify_email_otp_created_at: json["verify_email_otp_created_at"] ?? '',
      email_verified: json["email_verified"] ?? '',
      verify_phone_otp: json["verify_phone_otp"] ?? '',
      verify_phone_otp_created_at: json["verify_phone_otp_created_at"] ?? '',
      phone_verified: json["phone_verified"] ?? '',
      forgot_pwd_otp: json["forgot_pwd_otp"] ?? '',
      forgot_pwd_otp_created_at: json["forgot_pwd_otp_created_at"] ?? '',
      date_added: json["date_added"] ?? '',
      date_modified: json["date_modified"] ?? '',
      status: json["status"] ?? '',
    );
  }
//
}

class BookingModel {
  int? bookings_id,
      users_customers_id,
      bookings_types_id,
      payment_gateways_id,
      fleet_status_id;
  String? delivery_type,
      delivery_date,
      delivery_time,
      total_delivery_charges,
      total_vat_charges,
      total_charges,
      total_discount,
      total_discounted_charges,
      payment_by,
      payment_status,
      date_added,
      date_modified,
      status,
      scheduled;
  CustomersModel? users_customers;
  BookingsTypesModel? bookings_types;
  PaymentGateways? payment_gateways;
  List<BookingDestinations>? bookings_destinations;

  BookingModel(
      {this.bookings_id,
      this.users_customers_id,
      this.bookings_types_id,
      this.payment_gateways_id,
      this.fleet_status_id,
      this.delivery_type,
      this.delivery_date,
      this.delivery_time,
      this.total_delivery_charges,
      this.total_vat_charges,
      this.total_charges,
      this.total_discount,
      this.total_discounted_charges,
      this.payment_by,
      this.payment_status,
      this.date_added,
      this.date_modified,
      this.status,
      this.scheduled,
      this.users_customers,
      this.bookings_types,
      this.payment_gateways,
      this.bookings_destinations});

  Map<String, dynamic> toJson() {
    return {
      "bookings_id": bookings_id,
      "users_customers_id": users_customers_id,
      "bookings_types_id": bookings_types_id,
      "payment_gateways_id": payment_gateways_id,
      "fleet_status_id": fleet_status_id,
      "delivery_type": delivery_type,
      "delivery_date": delivery_date,
      "delivery_time": delivery_time,
      "total_delivery_charges": total_delivery_charges,
      "total_vat_charges": total_vat_charges,
      "total_charges": total_charges,
      "total_discount": total_discount,
      "total_discounted_charges": total_discounted_charges,
      "payment_by": payment_by,
      "payment_status": payment_status,
      "date_added": date_added,
      "date_modified": date_modified,
      "status": status,
      "scheduled": scheduled,
      "users_customers": users_customers,
      "bookings_types": bookings_types,
      "payment_gateways": payment_gateways,
      "bookings_destinations": bookings_destinations,
    };
  }

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      bookings_id: json["bookings_id"] ?? -1,
      users_customers_id: json["users_customers_id"] ?? -1,
      bookings_types_id: json["bookings_types_id"] ?? -1,
      payment_gateways_id: json["payment_gateways_id"] ?? -1,
      fleet_status_id: json["fleet_status_id"] ?? -1,
      delivery_type: json["delivery_type"] ?? '',
      delivery_date: json["delivery_date"] ?? '',
      delivery_time: json["delivery_time"] ?? '',
      total_delivery_charges: json["total_delivery_charges"] ?? '',
      total_vat_charges: json["total_vat_charges"] ?? '',
      total_charges: json["total_charges"] ?? '',
      total_discount: json["total_discount"] ?? '',
      total_discounted_charges: json["total_discounted_charges"] ?? '',
      payment_by: json["payment_by"] ?? '',
      payment_status: json["payment_status"] ?? '',
      date_added: json["date_added"] ?? '',
      date_modified: json["date_modified"] ?? '',
      status: json["status"] ?? '',
      scheduled: json["scheduled"] ?? '',
      users_customers:
          CustomersModel.fromJson(json["users_customers"] ?? Map()),
      bookings_types:
          BookingsTypesModel.fromJson(json["bookings_types"] ?? Map()),
      payment_gateways:
          PaymentGateways.fromJson(json["payment_gateways"] ?? Map()),
      bookings_destinations: List<BookingDestinations>.from(
          json["bookings_destinations"]
              .map((x) => BookingDestinations.fromJson(x))),
    );
  }
//
}
