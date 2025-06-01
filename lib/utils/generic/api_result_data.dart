import 'package:raya_mobile/app/network/api_failure.dart';

class Result<T> {
  Result({this.data, this.error});
  factory Result.success(T data) => Result(data: data);
  factory Result.failure(Failure error) => Result(error: error);

  final T? data;
  final Failure? error;

  bool get isSuccess => error == null;
  bool get isFailure => error != null;
}