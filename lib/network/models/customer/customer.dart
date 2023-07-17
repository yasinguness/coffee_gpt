// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../order/order.dart';

part 'customer.g.dart';

@JsonSerializable()
class CustomerModel extends Equatable {
  @JsonKey(name: "_id")
  String? id;
  String? name;
  String? qrNo;
  List<OrderModel>? orders;
  CustomerModel({
    this.id,
    this.name,
    this.qrNo,
    this.orders,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) => _$CustomerModelFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);

  @override
  List<Object?> get props => [id, name, qrNo, orders];
}
