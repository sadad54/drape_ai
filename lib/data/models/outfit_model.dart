import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'clothing_item_model.dart';

part 'outfit_model.g.dart';

@JsonSerializable()
class OutfitModel extends Equatable {
  const OutfitModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.clothingItems,
    this.description,
    this.imageUrl,
    this.occasion = Occasion.casual,
    this.season = Season.spring,
    this.tags = const [],
    this.styleScore,
    this.colorHarmonyScore,
    this.sustainabilityScore,
    this.wearCount = 0,
    this.lastWornDate,
    this.isFavorite = false,
    this.isPublic = false,
    this.likes = 0,
    this.generationMetadata,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  @JsonKey(name: 'user_id')
  final String userId;
  final String name;
  @JsonKey(name: 'clothing_items')
  final List<String> clothingItems; // IDs of clothing items
  final String? description;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  final Occasion occasion;
  final Season season;
  final List<String> tags;
  @JsonKey(name: 'style_score')
  final double? styleScore;
  @JsonKey(name: 'color_harmony_score')
  final double? colorHarmonyScore;
  @JsonKey(name: 'sustainability_score')
  final double? sustainabilityScore;
  @JsonKey(name: 'wear_count')
  final int wearCount;
  @JsonKey(name: 'last_worn_date')
  final DateTime? lastWornDate;
  @JsonKey(name: 'is_favorite')
  final bool isFavorite;
  @JsonKey(name: 'is_public')
  final bool isPublic;
  final int likes;
  @JsonKey(name: 'generation_metadata')
  final OutfitGenerationMetadata? generationMetadata;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  factory OutfitModel.fromJson(Map<String, dynamic> json) =>
      _$OutfitModelFromJson(json);

  Map<String, dynamic> toJson() => _$OutfitModelToJson(this);

  OutfitModel copyWith({
    String? id,
    String? userId,
    String? name,
    List<String>? clothingItems,
    String? description,
    String? imageUrl,
    Occasion? occasion,
    Season? season,
    List<String>? tags,
    double? styleScore,
    double? colorHarmonyScore,
    double? sustainabilityScore,
    int? wearCount,
    DateTime? lastWornDate,
    bool? isFavorite,
    bool? isPublic,
    int? likes,
    OutfitGenerationMetadata? generationMetadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return OutfitModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      clothingItems: clothingItems ?? this.clothingItems,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      occasion: occasion ?? this.occasion,
      season: season ?? this.season,
      tags: tags ?? this.tags,
      styleScore: styleScore ?? this.styleScore,
      colorHarmonyScore: colorHarmonyScore ?? this.colorHarmonyScore,
      sustainabilityScore: sustainabilityScore ?? this.sustainabilityScore,
      wearCount: wearCount ?? this.wearCount,
      lastWornDate: lastWornDate ?? this.lastWornDate,
      isFavorite: isFavorite ?? this.isFavorite,
      isPublic: isPublic ?? this.isPublic,
      likes: likes ?? this.likes,
      generationMetadata: generationMetadata ?? this.generationMetadata,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        clothingItems,
        description,
        imageUrl,
        occasion,
        season,
        tags,
        styleScore,
        colorHarmonyScore,
        sustainabilityScore,
        wearCount,
        lastWornDate,
        isFavorite,
        isPublic,
        likes,
        generationMetadata,
        createdAt,
        updatedAt,
      ];
}

@JsonSerializable()
class OutfitGenerationMetadata extends Equatable {
  const OutfitGenerationMetadata({
    required this.generationType,
    required this.algorithm,
    this.parameters,
    this.confidence,
    this.alternatives,
    this.reasoningSteps,
    this.generatedAt,
  });

  @JsonKey(name: 'generation_type')
  final OutfitGenerationType generationType;
  final String algorithm;
  final Map<String, dynamic>? parameters;
  final double? confidence;
  final List<String>? alternatives; // Alternative outfit IDs
  @JsonKey(name: 'reasoning_steps')
  final List<String>? reasoningSteps;
  @JsonKey(name: 'generated_at')
  final DateTime? generatedAt;

  factory OutfitGenerationMetadata.fromJson(Map<String, dynamic> json) =>
      _$OutfitGenerationMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$OutfitGenerationMetadataToJson(this);

  @override
  List<Object?> get props => [
        generationType,
        algorithm,
        parameters,
        confidence,
        alternatives,
        reasoningSteps,
        generatedAt,
      ];
}

@JsonSerializable()
class OutfitSuggestion extends Equatable {
  const OutfitSuggestion({
    required this.outfit,
    required this.confidence,
    required this.reasoning,
    this.weatherMatch,
    this.occasionMatch,
    this.styleMatch,
    this.colorHarmony,
    this.alternatives = const [],
  });

  final OutfitModel outfit;
  final double confidence;
  final String reasoning;
  @JsonKey(name: 'weather_match')
  final double? weatherMatch;
  @JsonKey(name: 'occasion_match')
  final double? occasionMatch;
  @JsonKey(name: 'style_match')
  final double? styleMatch;
  @JsonKey(name: 'color_harmony')
  final double? colorHarmony;
  final List<OutfitModel> alternatives;

  factory OutfitSuggestion.fromJson(Map<String, dynamic> json) =>
      _$OutfitSuggestionFromJson(json);

  Map<String, dynamic> toJson() => _$OutfitSuggestionToJson(this);

  @override
  List<Object?> get props => [
        outfit,
        confidence,
        reasoning,
        weatherMatch,
        occasionMatch,
        styleMatch,
        colorHarmony,
        alternatives,
      ];
}

@JsonSerializable()
class VirtualTryOnResult extends Equatable {
  const VirtualTryOnResult({
    required this.id,
    required this.userId,
    required this.outfitId,
    required this.originalImageUrl,
    required this.processedImageUrl,
    this.confidence,
    this.processingTime,
    this.feedback,
    this.createdAt,
  });

  final String id;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'outfit_id')
  final String outfitId;
  @JsonKey(name: 'original_image_url')
  final String originalImageUrl;
  @JsonKey(name: 'processed_image_url')
  final String processedImageUrl;
  final double? confidence;
  @JsonKey(name: 'processing_time')
  final double? processingTime;
  final String? feedback;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  factory VirtualTryOnResult.fromJson(Map<String, dynamic> json) =>
      _$VirtualTryOnResultFromJson(json);

  Map<String, dynamic> toJson() => _$VirtualTryOnResultToJson(this);

  @override
  List<Object?> get props => [
        id,
        userId,
        outfitId,
        originalImageUrl,
        processedImageUrl,
        confidence,
        processingTime,
        feedback,
        createdAt,
      ];
}

@JsonSerializable()
class OutfitBreakdown extends Equatable {
  const OutfitBreakdown({
    required this.id,
    required this.originalImageUrl,
    required this.detectedItems,
    required this.confidence,
    this.shoppingLinks = const [],
    this.totalEstimatedPrice,
    this.processingMetadata,
    this.createdAt,
  });

  final String id;
  @JsonKey(name: 'original_image_url')
  final String originalImageUrl;
  @JsonKey(name: 'detected_items')
  final List<DetectedOutfitItem> detectedItems;
  final double confidence;
  @JsonKey(name: 'shopping_links')
  final List<ShoppingLink> shoppingLinks;
  @JsonKey(name: 'total_estimated_price')
  final double? totalEstimatedPrice;
  @JsonKey(name: 'processing_metadata')
  final Map<String, dynamic>? processingMetadata;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  factory OutfitBreakdown.fromJson(Map<String, dynamic> json) =>
      _$OutfitBreakdownFromJson(json);

  Map<String, dynamic> toJson() => _$OutfitBreakdownToJson(this);

  @override
  List<Object?> get props => [
        id,
        originalImageUrl,
        detectedItems,
        confidence,
        shoppingLinks,
        totalEstimatedPrice,
        processingMetadata,
        createdAt,
      ];
}

@JsonSerializable()
class DetectedOutfitItem extends Equatable {
  const DetectedOutfitItem({
    required this.category,
    required this.description,
    required this.colors,
    required this.boundingBox,
    required this.confidence,
    this.brand,
    this.estimatedPrice,
    this.similarItems = const [],
  });

  final ClothingCategory category;
  final String description;
  final List<String> colors;
  @JsonKey(name: 'bounding_box')
  final BoundingBox boundingBox;
  final double confidence;
  final String? brand;
  @JsonKey(name: 'estimated_price')
  final double? estimatedPrice;
  @JsonKey(name: 'similar_items')
  final List<String> similarItems; // IDs of similar items in user's closet

  factory DetectedOutfitItem.fromJson(Map<String, dynamic> json) =>
      _$DetectedOutfitItemFromJson(json);

  Map<String, dynamic> toJson() => _$DetectedOutfitItemToJson(this);

  @override
  List<Object?> get props => [
        category,
        description,
        colors,
        boundingBox,
        confidence,
        brand,
        estimatedPrice,
        similarItems,
      ];
}

@JsonSerializable()
class ShoppingLink extends Equatable {
  const ShoppingLink({
    required this.retailer,
    required this.url,
    required this.price,
    required this.currency,
    this.productName,
    this.imageUrl,
    this.availability,
  });

  final String retailer;
  final String url;
  final double price;
  final String currency;
  @JsonKey(name: 'product_name')
  final String? productName;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  final String? availability;

  factory ShoppingLink.fromJson(Map<String, dynamic> json) =>
      _$ShoppingLinkFromJson(json);

  Map<String, dynamic> toJson() => _$ShoppingLinkToJson(this);

  @override
  List<Object?> get props => [
        retailer,
        url,
        price,
        currency,
        productName,
        imageUrl,
        availability,
      ];
}

enum OutfitGenerationType {
  @JsonValue('ai_suggested')
  aiSuggested,
  @JsonValue('user_created')
  userCreated,
  @JsonValue('trending_inspired')
  trendingInspired,
  @JsonValue('weather_based')
  weatherBased,
  @JsonValue('occasion_based')
  occasionBased,
}

extension OutfitGenerationTypeExtension on OutfitGenerationType {
  String get displayName {
    switch (this) {
      case OutfitGenerationType.aiSuggested:
        return 'AI Suggested';
      case OutfitGenerationType.userCreated:
        return 'User Created';
      case OutfitGenerationType.trendingInspired:
        return 'Trending Inspired';
      case OutfitGenerationType.weatherBased:
        return 'Weather Based';
      case OutfitGenerationType.occasionBased:
        return 'Occasion Based';
    }
  }

  String get description {
    switch (this) {
      case OutfitGenerationType.aiSuggested:
        return 'Generated by AI based on your style preferences';
      case OutfitGenerationType.userCreated:
        return 'Manually created by you';
      case OutfitGenerationType.trendingInspired:
        return 'Inspired by current fashion trends';
      case OutfitGenerationType.weatherBased:
        return 'Optimized for current weather conditions';
      case OutfitGenerationType.occasionBased:
        return 'Tailored for specific occasions';
    }
  }
}
