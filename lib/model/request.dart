import 'dart:collection';

class RequestModel {
  String? methodType;
  String? methodUrl;
  dynamic data;
  dynamic queryParams;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = HashMap<String, dynamic>();
    jsonData['method_type'] = methodType;
    jsonData['method_url'] = methodUrl;
    jsonData['data'] = data;
    jsonData['query_params'] = queryParams;
    return jsonData;
  }

  RequestModel.fromJson(Map<String, dynamic> json) {
    methodType = json['method_type'];
    methodUrl = json['method_url'];
    queryParams = json['query_params'] ?? {};
    data = json['data'] ?? {};
  }

  @override
  String toString() {
    return "RequestModel [ methodType= $methodType  methodUrl= $methodUrl data= $data queryParams= $queryParams]";
  }

  static RequestModel convertJsonToModel(dynamic value) {
    print("Request Body:- $value");
    return RequestModel.fromJson(value);
  }
}
