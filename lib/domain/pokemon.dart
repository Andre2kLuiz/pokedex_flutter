
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon.freezed.dart';

@freezed
class Pokemon with _$Pokemon {
  const factory Pokemon({
    required String id,
    required Map<String, String> name,
    required List<String> type,
    required Map<String, int> base,
    String? imgUrl,
  }) = _Pokemon;

}