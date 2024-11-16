import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import '../../../network/network_client.dart';
import '../../../utils/api_endpoints.dart';
import '../model/attribute_model.dart';

class DataSource {
  final List<AttributeModel> attributeData = [];

  NetworkClient networkClient = NetworkClient();

  Future<List<Attributes>> getAttribute() async {
    try {
      Response response = await NetworkClient().getRequest(Api.attribute);

      log("getAttribute response: ${response.body}");
      if (response.statusCode == 200) {
        // Decode the response
        Map<String, dynamic> responseData = json.decode(response.body);

        // Parse the attributes list from json_response
        List<dynamic> attributesJson =
        responseData['json_response']['attributes'];

        // Convert JSON into a list of Attributes
        List<Attributes> attributesList = attributesJson
            .map((attribute) => Attributes.fromJson(attribute))
            .toList();

        return attributesList;
      } else {
        log("Failed to fetch attributes: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      log("Error in getAttribute: ${e.toString()}");
      return [];
    }
  }
}