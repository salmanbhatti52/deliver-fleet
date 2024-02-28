class ReadNotificationsModel {
  int? notifications_id, senders_id, receivers_id;
  String? message, added_at, read_at, status;

  ReadNotificationsModel(
      {this.message,
      this.status,
      this.read_at,
      this.notifications_id,
      this.added_at,
      this.receivers_id,
      this.senders_id});

  factory ReadNotificationsModel.fromJson(Map<String, dynamic> json) {
    return ReadNotificationsModel(
      notifications_id: json["notifications_id"] ?? -1,
      senders_id: json["senders_id"] ?? -1,
      receivers_id: json["receivers_id"] ?? -1,
      message: json["message"] ?? '',
      added_at: json["added_at"] ?? '',
      read_at: json["read_at"] ?? '',
      status: json["status"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "notifications_id": notifications_id,
      "senders_id": senders_id,
      "receivers_id": receivers_id,
      "message": message,
      "added_at": added_at,
      "read_at": read_at,
      "status": status,
    };
  }

//
}
