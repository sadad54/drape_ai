// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outfit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutfitModel _$OutfitModelFromJson(Map<String, dynamic> json) => OutfitModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      clothingItems: (json['clothing_items'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      description: json['description'] as String?,
      imageUrl: json['image_url'] as String?,
      occasion: $enumDecodeNullable(_$OccasionEnumMap, json['occasion']) ??
          Occasion.casual,
      season:
          $enumDecodeNullable(_$SeasonEnumMap, json['season']) ?? Season.spring,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      styleScore: (json['style_score'] as num?)?.toDouble(),
      colorHarmonyScore: (json['color_harmony_score'] as num?)?.toDouble(),
      sustainabilityScore: (json['sustainability_score'] as num?)?.toDouble(),
      wearCount: (json['wear_count'] as num?)?.toInt() ?? 0,
      lastWornDate: json['last_worn_date'] == null
          ? null
          : DateTime.parse(json['last_worn_date'] as String),
      isFavorite: json['is_favorite'] as bool? ?? false,
      isPublic: json['is_public'] as bool? ?? false,
      likes: (json['likes'] as num?)?.toInt() ?? 0,
      generationMetadata: json['generation_metadata'] == null
          ? null
          : OutfitGenerationMetadata.fromJson(
              json['generation_metadata'] as Map<String, dynamic>),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$OutfitModelToJson(OutfitModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'name': instance.name,
      'clothing_items': instance.clothingItems,
      'description': instance.description,
      'image_url': instance.imageUrl,
      'occasion': _$OccasionEnumMap[instance.occasion]!,
      'season': _$SeasonEnumMap[instance.season]!,
      'tags': instance.tags,
      'style_score': instance.styleScore,
      'color_harmony_score': instance.colorHarmonyScore,
      'sustainability_score': instance.sustainabilityScore,
      'wear_count': instance.wearCount,
      'last_worn_date': instance.lastWornDate?.toIso8601String(),
      'is_favorite': instance.isFavorite,
      'is_public': instance.isPublic,
      'likes': instance.likes,
      'generation_metadata': instance.generationMetadata,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

const _$OccasionEnumMap = {
  Occasion.casual: 'casual',
  Occasion.work: 'work',
  Occasion.formal: 'formal',
  Occasion.party: 'party',
  Occasion.sports: 'sports',
  Occasion.travel: 'travel',
  Occasion.date: 'date',
  Occasion.outdoor: 'outdoor',
};

const _$SeasonEnumMap = {
  Season.spring: 'spring',
  Season.summer: 'summer',
  Season.fall: 'fall',
  Season.winter: 'winter',
};

OutfitGenerationMetadata _$OutfitGenerationMetadataFromJson(
        Map<String, dynamic> json) =>
    OutfitGenerationMetadata(
      generationType:
          $enumDecode(_$OutfitGenerationTypeEnumMap, json['generation_type']),
      algorithm: json['algorithm'] as String,
      parameters: json['parameters'] as Map<String, dynamic>?,
      confidence: (json['confidence'] as num?)?.toDouble(),
      alternatives: (json['alternatives'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      reasoningSteps: (json['reasoning_steps'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      generatedAt: json['generated_at'] == null
          ? null
          : DateTime.parse(json['generated_at'] as String),
    );

Map<String, dynamic> _$OutfitGenerationMetadataToJson(
        OutfitGenerationMetadata instance) =>
    <String, dynamic>{
      'generation_type':
          _$OutfitGenerationTypeEnumMap[instance.generationType]!,
      'algorithm': instance.algorithm,
      'parameters': instance.parameters,
      'confidence': instance.confidence,
      'alternatives': instance.alternatives,
      'reasoning_steps': instance.reasoningSteps,
      'generated_at': instance.generatedAt?.toIso8601String(),
    };

const _$OutfitGenerationTypeEnumMap = {
  OutfitGenerationType.aiSuggested: 'ai_suggested',
  OutfitGenerationType.userCreated: 'user_created',
  OutfitGenerationType.trendingInspired: 'trending_inspired',
  OutfitGenerationType.weatherBased: 'weather_based',
  OutfitGenerationType.occasionBased: 'occasion_based',
};

OutfitSuggestion _$OutfitSuggestionFromJson(Map<String, dynamic> json) =>
    OutfitSuggestion(
      outfit: OutfitModel.fromJson(json['outfit'] as Map<String, dynamic>),
      confidence: (json['confidence'] as num).toDouble(),
      reasoning: json['reasoning'] as String,
      weatherMatch: (json['weather_match'] as num?)?.toDouble(),
      occasionMatch: (json['occasion_match'] as num?)?.toDouble(),
      styleMatch: (json['style_match'] as num?)?.toDouble(),
      colorHarmony: (json['color_harmony'] as num?)?.toDouble(),
      alternatives: (json['alternatives'] as List<dynamic>?)
              ?.map((e) => OutfitModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$OutfitSuggestionToJson(OutfitSuggestion instance) =>
    <String, dynamic>{
      'outfit': instance.outfit,
      'confidence': instance.confidence,
      'reasoning': instance.reasoning,
      'weather_match': instance.weatherMatch,
      'occasion_match': instance.occasionMatch,
      'style_match': instance.styleMatch,
      'color_harmony': instance.colorHarmony,
      'alternatives': instance.alternatives,
    };

VirtualTryOnResult _$VirtualTryOnResultFromJson(Map<String, dynamic> json) =>
    VirtualTryOnResult(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      outfitId: json['outfit_id'] as String,
      originalImageUrl: json['original_image_url'] as String,
      processedImageUrl: json['processed_image_url'] as String,
      confidence: (json['confidence'] as num?)?.toDouble(),
      processingTime: (json['processing_time'] as num?)?.toDouble(),
      feedback: json['feedback'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$VirtualTryOnResultToJson(VirtualTryOnResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'outfit_id': instance.outfitId,
      'original_image_url': instance.originalImageUrl,
      'processed_image_url': instance.processedImageUrl,
      'confidence': instance.confidence,
      'processing_time': instance.processingTime,
      'feedback': instance.feedback,
      'created_at': instance.createdAt?.toIso8601String(),
    };

OutfitBreakdown _$OutfitBreakdownFromJson(Map<String, dynamic> json) =>
    OutfitBreakdown(
      id: json['id'] as String,
      originalImageUrl: json['original_image_url'] as String,
      detectedItems: (json['detected_items'] as List<dynamic>)
          .map((e) => DetectedOutfitItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      confidence: (json['confidence'] as num).toDouble(),
      shoppingLinks: (json['shopping_links'] as List<dynamic>?)
              ?.map((e) => ShoppingLink.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      totalEstimatedPrice: (json['total_estimated_price'] as num?)?.toDouble(),
      processingMetadata: json['processing_metadata'] as Map<String, dynamic>?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$OutfitBreakdownToJson(OutfitBreakdown instance) =>
    <String, dynamic>{
      'id': instance.id,
      'original_image_url': instance.originalImageUrl,
      'detected_items': instance.detectedItems,
      'confidence': instance.confidence,
      'shopping_links': instance.shoppingLinks,
      'total_estimated_price': instance.totalEstimatedPrice,
      'processing_metadata': instance.processingMetadata,
      'created_at': instance.createdAt?.toIso8601String(),
    };

DetectedOutfitItem _$DetectedOutfitItemFromJson(Map<String, dynamic> json) =>
    DetectedOutfitItem(
      category: $enumDecode(_$ClothingCategoryEnumMap, json['category']),
      description: json['description'] as String,
      colors:
          (json['colors'] as List<dynamic>).map((e) => e as String).toList(),
      boundingBox:
          BoundingBox.fromJson(json['bounding_box'] as Map<String, dynamic>),
      confidence: (json['confidence'] as num).toDouble(),
      brand: json['brand'] as String?,
      estimatedPrice: (json['estimated_price'] as num?)?.toDouble(),
      similarItems: (json['similar_items'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$DetectedOutfitItemToJson(DetectedOutfitItem instance) =>
    <String, dynamic>{
      'category': _$ClothingCategoryEnumMap[instance.category]!,
      'description': instance.description,
      'colors': instance.colors,
      'bounding_box': instance.boundingBox,
      'confidence': instance.confidence,
      'brand': instance.brand,
      'estimated_price': instance.estimatedPrice,
      'similar_items': instance.similarItems,
    };

const _$ClothingCategoryEnumMap = {
  ClothingCategory.tops: 'tops',
  ClothingCategory.bottoms: 'bottoms',
  ClothingCategory.dresses: 'dresses',
  ClothingCategory.outerwear: 'outerwear',
  ClothingCategory.footwear: 'footwear',
  ClothingCategory.accessories: 'accessories',
  ClothingCategory.undergarments: 'undergarments',
};

ShoppingLink _$ShoppingLinkFromJson(Map<String, dynamic> json) => ShoppingLink(
      retailer: json['retailer'] as String,
      url: json['url'] as String,
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String,
      productName: json['product_name'] as String?,
      imageUrl: json['image_url'] as String?,
      availability: json['availability'] as String?,
    );

Map<String, dynamic> _$ShoppingLinkToJson(ShoppingLink instance) =>
    <String, dynamic>{
      'retailer': instance.retailer,
      'url': instance.url,
      'price': instance.price,
      'currency': instance.currency,
      'product_name': instance.productName,
      'image_url': instance.imageUrl,
      'availability': instance.availability,
    };
