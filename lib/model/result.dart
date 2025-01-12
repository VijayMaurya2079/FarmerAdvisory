class Result {
  final bool status;
  final String message;
  final dynamic data;

  Result({this.status = false, this.message = "", this.data});

  Map<String, dynamic> toJson() {
    return {"status": status, "message": message, "data": data};
  }

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      status: json['status'],
      message: json['message'].toString(),
      data: json['data'],
    );
  }
}
