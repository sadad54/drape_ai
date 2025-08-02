import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'clothing_item_model.g.dart';

@JsonSerializable()
class ClothingItemModel extends Equatable {
  const ClothingItemModel({
    required this.id,
    required this.userId,
    required this.imageUrl,
    required this.category,
    required this.colors,
    this.brand,
    this.name,
    this.description,
    this.tags = const [],
    this.seasonality = const [],
    this.occasions = const [],
    this.materials = const [],
    this.size,
    this.purchaseDate,
    this.purchasePrice,
    this.sustainabilityScore,
    this.wearCount = 0,
    this.lastWornDate,
    this.isFavorite = false,
    this.isVisible = true,
    this.confidence,
    this.detectionMetadata,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'image_url')
  final String imageUrl;
  final ClothingCategory category;
  final List<String> colors;
  final String? brand;
  final String? name;
  final String? description;
  final List<String> tags;
  final List<Season> seasonality;
  final List<Occasion> occasions;
  final List<String> materials;
  final String? size;
  @JsonKey(name: 'purchase_date')
  final DateTime? purchaseDate;
  @JsonKey(name: 'purchase_price')
  final double? purchasePrice;
  @JsonKey(name: 'sustainability_score')
  final double? sustainabilityScore;
  @JsonKey(name: 'wear_count')
  final int wearCount;
  @JsonKey(name: 'last_worn_date')
  final DateTime? lastWornDate;
  @JsonKey(name: 'is_favorite')
  final bool isFavorite;
  @JsonKey(name: 'is_visible')
  final bool isVisible;
  final double? confidence;
  @JsonKey(name: 'detection_metadata')
  final DetectionMetadata? detectionMetadata;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  factory ClothingItemModel.fromJson(Map<String, dynamic> json) =>
      _$ClothingItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClothingItemModelToJson(this);

  ClothingItemModel copyWith({
    String? id,
    String? userId,
    String? imageUrl,
    ClothingCategory? category,
    List<String>? colors,
    String? brand,
    String? name,
    String? description,
    List<String>? tags,
    List<Season>? seasonality,
    List<Occasion>? occasions,
    List<String>? materials,
    String? size,
    DateTime? purchaseDate,
    double? purchasePrice,
    double? sustainabilityScore,
    int? wearCount,
    DateTime? lastWornDate,
    bool? isFavorite,
    bool? isVisible,
    double? confidence,
    DetectionMetadata? detectionMetadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ClothingItemModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      colors: colors ?? this.colors,
      brand: brand ?? this.brand,
      name: name ?? this.name,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      seasonality: seasonality ?? this.seasonality,
      occasions: occasions ?? this.occasions,
      materials: materials ?? this.materials,
      size: size ?? this.size,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      sustainabilityScore: sustainabilityScore ?? this.sustainabilityScore,
      wearCount: wearCount ?? this.wearCount,
      lastWornDate: lastWornDate ?? this.lastWornDate,
      isFavorite: isFavorite ?? this.isFavorite,
      isVisible: isVisible ?? this.isVisible,
      confidence: confidence ?? this.confidence,
      detectionMetadata: detectionMetadata ?? this.detectionMetadata,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        imageUrl,
        category,
        colors,
        brand,
        name,
        description,
        tags,
        seasonality,
        occasions,
        materials,
        size,
        purchaseDate,
        purchasePrice,
        sustainabilityScore,
        wearCount,
        lastWornDate,
        isFavorite,
        isVisible,
        confidence,
        detectionMetadata,
        createdAt,
        updatedAt,
      ];
}

@JsonSerializable()
class DetectionMetadata extends Equatable {
  const DetectionMetadata({
    required this.modelVersion,
    required this.detectedFeatures,
    this.boundingBox,
    this.processedAt,
    this.processingTime,
  });

  @JsonKey(name: 'model_version')
  final String modelVersion;
  @JsonKey(name: 'detected_features')
  final Map<String, dynamic> detectedFeatures;
  @JsonKey(name: 'bounding_box')
  final BoundingBox? boundingBox;
  @JsonKey(name: 'processed_at')
  final DateTime? processedAt;
  @JsonKey(name: 'processing_time')
  final double? processingTime;

  factory DetectionMetadata.fromJson(Map<String, dynamic> json) =>
      _$DetectionMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$DetectionMetadataToJson(this);

  @override
  List<Object?> get props => [
        modelVersion,
        detectedFeatures,
        boundingBox,
        processedAt,
        processingTime,
      ];
}

@JsonSerializable()
class BoundingBox extends Equatable {
  const BoundingBox({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });

  final double x;
  final double y;
  final double width;
  final double height;

  factory BoundingBox.fromJson(Map<String, dynamic> json) =>
      _$BoundingBoxFromJson(json);

  Map<String, dynamic> toJson() => _$BoundingBoxToJson(this);

  @override
  List<Object?> get props => [x, y, width, height];
}

enum ClothingCategory {
  @JsonValue('tops')
  tops,
  @JsonValue('bottoms')
  bottoms,
  @JsonValue('dresses')
  dresses,
  @JsonValue('outerwear')
  outerwear,
  @JsonValue('footwear')
  footwear,
  @JsonValue('accessories')
  accessories,
  @JsonValue('undergarments')
  undergarments,
}

enum Season {
  @JsonValue('spring')
  spring,
  @JsonValue('summer')
  summer,
  @JsonValue('fall')
  fall,
  @JsonValue('winter')
  winter,
}

enum Occasion {
  @JsonValue('casual')
  casual,
  @JsonValue('work')
  work,
  @JsonValue('formal')
  formal,
  @JsonValue('party')
  party,
  @JsonValue('sports')
  sports,
  @JsonValue('travel')
  travel,
  @JsonValue('date')
  date,
  @JsonValue('outdoor')
  outdoor,
}

extension ClothingCategoryExtension on ClothingCategory {
  String get displayName {
    switch (this) {
      case ClothingCategory.tops:
        return 'Tops';
      case ClothingCategory.bottoms:
        return 'Bottoms';
      case ClothingCategory.dresses:
        return 'Dresses';
      case ClothingCategory.outerwear:
        return 'Outerwear';
      case ClothingCategory.footwear:
        return 'Footwear';
      case ClothingCategory.accessories:
        return 'Accessories';
      case ClothingCategory.undergarments:
        return 'Undergarments';
    }
  }

  String get iconName {
    switch (this) {
      case ClothingCategory.tops:
        return 'shirt';
      case ClothingCategory.bottoms:
        return 'pants';
      case ClothingCategory.dresses:
        return 'dress';
      case ClothingCategory.outerwear:
        return 'jacket';
      case ClothingCategory.footwear:
        return 'shoe';
      case ClothingCategory.accessories:
        return 'bag';
      case ClothingCategory.undergarments:
        return 'underwear';
    }
  }

  List<String> get subcategories {
    switch (this) {
      case ClothingCategory.tops:
        return ['T-Shirt', 'Shirt', 'Blouse', 'Sweater', 'Tank Top', 'Hoodie'];
      case ClothingCategory.bottoms:
        return ['Jeans', 'Pants', 'Shorts', 'Skirt', 'Leggings', 'Trousers'];
      case ClothingCategory.dresses:
        return [
          'Casual Dress',
          'Formal Dress',
          'Maxi Dress',
          'Mini Dress',
          'Midi Dress'
        ];
      case ClothingCategory.outerwear:
        return ['Jacket', 'Coat', 'Blazer', 'Cardigan', 'Vest', 'Windbreaker'];
      case ClothingCategory.footwear:
        return ['Sneakers', 'Boots', 'Heels', 'Sandals', 'Flats', 'Loafers'];
      case ClothingCategory.accessories:
        return ['Bag', 'Hat', 'Jewelry', 'Belt', 'Scarf', 'Sunglasses'];
      case ClothingCategory.undergarments:
        return ['Bra', 'Underwear', 'Socks', 'Tights', 'Shapewear'];
    }
  }
}

extension SeasonExtension on Season {
  String get displayName {
    switch (this) {
      case Season.spring:
        return 'Spring';
      case Season.summer:
        return 'Summer';
      case Season.fall:
        return 'Fall';
      case Season.winter:
        return 'Winter';
    }
  }

  String get emoji {
    switch (this) {
      case Season.spring:
        return '🌸';
      case Season.summer:
        return '☀️';
      case Season.fall:
        return '🍂';
      case Season.winter:
        return '❄️';
    }
  }
}

extension OccasionExtension on Occasion {
  String get displayName {
    switch (this) {
      case Occasion.casual:
        return 'Casual';
      case Occasion.work:
        return 'Work';
      case Occasion.formal:
        return 'Formal';
      case Occasion.party:
        return 'Party';
      case Occasion.sports:
        return 'Sports';
      case Occasion.travel:
        return 'Travel';
      case Occasion.date:
        return 'Date';
      case Occasion.outdoor:
        return 'Outdoor';
    }
  }

  String get emoji {
    switch (this) {
      case Occasion.casual:
        return '👕';
      case Occasion.work:
        return '💼';
      case Occasion.formal:
        return '🤵';
      case Occasion.party:
        return '🎉';
      case Occasion.sports:
        return '🏃';
      case Occasion.travel:
        return '✈️';
      case Occasion.date:
        return '💕';
      case Occasion.outdoor:
        return '🏔️';
    }
  }
}
