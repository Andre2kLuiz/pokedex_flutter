import 'package:json_annotation/json_annotation.dart';

part 'http_paged_result.g.dart';

@JsonSerializable()
class HttpPagedResult {
  int first;
  dynamic prev;
  int next;
  int last;
  int pages;
  int items;
  List<PokemonEntity> data;

  HttpPagedResult({
    required this.first,
    required this.prev,
    required this.next,
    required this.last,
    required this.pages,
    required this.items,
    required this.data,
  });

  factory HttpPagedResult.fromJson(Map<String, dynamic> json) => _$HttpPagedResultFromJson(json);

}

@JsonSerializable()
class PokemonEntity {
  String id;
  Name name;
  List<String> type;
  BaseStats base;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String url;

  PokemonEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.base,
    required this.url
  });

  factory PokemonEntity.fromJson(Map<String, dynamic> json) => _$PokemonEntityFromJson(json);

}

@JsonSerializable()
class Name {
  String english;
  String japanese;
  String chinese;
  String french;

  Name({
    required this.english,
    required this.japanese,
    required this.chinese,
    required this.french,
  });
  

  // Método toJson
  Map<String, dynamic> toJson() => {
        'english': english,
        'japanese': japanese,
        'chinese': chinese,
        'french': french,
      };


  factory Name.fromJson(Map<String, dynamic> json) => _$NameFromJson(json);
}

@JsonSerializable()
class BaseStats {
  int HP;
  int Attack;
  int Defense;
  int SpAttack;
  int SpDefense;
  int Speed;

  BaseStats({
    required this.HP,
    required this.Attack,
    required this.Defense,
    required this.SpAttack,
    required this.SpDefense,
    required this.Speed,
  });

   Map<String, dynamic> toJson() => {
        'HP': HP,
        'Attack': Attack,
        'Defense': Defense,
        'Sp. Attack': SpAttack,
        'Sp. Defense': SpDefense,
        'Speed': Speed,
      };

  factory BaseStats.fromJson(Map<String, dynamic> json) => _$BaseStatsFromJson(json);
}
