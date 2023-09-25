class APIResponse<T> {
  String? message, status;
  T? data;

  APIResponse({
    this.data,
    this.message,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'data': this.data,
      'message': this.message,
      'status': this.status,
    };
  }

  factory APIResponse.fromMap(Map<String, dynamic> map) {
    return APIResponse(
      data: map['data'] as T,
      message: map['message'] ?? '',
      status: map['status'] ?? '',
    );
  }
}
