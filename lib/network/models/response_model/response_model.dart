import "package:json_annotation/json_annotation.dart";

part 'response_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  int? statusCode;
  T? data;
  bool? success;

  ApiResponse({
    this.statusCode,
    this.data,
    this.success,
  });

  factory ApiResponse.fromJson(dynamic json, T Function(Object? json) fromJsonT) =>
      _$ApiResponseFromJson(json as Map<String, dynamic>, (json) {
        return fromJsonT(json);
      });
}
