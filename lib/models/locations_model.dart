class LocationsMainModel {
  LocationsInfo info;
  final List<LocationModel> locations;

  LocationsMainModel({required this.info, required this.locations});

  factory LocationsMainModel.fromJson(Map<String, dynamic> json) {
    final info = LocationsInfo.fromJson(json['info']);
    final locations = (json['results'] as List)
        .map((locationJson) => LocationModel.fromJson(locationJson))
        .toList();

    return LocationsMainModel(info: info, locations: locations);
  }
}

class LocationsInfo {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  LocationsInfo({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });

  LocationsInfo.fromJson(Map<String, dynamic> json)
    : count = json['count'],
      pages = json['pages'],
      next = json['next'],
      prev = json['prev'];
}

class LocationModel {
  final int id;
  final String name;
  final String type;
  final String dimension;
  final List<String> residents;
  final String url;
  final String created;

  LocationModel({
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
    required this.residents,
    required this.url,
    required this.created,
  });

  LocationModel.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'],
      type = json['type'],
      dimension = json['dimension'],
      residents = List<String>.from(json['residents']),
      url = json['url'],
      created = json['created'];
}
