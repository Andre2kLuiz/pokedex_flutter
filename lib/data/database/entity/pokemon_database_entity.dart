
import 'package:json_annotation/json_annotation.dart';

part 'pokemon_database_entity.g.dart';

@JsonSerializable()
class PokemonDatabaseEntity {

  @JsonKey(name: PokemonDatabaseContract.idColumn)
  final String id;
  @JsonKey(name: PokemonDatabaseContract.nameColumn)
  final Map<String, String> name;
  @JsonKey(name: PokemonDatabaseContract.typeColumn)
  final List<String> type; // Alterado para List<String> para refletir o tipo correto
  @JsonKey(name: PokemonDatabaseContract.baseColumn)
  final Map<String, int> base;
  @JsonKey(name: PokemonDatabaseContract.imgColumn)
  final String? img_url;

  PokemonDatabaseEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.base,
    this.img_url, String? imgUrl,
  });

  factory PokemonDatabaseEntity.fromJson(Map<String, dynamic> json) =>
      _$PokemonDatabaseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonDatabaseEntityToJson(this);

}

abstract class PokemonDatabaseContract {
  static const String pokemonTable = "pokemon_table";
  static const String idColumn = "id";
  static const String nameColumn = "name";
  static const String typeColumn = "type";
  static const String baseColumn = "base";
  static const String imgColumn = "img_url";
}
