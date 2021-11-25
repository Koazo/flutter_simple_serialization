import 'dart:convert';

import 'package:http/http.dart' as http;

class CharactersList {
  List<Character?>? results;

  CharactersList({this.results});

  factory CharactersList.fromJson(Map<String, dynamic> json) {
    var resultsJson = json['results'] as List;

    List<Character?>? charactersList =
        resultsJson.map((i) => Character.fromJson(i)).toList();

    return CharactersList(
      results: charactersList,
    );
  }
}

class Character {
  final String? name;
  final String? status;
  final String? image;

  Character({this.name, this.status, this.image});

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      name: json['name'] as String?,
      status: json['status'] as String?,
      image: json['image'] as String?,
    );
  }
}

Future<CharactersList> getCharactersList() async {
  var url = Uri.parse('https://rickandmortyapi.com/api/character');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    return CharactersList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
