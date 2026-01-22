import 'package:flutter/material.dart';
import 'package:rickandmorty_2/services/api_service.dart';
import 'package:rickandmorty_2/services/preferences_service.dart';

import '../../../app/locator.dart';
import '../../../models/characters_model.dart';

class FavouritesViewmodel extends ChangeNotifier {
  final _preferencesService = locator<PreferencesService>();
  final _apiService = locator<ApiService>();

  List<CharacterModel>? _characterModelFavourites;

  List<CharacterModel>? get characterModelFavourites => _characterModelFavourites;

  void getFavouritedCharacters() async {
    final favouritesIdList = _preferencesService.getSavedCharacters();
    if(favouritesIdList.isEmpty){
    _characterModelFavourites = [];
    notifyListeners();
    return;
    }
    _characterModelFavourites = await _apiService.getMultipleCharacters(
      favouritesIdList,
    );
    notifyListeners();
  }
}
