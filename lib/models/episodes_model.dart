import 'dart:convert';

class EpisodesMainModel {
  EpisodeInfo info;
  final List<EpisodeModel> episodes;

  EpisodesMainModel({required this.info, required this.episodes});

  factory EpisodesMainModel.fromJson(Map<String, dynamic> json) {
    final info = EpisodeInfo.fromJson(json['info']);
    final episodes = (json['results'] as List)
        .map((episodeJson) => EpisodeModel.fromJson(episodeJson))
        .toList();

    return EpisodesMainModel(info: info, episodes: episodes);
  }
}

class EpisodeInfo {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  EpisodeInfo({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });

  EpisodeInfo.fromJson(Map<String, dynamic> json)
    : count = json['count'],
      pages = json['pages'],
      next = json['next'],
      prev = json['prev'];
}

class EpisodeModel {
  final int id;
  final String name;
  final String air_date;
  final String episode;
  final List<String> characters;
  final String url;
  final String created;

  EpisodeModel({
    required this.id,
    required this.name,
    required this.air_date,
    required this.episode,
    required this.characters,
    required this.url,
    required this.created,
  });

  EpisodeModel.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'],
      air_date = json['air_date'],
      episode = json['episode'],
      characters = List<String>.from(json['characters']),
      url = json['url'],
      created = json['created'];
}
