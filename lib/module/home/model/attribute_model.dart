class AttributeModel {
  String? message;
  String? assignmentInstructionUrl;
  String? information;
  JsonResponse? jsonResponse;

  AttributeModel(
      {this.message,
        this.assignmentInstructionUrl,
        this.information,
        this.jsonResponse});

  AttributeModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    assignmentInstructionUrl = json['assignmentInstructionUrl'];
    information = json['information'];
    jsonResponse = json['json_response'] != null
        ? new JsonResponse.fromJson(json['json_response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['assignmentInstructionUrl'] = this.assignmentInstructionUrl;
    data['information'] = this.information;
    if (this.jsonResponse != null) {
      data['json_response'] = this.jsonResponse!.toJson();
    }
    return data;
  }
}

class JsonResponse {
  List<Attributes>? attributes;

  JsonResponse({this.attributes});

  JsonResponse.fromJson(Map<String, dynamic> json) {
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(new Attributes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attributes {
  String? id;
  String? title;
  String? type;
  List<String>? options;

  Attributes({this.id, this.title, this.type, this.options});

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    data['options'] = this.options;
    return data;
  }
}
