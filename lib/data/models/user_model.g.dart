// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String,
      photoURL: json['photoURL'] as String?,
      fashionArchetype: json['fashionArchetype'] == null
          ? null
          : FashionArchetype.fromJson(
              json['fashionArchetype'] as Map<String, dynamic>),
      preferences: json['preferences'] == null
          ? null
          : UserPreferences.fromJson(
              json['preferences'] as Map<String, dynamic>),
      location: json['location'] == null
          ? null
          : UserLocation.fromJson(json['location'] as Map<String, dynamic>),
      isOnboardingComplete: json['isOnboardingComplete'] as bool? ?? false,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'displayName': instance.displayName,
      'photoURL': instance.photoURL,
      'fashionArchetype': instance.fashionArchetype,
      'preferences': instance.preferences,
      'location': instance.location,
      'isOnboardingComplete': instance.isOnboardingComplete,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

FashionArchetype _$FashionArchetypeFromJson(Map<String, dynamic> json) =>
    FashionArchetype(
      type: $enumDecode(_$ArchetypeTypeEnumMap, json['type']),
      confidence: (json['confidence'] as num).toDouble(),
      description: json['description'] as String?,
      characteristics: (json['characteristics'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$FashionArchetypeToJson(FashionArchetype instance) =>
    <String, dynamic>{
      'type': _$ArchetypeTypeEnumMap[instance.type]!,
      'confidence': instance.confidence,
      'description': instance.description,
      'characteristics': instance.characteristics,
    };

const _$ArchetypeTypeEnumMap = {
  ArchetypeType.minimalist: 'minimalist',
  ArchetypeType.grunge: 'grunge',
  ArchetypeType.streetwear: 'streetwear',
  ArchetypeType.oldMoney: 'old_money',
  ArchetypeType.bohemian: 'bohemian',
  ArchetypeType.classic: 'classic',
  ArchetypeType.avantGarde: 'avant_garde',
  ArchetypeType.casual: 'casual',
};

UserPreferences _$UserPreferencesFromJson(Map<String, dynamic> json) =>
    UserPreferences(
      colorPreferences: (json['color_preferences'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      brandPreferences: (json['brand_preferences'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      priceRange: json['price_range'] == null
          ? null
          : PriceRange.fromJson(json['price_range'] as Map<String, dynamic>),
      sizeInfo: json['size_info'] == null
          ? null
          : SizeInfo.fromJson(json['size_info'] as Map<String, dynamic>),
      stylePreferences: (json['style_preferences'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      dislikedItems: (json['disliked_items'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      sustainabilityPreference: $enumDecodeNullable(
              _$SustainabilityLevelEnumMap,
              json['sustainability_preference']) ??
          SustainabilityLevel.medium,
      notificationsEnabled: json['notifications_enabled'] as bool? ?? true,
      locationSharingEnabled:
          json['location_sharing_enabled'] as bool? ?? false,
    );

Map<String, dynamic> _$UserPreferencesToJson(UserPreferences instance) =>
    <String, dynamic>{
      'color_preferences': instance.colorPreferences,
      'brand_preferences': instance.brandPreferences,
      'price_range': instance.priceRange,
      'size_info': instance.sizeInfo,
      'style_preferences': instance.stylePreferences,
      'disliked_items': instance.dislikedItems,
      'sustainability_preference':
          _$SustainabilityLevelEnumMap[instance.sustainabilityPreference]!,
      'notifications_enabled': instance.notificationsEnabled,
      'location_sharing_enabled': instance.locationSharingEnabled,
    };

const _$SustainabilityLevelEnumMap = {
  SustainabilityLevel.low: 'low',
  SustainabilityLevel.medium: 'medium',
  SustainabilityLevel.high: 'high',
  SustainabilityLevel.veryHigh: 'very_high',
};

UserLocation _$UserLocationFromJson(Map<String, dynamic> json) => UserLocation(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      city: json['city'] as String?,
      country: json['country'] as String?,
      lastUpdated: json['last_updated'] == null
          ? null
          : DateTime.parse(json['last_updated'] as String),
    );

Map<String, dynamic> _$UserLocationToJson(UserLocation instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'city': instance.city,
      'country': instance.country,
      'last_updated': instance.lastUpdated?.toIso8601String(),
    };

PriceRange _$PriceRangeFromJson(Map<String, dynamic> json) => PriceRange(
      min: (json['min'] as num).toDouble(),
      max: (json['max'] as num).toDouble(),
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$PriceRangeToJson(PriceRange instance) =>
    <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
      'currency': instance.currency,
    };

SizeInfo _$SizeInfoFromJson(Map<String, dynamic> json) => SizeInfo(
      shirtSize: json['shirt_size'] as String?,
      pantSize: json['pant_size'] as String?,
      shoeSize: json['shoe_size'] as String?,
      measurements: (json['measurements'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
    );

Map<String, dynamic> _$SizeInfoToJson(SizeInfo instance) => <String, dynamic>{
      'shirt_size': instance.shirtSize,
      'pant_size': instance.pantSize,
      'shoe_size': instance.shoeSize,
      'measurements': instance.measurements,
    };
