import 'package:flutter/material.dart';
import 'package:rickandmorty_2/app/locator.dart';
import 'package:rickandmorty_2/models/characters_model.dart';
import 'package:rickandmorty_2/services/api_service.dart';

class ResidentsViewModel extends ChangeNotifier {
  final _apiService = locator<ApiService>();

  List<CharacterModel>? _residents;
  List<CharacterModel>? get residents => _residents;

  void getResidentsByUrlList(List residentsUrlList) async {
    _residents = await _apiService.getCharactersFromUrlList(
      residentsUrlList.map((e) => e.toString()).toList(),
    );
    print('residents : ${_residents!.length}');
    notifyListeners();
  }
}
