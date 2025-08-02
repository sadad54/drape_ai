// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clothing_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClothingItemModel _$ClothingItemModelFromJson(Map<String, dynamic> json) =>
    ClothingItemModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      imageUrl: json['image_url'] as String,
      category: $enumDecode(_$ClothingCategoryEnumMap, json['category']),
      colors:
          (json['colors'] as List<dynamic>).map((e) => e as String).toList(),
      brand: json['brand'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      seasonality: (json['seasonality'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$SeasonEnumMap, e))
              .toList() ??
          const [],
      occasions: (json['occasions'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$OccasionEnumMap, e))
              .toList() ??
          const [],
      materials: (json['materials'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      size: json['size'] as String?,
      purchaseDate: json['purchase_date'] == null
          ? null
          : DateTime.parse(json['purchase_date'] as String),
      purchasePrice: (json['purchase_price'] as num?)?.toDouble(),
      sustainabilityScore: (json['sustainability_score'] as num?)?.toDouble(),
      wearCount: (json['wear_count'] as num?)?.toInt() ?? 0,
      lastWornDate: json['last_worn_date'] == null
          ? null
          : DateTime.parse(json['last_worn_date'] as String),
      isFavorite: json['is_favorite'] as bool? ?? false,
      isVisible: json['is_visible'] as bool? ?? true,
      confidence: (json['confidence'] as num?)?.toDouble(),
      detectionMetadata: json['detection_metadata'] == null
          ? null
          : DetectionMetadata.fromJson(
              json['detection_metadata'] as Map<String, dynamic>),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ClothingItemModelToJson(ClothingItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'image_url': instance.imageUrl,
      'category': _$ClothingCategoryEnumMap[instance.category]!,
      'colors': instance.colors,
      'brand': instance.brand,
      'name': instance.name,
      'description': instance.description,
      'tags': instance.tags,
      'seasonality':
          instance.seasonality.map((e) => _$SeasonEnumMap[e]!).toList(),
      'occasions':
          instance.occasions.map((e) => _$OccasionEnumMap[e]!).toList(),
      'materials': instance.materials,
      'size': instance.size,
      'purchase_date': instance.purchaseDate?.toIso8601String(),
      'purchase_price': instance.purchasePrice,
      'sustainability_score': instance.sustainabilityScore,
      'wear_count': instance.wearCount,
      'last_worn_date': instance.lastWornDate?.toIso8601String(),
      'is_favorite': instance.isFavorite,
      'is_visible': instance.isVisible,
      'confidence': instance.confidence,
      'detection_metadata': instance.detectionMetadata,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
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

const _$SeasonEnumMap = {
  Season.spring: 'spring',
  Season.summer: 'summer',
  Season.fall: 'fall',
  Season.winter: 'winter',
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

DetectionMetadata _$DetectionMetadataFromJson(Map<String, dynamic> json) =>
    DetectionMetadata(
      modelVersion: json['model_version'] as String,
      detectedFeatures: json['detected_features'] as Map<String, dynamic>,
      boundingBox: json['bounding_box'] == null
          ? null
          : BoundingBox.fromJson(json['bounding_box'] as Map<String, dynamic>),
      processedAt: json['processed_at'] == null
          ? null
          : DateTime.parse(json['processed_at'] as String),
      processingTime: (json['processing_time'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DetectionMetadataToJson(DetectionMetadata instance) =>
    <String, dynamic>{
      'model_version': instance.modelVersion,
      'detected_features': instance.detectedFeatures,
      'bounding_box': instance.boundingBox,
      'processed_at': instance.processedAt?.toIso8601String(),
      'processing_time': instance.processingTime,
    };

BoundingBox _$BoundingBoxFromJson(Map<String, dynamic> json) => BoundingBox(
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
    );

Map<String, dynamic> _$BoundingBoxToJson(BoundingBox instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'width': instance.width,
      'height': instance.height,
    };
