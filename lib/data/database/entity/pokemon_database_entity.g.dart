// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_database_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonDatabaseEntity _$PokemonDatabaseEntityFromJson(
        Map<String, dynamic> json) =>
    PokemonDatabaseEntity(
      id: json['id'] as String,
      name: Map<String, String>.from(json['name'] as Map),
      type: (json['type'] as List<dynamic>).map((e) => e as String).toList(),
      base: Map<String, int>.from(json['base'] as Map),
      img_url: json['img_url'] as String?,
    );

Map<String, dynamic> _$PokemonDatabaseEntityToJson(
        PokemonDatabaseEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'base': instance.base,
      'img_url': instance.img_url,
    };
