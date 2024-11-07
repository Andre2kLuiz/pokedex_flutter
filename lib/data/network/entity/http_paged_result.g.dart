// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_paged_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HttpPagedResult _$HttpPagedResultFromJson(Map<String, dynamic> json) =>
    HttpPagedResult(
      first: (json['first'] as num).toInt(),
      prev: json['prev'],
      next: (json['next'] as num).toInt(),
      last: (json['last'] as num).toInt(),
      pages: (json['pages'] as num).toInt(),
      items: (json['items'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => PokemonEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HttpPagedResultToJson(HttpPagedResult instance) =>
    <String, dynamic>{
      'first': instance.first,
      'prev': instance.prev,
      'next': instance.next,
      'last': instance.last,
      'pages': instance.pages,
      'items': instance.items,
      'data': instance.data,
    };

PokemonEntity _$PokemonEntityFromJson(Map<String, dynamic> json) =>
    PokemonEntity(
      id: json['id'] as String? ?? '',
      name: Name.fromJson(json['name'] as Map<String, dynamic>),
      type: (json['type'] as List<dynamic>).map((e) => e as String).toList(),
      base: BaseStats.fromJson(json['base'] as Map<String, dynamic>),
      url: json['url'] as String? ?? '', // Adicionando a URL
    );

Map<String, dynamic> _$PokemonEntityToJson(PokemonEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'base': instance.base,
      'url': instance.url, // Incluindo a URL
    };

Name _$NameFromJson(Map<String, dynamic> json) => Name(
      english: json['english'] as String,
      japanese: json['japanese'] as String,
      chinese: json['chinese'] as String,
      french: json['french'] as String,
    );

Map<String, dynamic> _$NameToJson(Name instance) => <String, dynamic>{
      'english': instance.english,
      'japanese': instance.japanese,
      'chinese': instance.chinese,
      'french': instance.french,
    };

BaseStats _$BaseStatsFromJson(Map<String, dynamic> json) => BaseStats(
      HP: json['HP'] is String ? int.parse(json['HP']) : json['HP'],
      Attack: json['Attack'] is String ? int.parse(json['Attack']) : json['Attack'],
      Defense: json['Defense'] is String ? int.parse(json['Defense']) : json['Defense'],
      SpAttack: json['Sp. Attack'] is String ? int.parse(json['Sp. Attack']) : json['Sp. Attack'],
      SpDefense: json['Sp. Defense'] is String ? int.parse(json['Sp. Defense']) : json['Sp. Defense'],
      Speed: json['Speed'] is String ? int.parse(json['Speed']) : json['Speed'],
    );

Map<String, dynamic> _$BaseStatsToJson(BaseStats instance) => <String, dynamic>{
      'HP': instance.HP,
      'Attack': instance.Attack,
      'Defense': instance.Defense,
      'SpAttack': instance.SpAttack,
      'SpDefense': instance.SpDefense,
      'Speed': instance.Speed,
    };
