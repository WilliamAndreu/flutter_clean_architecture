abstract class CustomException<T extends Object?> implements Exception {
  final T? data;

  String get title;
  String get message;

  const CustomException({this.data});

  bool hasData() => data != null;
}
