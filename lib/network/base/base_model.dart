abstract class BaseModel<T> {
  Map<dynamic, dynamic> toJson();
  T fromJson(Map<String, Object> json);
}
