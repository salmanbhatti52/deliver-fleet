class SupportedUserModel {
  int? users_system_id, users_system_roles_id;
  String? first_name,
      email,
      password,
      mobile,
      city,
      address,
      user_image,
      is_deleted,
      created_at,
      updated_at,
      deleted_at,
      status;

  SupportedUserModel(
      {this.users_system_id,
      this.users_system_roles_id,
      this.first_name,
      this.email,
      this.password,
      this.mobile,
      this.city,
      this.address,
      this.user_image,
      this.is_deleted,
      this.created_at,
      this.updated_at,
      this.deleted_at,
      this.status});

  factory SupportedUserModel.fromJson(Map<String, dynamic> json) {
    return SupportedUserModel(
      users_system_id: json["users_system_id"] ?? -1,
      users_system_roles_id: json["users_system_roles_id"] ?? -1,
      first_name: json["first_name"] ?? '',
      email: json["email"] ?? '',
      password: json["password"] ?? '',
      mobile: json["mobile"] ?? '',
      city: json["city"] ?? '',
      address: json["address"] ?? '',
      user_image: json["user_image"] ?? '',
      is_deleted: json["is_deleted"] ?? '',
      created_at: json["created_at"] ?? '',
      updated_at: json["updated_at"] ?? '',
      deleted_at: json["deleted_at"] ?? '',
      status: json["status"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "users_system_id": users_system_id,
      "users_system_roles_id": users_system_roles_id,
      "first_name": first_name,
      "email": email,
      "password": password,
      "mobile": mobile,
      "city": city,
      "address": address,
      "user_image": user_image,
      "is_deleted": is_deleted,
      "created_at": created_at,
      "updated_at": updated_at,
      "deleted_at": deleted_at,
      "status": status,
    };
  }

//
}
