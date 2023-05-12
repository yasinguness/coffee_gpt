abstract class ServiceModel<T> {
  T fromJson(Map<String, dynamic> json);
  Map<dynamic, dynamic> toJson();
}
