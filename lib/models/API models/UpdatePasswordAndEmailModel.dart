class UpdatePasswordAndEmailModel {
  int? users_customers_id;
  String? users_customers_type,
      first_name,
      last_name,
      phone,
      email,
      password,
      fleet_code,
      profile_pic,
      fleet_name,
      address,
      national_identity_no,
      cac_certificate,
      license_no,
      license_front_image,
      license_back_image,
      verify_email_otp,
      verify_email_otp_created_at,
      email_verified,
      verify_phone_otp,
      phone_verified,
      forgot_pwd_otp,
      forgot_pwd_otp_created_at,
      notifications,
      messages,
      lattitude,
      longitude,
      updation_permitted,
      account_type,
      social_acc_type,
      added_at,
      updated_at,
      status;
  UpdatePasswordAndEmailModel({
    this.status,
    this.added_at,
    this.updated_at,
    this.users_customers_id,
    this.longitude,
    this.lattitude,
    this.email,
    this.verify_email_otp_created_at,
    this.forgot_pwd_otp_created_at,
    this.forgot_pwd_otp,
    this.address,
    this.account_type,
    this.email_verified,
    this.first_name,
    this.fleet_code,
    this.fleet_name,
    this.last_name,
    this.license_back_image,
    this.license_front_image,
    this.license_no,
    this.messages,
    this.national_identity_no,
    this.notifications,
    this.password,
    this.phone,
    this.phone_verified,
    this.profile_pic,
    this.social_acc_type,
    this.updation_permitted,
    this.users_customers_type,
    this.verify_email_otp,
    this.verify_phone_otp,
    this.cac_certificate,
  });

  factory UpdatePasswordAndEmailModel.fromJson(Map<String, dynamic> json) {
    return UpdatePasswordAndEmailModel(
      users_customers_id: json["users_customers_id"],
      users_customers_type: json["users_customers_type"],
      first_name: json["first_name"],
      last_name: json["last_name"],
      phone: json["phone"],
      email: json["email"],
      password: json["password"],
      fleet_code: json["fleet_code"],
      profile_pic: json["profile_pic"],
      fleet_name: json["fleet_name"],
      address: json["address"],
      national_identity_no: json["national_identity_no"],
      cac_certificate: json["cac_certificate"],
      license_no: json["license_no"],
      license_front_image: json["license_front_image"],
      license_back_image: json["license_back_image"],
      verify_email_otp: json["verify_email_otp"],
      verify_email_otp_created_at: json["verify_email_otp_created_at"],
      email_verified: json["email_verified"],
      verify_phone_otp: json["verify_phone_otp"],
      phone_verified: json["phone_verified"],
      forgot_pwd_otp: json["forgot_pwd_otp"],
      forgot_pwd_otp_created_at: json["forgot_pwd_otp_created_at"],
      notifications: json["notifications"],
      messages: json["messages"],
      lattitude: json["lattitude"],
      longitude: json["longitude"],
      updation_permitted: json["updation_permitted"],
      account_type: json["account_type"],
      social_acc_type: json["social_acc_type"],
      added_at: json["added_at"],
      updated_at: json["updated_at"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "users_customers_id": users_customers_id,
      "users_customers_type": users_customers_type,
      "first_name": first_name,
      "last_name": last_name,
      "phone": phone,
      "email": email,
      "password": password,
      "fleet_code": fleet_code,
      "profile_pic": profile_pic,
      "fleet_name": fleet_name,
      "address": address,
      "national_identity_no": national_identity_no,
      "cac_certificate": cac_certificate,
      "license_no": license_no,
      "license_front_image": license_front_image,
      "license_back_image": license_back_image,
      "verify_email_otp": verify_email_otp,
      "verify_email_otp_created_at": verify_email_otp_created_at,
      "email_verified": email_verified,
      "verify_phone_otp": verify_phone_otp,
      "phone_verified": phone_verified,
      "forgot_pwd_otp": forgot_pwd_otp,
      "forgot_pwd_otp_created_at": forgot_pwd_otp_created_at,
      "notifications": notifications,
      "messages": messages,
      "lattitude": lattitude,
      "longitude": longitude,
      "updation_permitted": updation_permitted,
      "account_type": account_type,
      "social_acc_type": social_acc_type,
      "added_at": added_at,
      "updated_at": updated_at,
      "status": status,
    };
  }

//
}
