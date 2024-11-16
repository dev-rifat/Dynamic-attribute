import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../data/data_source.dart';
import '../model/attribute_model.dart';

class ApiProvider extends ChangeNotifier {
  List<Attributes> _attributeList = [];
  List<Attributes> get attributes => _attributeList;
  bool isLoading = false;
  bool isValid = false;

  // Form controllers and state variables
  String selectedPropertyType = '';
  String selectedCleanFrequency = '';
  String selectedProduct = '';
  String selectedBedroom = '';
  String selectedBathroom = '';
  bool includeGarageCleaning = false;
  bool includeOutdoorArea = false;
  TextEditingController preferredCleaningTimeController =
      TextEditingController();

  DataSource dataSource = DataSource();

  Future fetchData() async {
    isLoading = true;
    try {
      _attributeList = await dataSource.getAttribute();
      notifyListeners();
    } catch (e) {
      log("Error in fetchData: ${e.toString()}");
    }
    isLoading = false;
  }
}
