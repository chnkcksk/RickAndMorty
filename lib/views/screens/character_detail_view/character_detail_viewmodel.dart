import 'package:flutter/material.dart';
import 'package:rickandmorty_2/models/episodes_model.dart';
import 'package:rickandmorty_2/services/api_service.dart';

import '../../../app/locator.dart';

class CharacterDetailViewmodel extends ChangeNotifier {
  final _apiService = locator<ApiService>();

  List<EpisodeModel> _episodes = [];
  List<EpisodeModel> get episodes => _episodes;

  void getEpisodes(List<String> episodesUrlList) async{
    _episodes = await _apiService.getMultipleEpisodes(episodesUrlList);
    notifyListeners();
  }

}
