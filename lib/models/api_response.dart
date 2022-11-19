class ApiResponse<T> {
  final T? data;
  final String? message;
  final bool status;

  ApiResponse({
    this.data,
    this.message,
    required this.status
  });
}