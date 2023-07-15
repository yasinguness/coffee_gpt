import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../base/base_model.dart';
import '../order/order.dart';

part 'customer.g.dart';

@JsonSerializable()
class CustomerModel extends Equatable with BaseModel<CustomerModel> {
  @JsonKey(name: "_id")
  final String? id;
  final String? name;
  final String? qrNo;
  final List<OrderModel>? orders;
  const CustomerModel({this.id, this.name, this.qrNo, this.orders});

  factory CustomerModel.fromJson(Map<String, dynamic> json) => _$CustomerModelFromJson(json);
  //Map<dynamic, dynamic> toJson() => _$CustomerModelToJson(this);

  @override
  List<Object?> get props => [id, name, qrNo, orders];

  @override
  Map<String, Object?> toJson() => _$CustomerModelToJson(this);

  @override
  CustomerModel fromJson(Map<String, Object> json) {
    return _$CustomerModelFromJson(json);
  }
}
