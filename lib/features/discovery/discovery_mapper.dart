// lib/features/discovery/discovery_mapper.dart

import '../../core/local_db/app_database.dart';

/// Helper mapper responsible for mapping raw parsed JSON assets to Entity and edge database models.
class DiscoveryMapper {
  DiscoveryMapper._();

  /// Map character properties from JSON entries to Entities data class
  static Entity mapJsonToEntity(Map<String, dynamic> json) {
    return Entity(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      isRare: json['is_rare'] as bool? ?? false,
      region: json['region'] as String?,
      description: json['description'] as String? ?? '// TODO: Tafsir — content team to supply',
      isDiscovered: false,
    );
  }
}
