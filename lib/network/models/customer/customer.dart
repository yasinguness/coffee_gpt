import 'package:coffe_app/network/models/order/order.dart';
import 'package:json_annotation/json_annotation.dart';
part 'customer.g.dart';

@JsonSerializable()
class CustomerModel {
  String? id;
  String? name;
  String? qrNo;
  List<OrderModel>? orders;
  CustomerModel({this.id, this.name, this.qrNo, this.orders});

  factory CustomerModel.fromJson(Map<String, dynamic> json) => _$CustomerModelFromJson(json);
  Map<dynamic, dynamic> toJson() => _$CustomerModelToJson(this);
}
