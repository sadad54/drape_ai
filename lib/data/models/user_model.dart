import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  const UserModel({
    required this.id,
    required this.email,
    required this.displayName,
    this.photoURL,
    this.fashionArchetype,
    this.preferences,
    this.location,
    this.isOnboardingComplete = false,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String email;
  final String displayName;
  final String? photoURL;
  final FashionArchetype? fashionArchetype;
  final UserPreferences? preferences;
  final UserLocation? location;
  final bool isOnboardingComplete;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoURL,
    FashionArchetype? fashionArchetype,
    UserPreferences? preferences,
    UserLocation? location,
    bool? isOnboardingComplete,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoURL: photoURL ?? this.photoURL,
      fashionArchetype: fashionArchetype ?? this.fashionArchetype,
      preferences: preferences ?? this.preferences,
      location: location ?? this.location,
      isOnboardingComplete: isOnboardingComplete ?? this.isOnboardingComplete,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        displayName,
        photoURL,
        fashionArchetype,
        preferences,
        location,
        isOnboardingComplete,
        createdAt,
        updatedAt,
      ];
}

@JsonSerializable()
class FashionArchetype extends Equatable {
  const FashionArchetype({
    required this.type,
    required this.confidence,
    this.description,
    this.characteristics,
  });

  final ArchetypeType type;
  final double confidence;
  final String? description;
  final List<String>? characteristics;

  factory FashionArchetype.fromJson(Map<String, dynamic> json) =>
      _$FashionArchetypeFromJson(json);

  Map<String, dynamic> toJson() => _$FashionArchetypeToJson(this);

  @override
  List<Object?> get props => [type, confidence, description, characteristics];
}

@JsonSerializable()
class UserPreferences extends Equatable {
  const UserPreferences({
    this.colorPreferences = const [],
    this.brandPreferences = const [],
    this.priceRange,
    this.sizeInfo,
    this.stylePreferences = const [],
    this.dislikedItems = const [],
    this.sustainabilityPreference = SustainabilityLevel.medium,
    this.notificationsEnabled = true,
    this.locationSharingEnabled = false,
  });

  @JsonKey(name: 'color_preferences')
  final List<String> colorPreferences;
  @JsonKey(name: 'brand_preferences')
  final List<String> brandPreferences;
  @JsonKey(name: 'price_range')
  final PriceRange? priceRange;
  @JsonKey(name: 'size_info')
  final SizeInfo? sizeInfo;
  @JsonKey(name: 'style_preferences')
  final List<String> stylePreferences;
  @JsonKey(name: 'disliked_items')
  final List<String> dislikedItems;
  @JsonKey(name: 'sustainability_preference')
  final SustainabilityLevel sustainabilityPreference;
  @JsonKey(name: 'notifications_enabled')
  final bool notificationsEnabled;
  @JsonKey(name: 'location_sharing_enabled')
  final bool locationSharingEnabled;

  factory UserPreferences.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesFromJson(json);

  Map<String, dynamic> toJson() => _$UserPreferencesToJson(this);

  UserPreferences copyWith({
    List<String>? colorPreferences,
    List<String>? brandPreferences,
    PriceRange? priceRange,
    SizeInfo? sizeInfo,
    List<String>? stylePreferences,
    List<String>? dislikedItems,
    SustainabilityLevel? sustainabilityPreference,
    bool? notificationsEnabled,
    bool? locationSharingEnabled,
  }) {
    return UserPreferences(
      colorPreferences: colorPreferences ?? this.colorPreferences,
      brandPreferences: brandPreferences ?? this.brandPreferences,
      priceRange: priceRange ?? this.priceRange,
      sizeInfo: sizeInfo ?? this.sizeInfo,
      stylePreferences: stylePreferences ?? this.stylePreferences,
      dislikedItems: dislikedItems ?? this.dislikedItems,
      sustainabilityPreference:
          sustainabilityPreference ?? this.sustainabilityPreference,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      locationSharingEnabled:
          locationSharingEnabled ?? this.locationSharingEnabled,
    );
  }

  @override
  List<Object?> get props => [
        colorPreferences,
        brandPreferences,
        priceRange,
        sizeInfo,
        stylePreferences,
        dislikedItems,
        sustainabilityPreference,
        notificationsEnabled,
        locationSharingEnabled,
      ];
}

@JsonSerializable()
class UserLocation extends Equatable {
  const UserLocation({
    required this.latitude,
    required this.longitude,
    this.city,
    this.country,
    this.lastUpdated,
  });

  final double latitude;
  final double longitude;
  final String? city;
  final String? country;
  @JsonKey(name: 'last_updated')
  final DateTime? lastUpdated;

  factory UserLocation.fromJson(Map<String, dynamic> json) =>
      _$UserLocationFromJson(json);

  Map<String, dynamic> toJson() => _$UserLocationToJson(this);

  @override
  List<Object?> get props => [latitude, longitude, city, country, lastUpdated];
}

@JsonSerializable()
class PriceRange extends Equatable {
  const PriceRange({
    required this.min,
    required this.max,
    required this.currency,
  });

  final double min;
  final double max;
  final String currency;

  factory PriceRange.fromJson(Map<String, dynamic> json) =>
      _$PriceRangeFromJson(json);

  Map<String, dynamic> toJson() => _$PriceRangeToJson(this);

  @override
  List<Object?> get props => [min, max, currency];
}

@JsonSerializable()
class SizeInfo extends Equatable {
  const SizeInfo({
    this.shirtSize,
    this.pantSize,
    this.shoeSize,
    this.measurements,
  });

  @JsonKey(name: 'shirt_size')
  final String? shirtSize;
  @JsonKey(name: 'pant_size')
  final String? pantSize;
  @JsonKey(name: 'shoe_size')
  final String? shoeSize;
  final Map<String, double>? measurements;

  factory SizeInfo.fromJson(Map<String, dynamic> json) =>
      _$SizeInfoFromJson(json);

  Map<String, dynamic> toJson() => _$SizeInfoToJson(this);

  @override
  List<Object?> get props => [shirtSize, pantSize, shoeSize, measurements];
}

enum ArchetypeType {
  @JsonValue('minimalist')
  minimalist,
  @JsonValue('grunge')
  grunge,
  @JsonValue('streetwear')
  streetwear,
  @JsonValue('old_money')
  oldMoney,
  @JsonValue('bohemian')
  bohemian,
  @JsonValue('classic')
  classic,
  @JsonValue('avant_garde')
  avantGarde,
  @JsonValue('casual')
  casual,
}

enum SustainabilityLevel {
  @JsonValue('low')
  low,
  @JsonValue('medium')
  medium,
  @JsonValue('high')
  high,
  @JsonValue('very_high')
  veryHigh,
}

extension ArchetypeTypeExtension on ArchetypeType {
  String get displayName {
    switch (this) {
      case ArchetypeType.minimalist:
        return 'Minimalist';
      case ArchetypeType.grunge:
        return 'Grunge';
      case ArchetypeType.streetwear:
        return 'Streetwear';
      case ArchetypeType.oldMoney:
        return 'Old Money';
      case ArchetypeType.bohemian:
        return 'Bohemian';
      case ArchetypeType.classic:
        return 'Classic';
      case ArchetypeType.avantGarde:
        return 'Avant-garde';
      case ArchetypeType.casual:
        return 'Casual';
    }
  }

  String get description {
    switch (this) {
      case ArchetypeType.minimalist:
        return 'Clean lines, neutral colors, and timeless pieces';
      case ArchetypeType.grunge:
        return 'Edgy, rebellious style with distressed elements';
      case ArchetypeType.streetwear:
        return 'Urban-inspired, comfortable, and trendy';
      case ArchetypeType.oldMoney:
        return 'Sophisticated, classic luxury with understated elegance';
      case ArchetypeType.bohemian:
        return 'Free-spirited, artistic, and eclectic';
      case ArchetypeType.classic:
        return 'Timeless, elegant, and professionally polished';
      case ArchetypeType.avantGarde:
        return 'Experimental, artistic, and boundary-pushing';
      case ArchetypeType.casual:
        return 'Comfortable, relaxed, and effortless';
    }
  }
}
