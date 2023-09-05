class MyResponse<T> {
  final String message;
  final List<T> results;

  MyResponse({
    required this.message,
    required this.results
  });

  factory MyResponse.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJson) {
    return MyResponse<T>(
      message: json['message'],
      results: (json['results'] as List<dynamic>).map((result) => fromJson(result)).toList(),
    );
  }
}
