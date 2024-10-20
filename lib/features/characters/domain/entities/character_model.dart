import 'package:freezed_annotation/freezed_annotation.dart';

part 'character_model.freezed.dart';
part 'character_model.g.dart';

T enumFromString<T>(Iterable<T> values, String value, T unknown) {
  return values.firstWhere(
        (element) => element.toString().split('.').last.toLowerCase() == value.toLowerCase(),
    orElse: () => unknown,
  );
}

enum CharacterStatus {
  alive,
  dead,
  unknown;

  factory CharacterStatus.fromString(String value) {
    return enumFromString(CharacterStatus.values, value, CharacterStatus.unknown);
  }

  @override
  String toString() => name;
}

enum CharacterSpecies {
  human,
  alien,
  unknown;

  factory CharacterSpecies.fromString(String value) {
    return enumFromString(CharacterSpecies.values, value, CharacterSpecies.unknown);
  }

  @override
  String toString() => name;
}

enum CharacterGender {
  female,
  male,
  unknown;

  factory CharacterGender.fromString(String value) {
    return enumFromString(CharacterGender.values, value, CharacterGender.unknown);
  }

  @override
  String toString() => name;
}

@freezed
class CharacterModel with _$CharacterModel {
  const factory CharacterModel({
    required int id,
    required String name,
    @JsonKey(fromJson: CharacterStatus.fromString) required CharacterStatus status,
    @JsonKey(fromJson: CharacterSpecies.fromString) required CharacterSpecies species,
    required String type,
    @JsonKey(fromJson: CharacterGender.fromString) required CharacterGender gender,
    required String image,
    required LocationShort origin,
    required LocationShort location,
    required List<String> episode,
    required String url,
    required String created,
    @Default(false) bool isLiked,
  }) = _CharacterModel;

  factory CharacterModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterModelFromJson(json);
}

@freezed
class LocationShort with _$LocationShort {
  const factory LocationShort({
    required String name,
    required String url,
  }) = _LocationShort;

  factory LocationShort.fromJson(Map<String, dynamic> json) =>
      _$LocationShortFromJson(json);
}

