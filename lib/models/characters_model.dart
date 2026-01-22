class CharactersModel {
  CharacterInfo info; //finali kaldirdik
  final List<CharacterModel> characters;

  CharactersModel({required this.info, required this.characters});

  factory CharactersModel.fromJson(Map<String, dynamic> json) {
    final info = CharacterInfo.fromJson(json['info']);
    final characters = (json['results'] as List)
        .map((characterJson) => CharacterModel.fromJson(characterJson))
        .toList();

    return CharactersModel(info: info, characters: characters);
  }

}

class CharacterInfo {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  CharacterInfo({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });

  CharacterInfo.fromJson(Map<String, dynamic> json)
    : count = json['count'],
      pages = json['pages'],
      next = json['next'],
      prev = json['prev'];
}

class CharacterModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final Origin origin;
  final Location location;
  final String image;
  final List<String> episode;
  final String url;
  final String created;

  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  CharacterModel.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'],
      status = json['status'],
      species = json['species'],
      type = json['type'],
      gender = json['gender'],
      origin = Origin.fromJson(json['location']),
      location = Location.fromJson(json['location']),
      image = json['image'],
      episode = List<String>.from(json['episode']),
      url = json['url'],
      created = json['created'];
}

class Origin {
  final String name;
  final String url;

  Origin({required this.name, required this.url});

  Origin.fromJson(Map<String, dynamic> json)
    : name = json['name'],
      url = json['url'];
}

class Location {
  final String name;
  final String url;

  Location({required this.name, required this.url});

  Location.fromJson(Map<String, dynamic> json)
    : name = json['name'],
      url = json['url'];
}
