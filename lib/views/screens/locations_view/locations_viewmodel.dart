import 'package:flutter/material.dart';
import 'package:rickandmorty_2/app/locator.dart';
import 'package:rickandmorty_2/models/locations_model.dart';
import 'package:rickandmorty_2/services/api_service.dart';

class LocationsViewmodel extends ChangeNotifier{
  final _apiService = locator<ApiService>();

  LocationsMainModel? _locationsMainModel;
  LocationsMainModel? get locationsMainModel => _locationsMainModel;

  void getLocations() async{
    _locationsMainModel = await _apiService.getLocations(); //info ve location listesini cektik
    notifyListeners();
  }

}