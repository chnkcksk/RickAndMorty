import 'dart:math';

import 'package:dio/dio.dart';
import 'package:rickandmorty_2/models/characters_model.dart';
import 'package:rickandmorty_2/models/episodes_model.dart';
import 'package:rickandmorty_2/models/locations_model.dart';

class ApiService {
  final _dio = Dio(BaseOptions(baseUrl: 'https://rickandmortyapi.com/api'));



  Future<CharactersModel> getCharacters() async {
    try {
      final response = await _dio.get('/character');
      return CharactersModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<CharactersModel> getCharactersMore({required String url}) async {
    try {
      final response = await _dio.get(url);
      return CharactersModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<CharactersModel> getCharactersByName({
    Map<String, dynamic>? args,
  }) async {
    try {
      final response = await _dio.get('/character', queryParameters: args);
      return CharactersModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CharacterModel>> getMultipleCharacters(
      List<int> idList,
      ) async {
    try {
      final response = await _dio.get('/character/${idList.join(',')}');
      final data = response.data;

      print("api: $data");

      if (data is List) {
        // /character/1,2,3
        return data.map((e) => CharacterModel.fromJson(e)).toList();
      }

      if (data is Map<String, dynamic>) {
        // /character/35
        if (data.containsKey('id')) {
          return [CharacterModel.fromJson(data)];
        }

        // /character?page=1
        if (data.containsKey('results')) {
          return (data['results'] as List)
              .map((e) => CharacterModel.fromJson(e))
              .toList();
        }
      }

      throw Exception("Unexpected response structure");
    } catch (e) {
      rethrow;
    }
  }



  Future<List<EpisodeModel>> getMultipleEpisodes(
    List<String> episodesUrlList,
  ) async {
    try {
      final List<String> episodeNumbers = episodesUrlList
          .map((e) => e.split('/').last)
          .toList();

      String episodes = episodeNumbers.join(',');
      if (episodesUrlList.length == 1) episodes = '$episodes,';

      final response = await _dio.get('/episode/$episodes');

      return (response.data as List)
          .map((e) => EpisodeModel.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<LocationsMainModel> getLocations() async {
    try {
      final response = await _dio.get('/location');
      return LocationsMainModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CharacterModel>> getCharactersFromUrlList(List<String> residentsUrl) async{
    final List<int> idList = residentsUrl.map((e)=> int.parse(e.split('/').last)).toList();
    try{
      return await getMultipleCharacters(idList);
    }catch(e){
      rethrow;
    }
  }

}
