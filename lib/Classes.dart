class ResponseData {
  final String result;
  final String error;

  ResponseData({this.result, this.error});

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      result: json['status'],
      error: json['ERROR']
      );
  }
}