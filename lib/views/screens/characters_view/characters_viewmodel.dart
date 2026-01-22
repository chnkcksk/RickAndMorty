import 'package:flutter/material.dart';
import 'package:rickandmorty_2/app/locator.dart';
import 'package:rickandmorty_2/services/api_service.dart';

import '../../../models/characters_model.dart';

class CharactersViewmodel extends ChangeNotifier {
  final _apiService = locator<ApiService>();

  CharactersModel? _charactersModel;
  CharactersModel? get charactersModel => _charactersModel;

  void clearCharacters() async{
    _charactersModel = null;
    currentPageIndex = 1;
    notifyListeners();
  }

  void getCharacters() async {
    _charactersModel = await _apiService
        .getCharacters(); //Tum karakterler ve info bilgilerini cektik
    notifyListeners(); //ekrani yenileyecek
    //print('geldi ${_charactersModel!.characters[3].name}');
  }

  bool loadMore = false;
  int currentPageIndex = 1;

  void setLoadMore(bool value) {
    //loading gostermek icin
    loadMore = value;
    notifyListeners();
  }

  void getCharactersMore() async {
    //zaten yukleniyorsa tekrar istek atma
    if (loadMore) return;

    //egerki son sayfaysa istek atma
    if (_charactersModel!.info.pages == currentPageIndex) return;

    setLoadMore(true);
    final data = await _apiService.getCharactersMore(
      url: '${_charactersModel?.info.next}',
    );
    setLoadMore(false);

    currentPageIndex++;

    _charactersModel!.info = data.info;
    _charactersModel!.characters.addAll(data.characters);

    notifyListeners();
  }

  void getCharactersByName(String name) async {
    clearCharacters();
    _charactersModel = await _apiService.getCharactersByName(
      args: {'name': name},
    );
    notifyListeners();
  }
}
