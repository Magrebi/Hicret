// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $VersesTable extends Verses with TableInfo<$VersesTable, Verse> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VersesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _surahNumMeta =
      const VerificationMeta('surahNum');
  @override
  late final GeneratedColumn<int> surahNum = GeneratedColumn<int>(
      'surah_num', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _ayahNumMeta =
      const VerificationMeta('ayahNum');
  @override
  late final GeneratedColumn<int> ayahNum = GeneratedColumn<int>(
      'ayah_num', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _textArabicMeta =
      const VerificationMeta('textArabic');
  @override
  late final GeneratedColumn<String> textArabic = GeneratedColumn<String>(
      'text_arabic', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _textTranslationMeta =
      const VerificationMeta('textTranslation');
  @override
  late final GeneratedColumn<String> textTranslation = GeneratedColumn<String>(
      'text_translation', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isReadMeta = const VerificationMeta('isRead');
  @override
  late final GeneratedColumn<bool> isRead = GeneratedColumn<bool>(
      'is_read', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_read" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [surahNum, ayahNum, textArabic, textTranslation, isRead];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'verses';
  @override
  VerificationContext validateIntegrity(Insertable<Verse> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('surah_num')) {
      context.handle(_surahNumMeta,
          surahNum.isAcceptableOrUnknown(data['surah_num']!, _surahNumMeta));
    } else if (isInserting) {
      context.missing(_surahNumMeta);
    }
    if (data.containsKey('ayah_num')) {
      context.handle(_ayahNumMeta,
          ayahNum.isAcceptableOrUnknown(data['ayah_num']!, _ayahNumMeta));
    } else if (isInserting) {
      context.missing(_ayahNumMeta);
    }
    if (data.containsKey('text_arabic')) {
      context.handle(
          _textArabicMeta,
          textArabic.isAcceptableOrUnknown(
              data['text_arabic']!, _textArabicMeta));
    } else if (isInserting) {
      context.missing(_textArabicMeta);
    }
    if (data.containsKey('text_translation')) {
      context.handle(
          _textTranslationMeta,
          textTranslation.isAcceptableOrUnknown(
              data['text_translation']!, _textTranslationMeta));
    } else if (isInserting) {
      context.missing(_textTranslationMeta);
    }
    if (data.containsKey('is_read')) {
      context.handle(_isReadMeta,
          isRead.isAcceptableOrUnknown(data['is_read']!, _isReadMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {surahNum, ayahNum};
  @override
  Verse map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Verse(
      surahNum: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}surah_num'])!,
      ayahNum: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ayah_num'])!,
      textArabic: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text_arabic'])!,
      textTranslation: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}text_translation'])!,
      isRead: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_read'])!,
    );
  }

  @override
  $VersesTable createAlias(String alias) {
    return $VersesTable(attachedDatabase, alias);
  }
}

class Verse extends DataClass implements Insertable<Verse> {
  final int surahNum;
  final int ayahNum;
  final String textArabic;
  final String textTranslation;
  final bool isRead;
  const Verse(
      {required this.surahNum,
      required this.ayahNum,
      required this.textArabic,
      required this.textTranslation,
      required this.isRead});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['surah_num'] = Variable<int>(surahNum);
    map['ayah_num'] = Variable<int>(ayahNum);
    map['text_arabic'] = Variable<String>(textArabic);
    map['text_translation'] = Variable<String>(textTranslation);
    map['is_read'] = Variable<bool>(isRead);
    return map;
  }

  VersesCompanion toCompanion(bool nullToAbsent) {
    return VersesCompanion(
      surahNum: Value(surahNum),
      ayahNum: Value(ayahNum),
      textArabic: Value(textArabic),
      textTranslation: Value(textTranslation),
      isRead: Value(isRead),
    );
  }

  factory Verse.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Verse(
      surahNum: serializer.fromJson<int>(json['surahNum']),
      ayahNum: serializer.fromJson<int>(json['ayahNum']),
      textArabic: serializer.fromJson<String>(json['textArabic']),
      textTranslation: serializer.fromJson<String>(json['textTranslation']),
      isRead: serializer.fromJson<bool>(json['isRead']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'surahNum': serializer.toJson<int>(surahNum),
      'ayahNum': serializer.toJson<int>(ayahNum),
      'textArabic': serializer.toJson<String>(textArabic),
      'textTranslation': serializer.toJson<String>(textTranslation),
      'isRead': serializer.toJson<bool>(isRead),
    };
  }

  Verse copyWith(
          {int? surahNum,
          int? ayahNum,
          String? textArabic,
          String? textTranslation,
          bool? isRead}) =>
      Verse(
        surahNum: surahNum ?? this.surahNum,
        ayahNum: ayahNum ?? this.ayahNum,
        textArabic: textArabic ?? this.textArabic,
        textTranslation: textTranslation ?? this.textTranslation,
        isRead: isRead ?? this.isRead,
      );
  Verse copyWithCompanion(VersesCompanion data) {
    return Verse(
      surahNum: data.surahNum.present ? data.surahNum.value : this.surahNum,
      ayahNum: data.ayahNum.present ? data.ayahNum.value : this.ayahNum,
      textArabic:
          data.textArabic.present ? data.textArabic.value : this.textArabic,
      textTranslation: data.textTranslation.present
          ? data.textTranslation.value
          : this.textTranslation,
      isRead: data.isRead.present ? data.isRead.value : this.isRead,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Verse(')
          ..write('surahNum: $surahNum, ')
          ..write('ayahNum: $ayahNum, ')
          ..write('textArabic: $textArabic, ')
          ..write('textTranslation: $textTranslation, ')
          ..write('isRead: $isRead')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(surahNum, ayahNum, textArabic, textTranslation, isRead);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Verse &&
          other.surahNum == this.surahNum &&
          other.ayahNum == this.ayahNum &&
          other.textArabic == this.textArabic &&
          other.textTranslation == this.textTranslation &&
          other.isRead == this.isRead);
}

class VersesCompanion extends UpdateCompanion<Verse> {
  final Value<int> surahNum;
  final Value<int> ayahNum;
  final Value<String> textArabic;
  final Value<String> textTranslation;
  final Value<bool> isRead;
  final Value<int> rowid;
  const VersesCompanion({
    this.surahNum = const Value.absent(),
    this.ayahNum = const Value.absent(),
    this.textArabic = const Value.absent(),
    this.textTranslation = const Value.absent(),
    this.isRead = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VersesCompanion.insert({
    required int surahNum,
    required int ayahNum,
    required String textArabic,
    required String textTranslation,
    this.isRead = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : surahNum = Value(surahNum),
        ayahNum = Value(ayahNum),
        textArabic = Value(textArabic),
        textTranslation = Value(textTranslation);
  static Insertable<Verse> custom({
    Expression<int>? surahNum,
    Expression<int>? ayahNum,
    Expression<String>? textArabic,
    Expression<String>? textTranslation,
    Expression<bool>? isRead,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (surahNum != null) 'surah_num': surahNum,
      if (ayahNum != null) 'ayah_num': ayahNum,
      if (textArabic != null) 'text_arabic': textArabic,
      if (textTranslation != null) 'text_translation': textTranslation,
      if (isRead != null) 'is_read': isRead,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VersesCompanion copyWith(
      {Value<int>? surahNum,
      Value<int>? ayahNum,
      Value<String>? textArabic,
      Value<String>? textTranslation,
      Value<bool>? isRead,
      Value<int>? rowid}) {
    return VersesCompanion(
      surahNum: surahNum ?? this.surahNum,
      ayahNum: ayahNum ?? this.ayahNum,
      textArabic: textArabic ?? this.textArabic,
      textTranslation: textTranslation ?? this.textTranslation,
      isRead: isRead ?? this.isRead,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (surahNum.present) {
      map['surah_num'] = Variable<int>(surahNum.value);
    }
    if (ayahNum.present) {
      map['ayah_num'] = Variable<int>(ayahNum.value);
    }
    if (textArabic.present) {
      map['text_arabic'] = Variable<String>(textArabic.value);
    }
    if (textTranslation.present) {
      map['text_translation'] = Variable<String>(textTranslation.value);
    }
    if (isRead.present) {
      map['is_read'] = Variable<bool>(isRead.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VersesCompanion(')
          ..write('surahNum: $surahNum, ')
          ..write('ayahNum: $ayahNum, ')
          ..write('textArabic: $textArabic, ')
          ..write('textTranslation: $textTranslation, ')
          ..write('isRead: $isRead, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EntitiesTable extends Entities with TableInfo<$EntitiesTable, Entity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EntitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isRareMeta = const VerificationMeta('isRare');
  @override
  late final GeneratedColumn<bool> isRare = GeneratedColumn<bool>(
      'is_rare', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_rare" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
      'region', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('// TODO: Tafsir — content team to supply'));
  static const VerificationMeta _isDiscoveredMeta =
      const VerificationMeta('isDiscovered');
  @override
  late final GeneratedColumn<bool> isDiscovered = GeneratedColumn<bool>(
      'is_discovered', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_discovered" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, type, isRare, region, description, isDiscovered];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'entities';
  @override
  VerificationContext validateIntegrity(Insertable<Entity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('is_rare')) {
      context.handle(_isRareMeta,
          isRare.isAcceptableOrUnknown(data['is_rare']!, _isRareMeta));
    }
    if (data.containsKey('region')) {
      context.handle(_regionMeta,
          region.isAcceptableOrUnknown(data['region']!, _regionMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('is_discovered')) {
      context.handle(
          _isDiscoveredMeta,
          isDiscovered.isAcceptableOrUnknown(
              data['is_discovered']!, _isDiscoveredMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Entity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Entity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      isRare: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_rare'])!,
      region: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}region']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      isDiscovered: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_discovered'])!,
    );
  }

  @override
  $EntitiesTable createAlias(String alias) {
    return $EntitiesTable(attachedDatabase, alias);
  }
}

class Entity extends DataClass implements Insertable<Entity> {
  final String id;
  final String name;
  final String type;
  final bool isRare;
  final String? region;
  final String description;
  final bool isDiscovered;
  const Entity(
      {required this.id,
      required this.name,
      required this.type,
      required this.isRare,
      this.region,
      required this.description,
      required this.isDiscovered});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['is_rare'] = Variable<bool>(isRare);
    if (!nullToAbsent || region != null) {
      map['region'] = Variable<String>(region);
    }
    map['description'] = Variable<String>(description);
    map['is_discovered'] = Variable<bool>(isDiscovered);
    return map;
  }

  EntitiesCompanion toCompanion(bool nullToAbsent) {
    return EntitiesCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      isRare: Value(isRare),
      region:
          region == null && nullToAbsent ? const Value.absent() : Value(region),
      description: Value(description),
      isDiscovered: Value(isDiscovered),
    );
  }

  factory Entity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Entity(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      isRare: serializer.fromJson<bool>(json['isRare']),
      region: serializer.fromJson<String?>(json['region']),
      description: serializer.fromJson<String>(json['description']),
      isDiscovered: serializer.fromJson<bool>(json['isDiscovered']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'isRare': serializer.toJson<bool>(isRare),
      'region': serializer.toJson<String?>(region),
      'description': serializer.toJson<String>(description),
      'isDiscovered': serializer.toJson<bool>(isDiscovered),
    };
  }

  Entity copyWith(
          {String? id,
          String? name,
          String? type,
          bool? isRare,
          Value<String?> region = const Value.absent(),
          String? description,
          bool? isDiscovered}) =>
      Entity(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        isRare: isRare ?? this.isRare,
        region: region.present ? region.value : this.region,
        description: description ?? this.description,
        isDiscovered: isDiscovered ?? this.isDiscovered,
      );
  Entity copyWithCompanion(EntitiesCompanion data) {
    return Entity(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      isRare: data.isRare.present ? data.isRare.value : this.isRare,
      region: data.region.present ? data.region.value : this.region,
      description:
          data.description.present ? data.description.value : this.description,
      isDiscovered: data.isDiscovered.present
          ? data.isDiscovered.value
          : this.isDiscovered,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Entity(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('isRare: $isRare, ')
          ..write('region: $region, ')
          ..write('description: $description, ')
          ..write('isDiscovered: $isDiscovered')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, type, isRare, region, description, isDiscovered);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Entity &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.isRare == this.isRare &&
          other.region == this.region &&
          other.description == this.description &&
          other.isDiscovered == this.isDiscovered);
}

class EntitiesCompanion extends UpdateCompanion<Entity> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> type;
  final Value<bool> isRare;
  final Value<String?> region;
  final Value<String> description;
  final Value<bool> isDiscovered;
  final Value<int> rowid;
  const EntitiesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.isRare = const Value.absent(),
    this.region = const Value.absent(),
    this.description = const Value.absent(),
    this.isDiscovered = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EntitiesCompanion.insert({
    required String id,
    required String name,
    required String type,
    this.isRare = const Value.absent(),
    this.region = const Value.absent(),
    this.description = const Value.absent(),
    this.isDiscovered = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        type = Value(type);
  static Insertable<Entity> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<bool>? isRare,
    Expression<String>? region,
    Expression<String>? description,
    Expression<bool>? isDiscovered,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (isRare != null) 'is_rare': isRare,
      if (region != null) 'region': region,
      if (description != null) 'description': description,
      if (isDiscovered != null) 'is_discovered': isDiscovered,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EntitiesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? type,
      Value<bool>? isRare,
      Value<String?>? region,
      Value<String>? description,
      Value<bool>? isDiscovered,
      Value<int>? rowid}) {
    return EntitiesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      isRare: isRare ?? this.isRare,
      region: region ?? this.region,
      description: description ?? this.description,
      isDiscovered: isDiscovered ?? this.isDiscovered,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (isRare.present) {
      map['is_rare'] = Variable<bool>(isRare.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isDiscovered.present) {
      map['is_discovered'] = Variable<bool>(isDiscovered.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntitiesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('isRare: $isRare, ')
          ..write('region: $region, ')
          ..write('description: $description, ')
          ..write('isDiscovered: $isDiscovered, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EntityTriggersTable extends EntityTriggers
    with TableInfo<$EntityTriggersTable, EntityTrigger> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EntityTriggersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _entityIdMeta =
      const VerificationMeta('entityId');
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
      'entity_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES entities (id) ON DELETE CASCADE'));
  static const VerificationMeta _surahNumMeta =
      const VerificationMeta('surahNum');
  @override
  late final GeneratedColumn<int> surahNum = GeneratedColumn<int>(
      'surah_num', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _ayahNumMeta =
      const VerificationMeta('ayahNum');
  @override
  late final GeneratedColumn<int> ayahNum = GeneratedColumn<int>(
      'ayah_num', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [entityId, surahNum, ayahNum];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'entity_triggers';
  @override
  VerificationContext validateIntegrity(Insertable<EntityTrigger> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('entity_id')) {
      context.handle(_entityIdMeta,
          entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta));
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('surah_num')) {
      context.handle(_surahNumMeta,
          surahNum.isAcceptableOrUnknown(data['surah_num']!, _surahNumMeta));
    } else if (isInserting) {
      context.missing(_surahNumMeta);
    }
    if (data.containsKey('ayah_num')) {
      context.handle(_ayahNumMeta,
          ayahNum.isAcceptableOrUnknown(data['ayah_num']!, _ayahNumMeta));
    } else if (isInserting) {
      context.missing(_ayahNumMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {entityId, surahNum, ayahNum};
  @override
  EntityTrigger map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EntityTrigger(
      entityId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_id'])!,
      surahNum: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}surah_num'])!,
      ayahNum: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ayah_num'])!,
    );
  }

  @override
  $EntityTriggersTable createAlias(String alias) {
    return $EntityTriggersTable(attachedDatabase, alias);
  }
}

class EntityTrigger extends DataClass implements Insertable<EntityTrigger> {
  final String entityId;
  final int surahNum;
  final int ayahNum;
  const EntityTrigger(
      {required this.entityId, required this.surahNum, required this.ayahNum});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['entity_id'] = Variable<String>(entityId);
    map['surah_num'] = Variable<int>(surahNum);
    map['ayah_num'] = Variable<int>(ayahNum);
    return map;
  }

  EntityTriggersCompanion toCompanion(bool nullToAbsent) {
    return EntityTriggersCompanion(
      entityId: Value(entityId),
      surahNum: Value(surahNum),
      ayahNum: Value(ayahNum),
    );
  }

  factory EntityTrigger.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EntityTrigger(
      entityId: serializer.fromJson<String>(json['entityId']),
      surahNum: serializer.fromJson<int>(json['surahNum']),
      ayahNum: serializer.fromJson<int>(json['ayahNum']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'entityId': serializer.toJson<String>(entityId),
      'surahNum': serializer.toJson<int>(surahNum),
      'ayahNum': serializer.toJson<int>(ayahNum),
    };
  }

  EntityTrigger copyWith({String? entityId, int? surahNum, int? ayahNum}) =>
      EntityTrigger(
        entityId: entityId ?? this.entityId,
        surahNum: surahNum ?? this.surahNum,
        ayahNum: ayahNum ?? this.ayahNum,
      );
  EntityTrigger copyWithCompanion(EntityTriggersCompanion data) {
    return EntityTrigger(
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      surahNum: data.surahNum.present ? data.surahNum.value : this.surahNum,
      ayahNum: data.ayahNum.present ? data.ayahNum.value : this.ayahNum,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EntityTrigger(')
          ..write('entityId: $entityId, ')
          ..write('surahNum: $surahNum, ')
          ..write('ayahNum: $ayahNum')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(entityId, surahNum, ayahNum);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EntityTrigger &&
          other.entityId == this.entityId &&
          other.surahNum == this.surahNum &&
          other.ayahNum == this.ayahNum);
}

class EntityTriggersCompanion extends UpdateCompanion<EntityTrigger> {
  final Value<String> entityId;
  final Value<int> surahNum;
  final Value<int> ayahNum;
  final Value<int> rowid;
  const EntityTriggersCompanion({
    this.entityId = const Value.absent(),
    this.surahNum = const Value.absent(),
    this.ayahNum = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EntityTriggersCompanion.insert({
    required String entityId,
    required int surahNum,
    required int ayahNum,
    this.rowid = const Value.absent(),
  })  : entityId = Value(entityId),
        surahNum = Value(surahNum),
        ayahNum = Value(ayahNum);
  static Insertable<EntityTrigger> custom({
    Expression<String>? entityId,
    Expression<int>? surahNum,
    Expression<int>? ayahNum,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (entityId != null) 'entity_id': entityId,
      if (surahNum != null) 'surah_num': surahNum,
      if (ayahNum != null) 'ayah_num': ayahNum,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EntityTriggersCompanion copyWith(
      {Value<String>? entityId,
      Value<int>? surahNum,
      Value<int>? ayahNum,
      Value<int>? rowid}) {
    return EntityTriggersCompanion(
      entityId: entityId ?? this.entityId,
      surahNum: surahNum ?? this.surahNum,
      ayahNum: ayahNum ?? this.ayahNum,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (surahNum.present) {
      map['surah_num'] = Variable<int>(surahNum.value);
    }
    if (ayahNum.present) {
      map['ayah_num'] = Variable<int>(ayahNum.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntityTriggersCompanion(')
          ..write('entityId: $entityId, ')
          ..write('surahNum: $surahNum, ')
          ..write('ayahNum: $ayahNum, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RelationEdgesTable extends RelationEdges
    with TableInfo<$RelationEdgesTable, RelationEdge> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RelationEdgesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _entityAIdMeta =
      const VerificationMeta('entityAId');
  @override
  late final GeneratedColumn<String> entityAId = GeneratedColumn<String>(
      'entity_a_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES entities (id) ON DELETE CASCADE'));
  static const VerificationMeta _entityBIdMeta =
      const VerificationMeta('entityBId');
  @override
  late final GeneratedColumn<String> entityBId = GeneratedColumn<String>(
      'entity_b_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES entities (id) ON DELETE CASCADE'));
  static const VerificationMeta _relationTypeMeta =
      const VerificationMeta('relationType');
  @override
  late final GeneratedColumn<String> relationType = GeneratedColumn<String>(
      'relation_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [entityAId, entityBId, relationType];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'relation_edges';
  @override
  VerificationContext validateIntegrity(Insertable<RelationEdge> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('entity_a_id')) {
      context.handle(
          _entityAIdMeta,
          entityAId.isAcceptableOrUnknown(
              data['entity_a_id']!, _entityAIdMeta));
    } else if (isInserting) {
      context.missing(_entityAIdMeta);
    }
    if (data.containsKey('entity_b_id')) {
      context.handle(
          _entityBIdMeta,
          entityBId.isAcceptableOrUnknown(
              data['entity_b_id']!, _entityBIdMeta));
    } else if (isInserting) {
      context.missing(_entityBIdMeta);
    }
    if (data.containsKey('relation_type')) {
      context.handle(
          _relationTypeMeta,
          relationType.isAcceptableOrUnknown(
              data['relation_type']!, _relationTypeMeta));
    } else if (isInserting) {
      context.missing(_relationTypeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {entityAId, entityBId, relationType};
  @override
  RelationEdge map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RelationEdge(
      entityAId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_a_id'])!,
      entityBId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_b_id'])!,
      relationType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}relation_type'])!,
    );
  }

  @override
  $RelationEdgesTable createAlias(String alias) {
    return $RelationEdgesTable(attachedDatabase, alias);
  }
}

class RelationEdge extends DataClass implements Insertable<RelationEdge> {
  final String entityAId;
  final String entityBId;
  final String relationType;
  const RelationEdge(
      {required this.entityAId,
      required this.entityBId,
      required this.relationType});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['entity_a_id'] = Variable<String>(entityAId);
    map['entity_b_id'] = Variable<String>(entityBId);
    map['relation_type'] = Variable<String>(relationType);
    return map;
  }

  RelationEdgesCompanion toCompanion(bool nullToAbsent) {
    return RelationEdgesCompanion(
      entityAId: Value(entityAId),
      entityBId: Value(entityBId),
      relationType: Value(relationType),
    );
  }

  factory RelationEdge.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RelationEdge(
      entityAId: serializer.fromJson<String>(json['entityAId']),
      entityBId: serializer.fromJson<String>(json['entityBId']),
      relationType: serializer.fromJson<String>(json['relationType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'entityAId': serializer.toJson<String>(entityAId),
      'entityBId': serializer.toJson<String>(entityBId),
      'relationType': serializer.toJson<String>(relationType),
    };
  }

  RelationEdge copyWith(
          {String? entityAId, String? entityBId, String? relationType}) =>
      RelationEdge(
        entityAId: entityAId ?? this.entityAId,
        entityBId: entityBId ?? this.entityBId,
        relationType: relationType ?? this.relationType,
      );
  RelationEdge copyWithCompanion(RelationEdgesCompanion data) {
    return RelationEdge(
      entityAId: data.entityAId.present ? data.entityAId.value : this.entityAId,
      entityBId: data.entityBId.present ? data.entityBId.value : this.entityBId,
      relationType: data.relationType.present
          ? data.relationType.value
          : this.relationType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RelationEdge(')
          ..write('entityAId: $entityAId, ')
          ..write('entityBId: $entityBId, ')
          ..write('relationType: $relationType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(entityAId, entityBId, relationType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RelationEdge &&
          other.entityAId == this.entityAId &&
          other.entityBId == this.entityBId &&
          other.relationType == this.relationType);
}

class RelationEdgesCompanion extends UpdateCompanion<RelationEdge> {
  final Value<String> entityAId;
  final Value<String> entityBId;
  final Value<String> relationType;
  final Value<int> rowid;
  const RelationEdgesCompanion({
    this.entityAId = const Value.absent(),
    this.entityBId = const Value.absent(),
    this.relationType = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RelationEdgesCompanion.insert({
    required String entityAId,
    required String entityBId,
    required String relationType,
    this.rowid = const Value.absent(),
  })  : entityAId = Value(entityAId),
        entityBId = Value(entityBId),
        relationType = Value(relationType);
  static Insertable<RelationEdge> custom({
    Expression<String>? entityAId,
    Expression<String>? entityBId,
    Expression<String>? relationType,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (entityAId != null) 'entity_a_id': entityAId,
      if (entityBId != null) 'entity_b_id': entityBId,
      if (relationType != null) 'relation_type': relationType,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RelationEdgesCompanion copyWith(
      {Value<String>? entityAId,
      Value<String>? entityBId,
      Value<String>? relationType,
      Value<int>? rowid}) {
    return RelationEdgesCompanion(
      entityAId: entityAId ?? this.entityAId,
      entityBId: entityBId ?? this.entityBId,
      relationType: relationType ?? this.relationType,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (entityAId.present) {
      map['entity_a_id'] = Variable<String>(entityAId.value);
    }
    if (entityBId.present) {
      map['entity_b_id'] = Variable<String>(entityBId.value);
    }
    if (relationType.present) {
      map['relation_type'] = Variable<String>(relationType.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RelationEdgesCompanion(')
          ..write('entityAId: $entityAId, ')
          ..write('entityBId: $entityBId, ')
          ..write('relationType: $relationType, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ConstellationEdgesTable extends ConstellationEdges
    with TableInfo<$ConstellationEdgesTable, ConstellationEdge> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConstellationEdgesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _entityAIdMeta =
      const VerificationMeta('entityAId');
  @override
  late final GeneratedColumn<String> entityAId = GeneratedColumn<String>(
      'entity_a_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES entities (id) ON DELETE CASCADE'));
  static const VerificationMeta _entityBIdMeta =
      const VerificationMeta('entityBId');
  @override
  late final GeneratedColumn<String> entityBId = GeneratedColumn<String>(
      'entity_b_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES entities (id) ON DELETE CASCADE'));
  static const VerificationMeta _sharedSurahMeta =
      const VerificationMeta('sharedSurah');
  @override
  late final GeneratedColumn<int> sharedSurah = GeneratedColumn<int>(
      'shared_surah', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<int> weight = GeneratedColumn<int>(
      'weight', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  @override
  List<GeneratedColumn> get $columns =>
      [entityAId, entityBId, sharedSurah, weight];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'constellation_edges';
  @override
  VerificationContext validateIntegrity(Insertable<ConstellationEdge> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('entity_a_id')) {
      context.handle(
          _entityAIdMeta,
          entityAId.isAcceptableOrUnknown(
              data['entity_a_id']!, _entityAIdMeta));
    } else if (isInserting) {
      context.missing(_entityAIdMeta);
    }
    if (data.containsKey('entity_b_id')) {
      context.handle(
          _entityBIdMeta,
          entityBId.isAcceptableOrUnknown(
              data['entity_b_id']!, _entityBIdMeta));
    } else if (isInserting) {
      context.missing(_entityBIdMeta);
    }
    if (data.containsKey('shared_surah')) {
      context.handle(
          _sharedSurahMeta,
          sharedSurah.isAcceptableOrUnknown(
              data['shared_surah']!, _sharedSurahMeta));
    } else if (isInserting) {
      context.missing(_sharedSurahMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {entityAId, entityBId, sharedSurah};
  @override
  ConstellationEdge map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConstellationEdge(
      entityAId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_a_id'])!,
      entityBId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_b_id'])!,
      sharedSurah: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}shared_surah'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}weight'])!,
    );
  }

  @override
  $ConstellationEdgesTable createAlias(String alias) {
    return $ConstellationEdgesTable(attachedDatabase, alias);
  }
}

class ConstellationEdge extends DataClass
    implements Insertable<ConstellationEdge> {
  final String entityAId;
  final String entityBId;
  final int sharedSurah;
  final int weight;
  const ConstellationEdge(
      {required this.entityAId,
      required this.entityBId,
      required this.sharedSurah,
      required this.weight});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['entity_a_id'] = Variable<String>(entityAId);
    map['entity_b_id'] = Variable<String>(entityBId);
    map['shared_surah'] = Variable<int>(sharedSurah);
    map['weight'] = Variable<int>(weight);
    return map;
  }

  ConstellationEdgesCompanion toCompanion(bool nullToAbsent) {
    return ConstellationEdgesCompanion(
      entityAId: Value(entityAId),
      entityBId: Value(entityBId),
      sharedSurah: Value(sharedSurah),
      weight: Value(weight),
    );
  }

  factory ConstellationEdge.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConstellationEdge(
      entityAId: serializer.fromJson<String>(json['entityAId']),
      entityBId: serializer.fromJson<String>(json['entityBId']),
      sharedSurah: serializer.fromJson<int>(json['sharedSurah']),
      weight: serializer.fromJson<int>(json['weight']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'entityAId': serializer.toJson<String>(entityAId),
      'entityBId': serializer.toJson<String>(entityBId),
      'sharedSurah': serializer.toJson<int>(sharedSurah),
      'weight': serializer.toJson<int>(weight),
    };
  }

  ConstellationEdge copyWith(
          {String? entityAId,
          String? entityBId,
          int? sharedSurah,
          int? weight}) =>
      ConstellationEdge(
        entityAId: entityAId ?? this.entityAId,
        entityBId: entityBId ?? this.entityBId,
        sharedSurah: sharedSurah ?? this.sharedSurah,
        weight: weight ?? this.weight,
      );
  ConstellationEdge copyWithCompanion(ConstellationEdgesCompanion data) {
    return ConstellationEdge(
      entityAId: data.entityAId.present ? data.entityAId.value : this.entityAId,
      entityBId: data.entityBId.present ? data.entityBId.value : this.entityBId,
      sharedSurah:
          data.sharedSurah.present ? data.sharedSurah.value : this.sharedSurah,
      weight: data.weight.present ? data.weight.value : this.weight,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConstellationEdge(')
          ..write('entityAId: $entityAId, ')
          ..write('entityBId: $entityBId, ')
          ..write('sharedSurah: $sharedSurah, ')
          ..write('weight: $weight')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(entityAId, entityBId, sharedSurah, weight);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConstellationEdge &&
          other.entityAId == this.entityAId &&
          other.entityBId == this.entityBId &&
          other.sharedSurah == this.sharedSurah &&
          other.weight == this.weight);
}

class ConstellationEdgesCompanion extends UpdateCompanion<ConstellationEdge> {
  final Value<String> entityAId;
  final Value<String> entityBId;
  final Value<int> sharedSurah;
  final Value<int> weight;
  final Value<int> rowid;
  const ConstellationEdgesCompanion({
    this.entityAId = const Value.absent(),
    this.entityBId = const Value.absent(),
    this.sharedSurah = const Value.absent(),
    this.weight = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ConstellationEdgesCompanion.insert({
    required String entityAId,
    required String entityBId,
    required int sharedSurah,
    this.weight = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : entityAId = Value(entityAId),
        entityBId = Value(entityBId),
        sharedSurah = Value(sharedSurah);
  static Insertable<ConstellationEdge> custom({
    Expression<String>? entityAId,
    Expression<String>? entityBId,
    Expression<int>? sharedSurah,
    Expression<int>? weight,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (entityAId != null) 'entity_a_id': entityAId,
      if (entityBId != null) 'entity_b_id': entityBId,
      if (sharedSurah != null) 'shared_surah': sharedSurah,
      if (weight != null) 'weight': weight,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ConstellationEdgesCompanion copyWith(
      {Value<String>? entityAId,
      Value<String>? entityBId,
      Value<int>? sharedSurah,
      Value<int>? weight,
      Value<int>? rowid}) {
    return ConstellationEdgesCompanion(
      entityAId: entityAId ?? this.entityAId,
      entityBId: entityBId ?? this.entityBId,
      sharedSurah: sharedSurah ?? this.sharedSurah,
      weight: weight ?? this.weight,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (entityAId.present) {
      map['entity_a_id'] = Variable<String>(entityAId.value);
    }
    if (entityBId.present) {
      map['entity_b_id'] = Variable<String>(entityBId.value);
    }
    if (sharedSurah.present) {
      map['shared_surah'] = Variable<int>(sharedSurah.value);
    }
    if (weight.present) {
      map['weight'] = Variable<int>(weight.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConstellationEdgesCompanion(')
          ..write('entityAId: $entityAId, ')
          ..write('entityBId: $entityBId, ')
          ..write('sharedSurah: $sharedSurah, ')
          ..write('weight: $weight, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StoriesTable extends Stories with TableInfo<$StoriesTable, Story> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('// TODO: Tafsir — content team to supply'));
  static const VerificationMeta _progressValueMeta =
      const VerificationMeta('progressValue');
  @override
  late final GeneratedColumn<double> progressValue = GeneratedColumn<double>(
      'progress_value', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  @override
  List<GeneratedColumn> get $columns => [id, title, description, progressValue];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stories';
  @override
  VerificationContext validateIntegrity(Insertable<Story> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('progress_value')) {
      context.handle(
          _progressValueMeta,
          progressValue.isAcceptableOrUnknown(
              data['progress_value']!, _progressValueMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Story map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Story(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      progressValue: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}progress_value'])!,
    );
  }

  @override
  $StoriesTable createAlias(String alias) {
    return $StoriesTable(attachedDatabase, alias);
  }
}

class Story extends DataClass implements Insertable<Story> {
  final String id;
  final String title;
  final String description;
  final double progressValue;
  const Story(
      {required this.id,
      required this.title,
      required this.description,
      required this.progressValue});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['progress_value'] = Variable<double>(progressValue);
    return map;
  }

  StoriesCompanion toCompanion(bool nullToAbsent) {
    return StoriesCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      progressValue: Value(progressValue),
    );
  }

  factory Story.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Story(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      progressValue: serializer.fromJson<double>(json['progressValue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'progressValue': serializer.toJson<double>(progressValue),
    };
  }

  Story copyWith(
          {String? id,
          String? title,
          String? description,
          double? progressValue}) =>
      Story(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        progressValue: progressValue ?? this.progressValue,
      );
  Story copyWithCompanion(StoriesCompanion data) {
    return Story(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      progressValue: data.progressValue.present
          ? data.progressValue.value
          : this.progressValue,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Story(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('progressValue: $progressValue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, description, progressValue);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Story &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.progressValue == this.progressValue);
}

class StoriesCompanion extends UpdateCompanion<Story> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> description;
  final Value<double> progressValue;
  final Value<int> rowid;
  const StoriesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.progressValue = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StoriesCompanion.insert({
    required String id,
    required String title,
    this.description = const Value.absent(),
    this.progressValue = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title);
  static Insertable<Story> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<double>? progressValue,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (progressValue != null) 'progress_value': progressValue,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StoriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? description,
      Value<double>? progressValue,
      Value<int>? rowid}) {
    return StoriesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      progressValue: progressValue ?? this.progressValue,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (progressValue.present) {
      map['progress_value'] = Variable<double>(progressValue.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StoriesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('progressValue: $progressValue, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StoryVerseRangesTable extends StoryVerseRanges
    with TableInfo<$StoryVerseRangesTable, StoryVerseRange> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StoryVerseRangesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _storyIdMeta =
      const VerificationMeta('storyId');
  @override
  late final GeneratedColumn<String> storyId = GeneratedColumn<String>(
      'story_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES stories (id) ON DELETE CASCADE'));
  static const VerificationMeta _surahNumMeta =
      const VerificationMeta('surahNum');
  @override
  late final GeneratedColumn<int> surahNum = GeneratedColumn<int>(
      'surah_num', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _ayahStartMeta =
      const VerificationMeta('ayahStart');
  @override
  late final GeneratedColumn<int> ayahStart = GeneratedColumn<int>(
      'ayah_start', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _ayahEndMeta =
      const VerificationMeta('ayahEnd');
  @override
  late final GeneratedColumn<int> ayahEnd = GeneratedColumn<int>(
      'ayah_end', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [storyId, surahNum, ayahStart, ayahEnd];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'story_verse_ranges';
  @override
  VerificationContext validateIntegrity(Insertable<StoryVerseRange> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('story_id')) {
      context.handle(_storyIdMeta,
          storyId.isAcceptableOrUnknown(data['story_id']!, _storyIdMeta));
    } else if (isInserting) {
      context.missing(_storyIdMeta);
    }
    if (data.containsKey('surah_num')) {
      context.handle(_surahNumMeta,
          surahNum.isAcceptableOrUnknown(data['surah_num']!, _surahNumMeta));
    } else if (isInserting) {
      context.missing(_surahNumMeta);
    }
    if (data.containsKey('ayah_start')) {
      context.handle(_ayahStartMeta,
          ayahStart.isAcceptableOrUnknown(data['ayah_start']!, _ayahStartMeta));
    } else if (isInserting) {
      context.missing(_ayahStartMeta);
    }
    if (data.containsKey('ayah_end')) {
      context.handle(_ayahEndMeta,
          ayahEnd.isAcceptableOrUnknown(data['ayah_end']!, _ayahEndMeta));
    } else if (isInserting) {
      context.missing(_ayahEndMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey =>
      {storyId, surahNum, ayahStart, ayahEnd};
  @override
  StoryVerseRange map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoryVerseRange(
      storyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}story_id'])!,
      surahNum: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}surah_num'])!,
      ayahStart: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ayah_start'])!,
      ayahEnd: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ayah_end'])!,
    );
  }

  @override
  $StoryVerseRangesTable createAlias(String alias) {
    return $StoryVerseRangesTable(attachedDatabase, alias);
  }
}

class StoryVerseRange extends DataClass implements Insertable<StoryVerseRange> {
  final String storyId;
  final int surahNum;
  final int ayahStart;
  final int ayahEnd;
  const StoryVerseRange(
      {required this.storyId,
      required this.surahNum,
      required this.ayahStart,
      required this.ayahEnd});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['story_id'] = Variable<String>(storyId);
    map['surah_num'] = Variable<int>(surahNum);
    map['ayah_start'] = Variable<int>(ayahStart);
    map['ayah_end'] = Variable<int>(ayahEnd);
    return map;
  }

  StoryVerseRangesCompanion toCompanion(bool nullToAbsent) {
    return StoryVerseRangesCompanion(
      storyId: Value(storyId),
      surahNum: Value(surahNum),
      ayahStart: Value(ayahStart),
      ayahEnd: Value(ayahEnd),
    );
  }

  factory StoryVerseRange.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoryVerseRange(
      storyId: serializer.fromJson<String>(json['storyId']),
      surahNum: serializer.fromJson<int>(json['surahNum']),
      ayahStart: serializer.fromJson<int>(json['ayahStart']),
      ayahEnd: serializer.fromJson<int>(json['ayahEnd']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'storyId': serializer.toJson<String>(storyId),
      'surahNum': serializer.toJson<int>(surahNum),
      'ayahStart': serializer.toJson<int>(ayahStart),
      'ayahEnd': serializer.toJson<int>(ayahEnd),
    };
  }

  StoryVerseRange copyWith(
          {String? storyId, int? surahNum, int? ayahStart, int? ayahEnd}) =>
      StoryVerseRange(
        storyId: storyId ?? this.storyId,
        surahNum: surahNum ?? this.surahNum,
        ayahStart: ayahStart ?? this.ayahStart,
        ayahEnd: ayahEnd ?? this.ayahEnd,
      );
  StoryVerseRange copyWithCompanion(StoryVerseRangesCompanion data) {
    return StoryVerseRange(
      storyId: data.storyId.present ? data.storyId.value : this.storyId,
      surahNum: data.surahNum.present ? data.surahNum.value : this.surahNum,
      ayahStart: data.ayahStart.present ? data.ayahStart.value : this.ayahStart,
      ayahEnd: data.ayahEnd.present ? data.ayahEnd.value : this.ayahEnd,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoryVerseRange(')
          ..write('storyId: $storyId, ')
          ..write('surahNum: $surahNum, ')
          ..write('ayahStart: $ayahStart, ')
          ..write('ayahEnd: $ayahEnd')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(storyId, surahNum, ayahStart, ayahEnd);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoryVerseRange &&
          other.storyId == this.storyId &&
          other.surahNum == this.surahNum &&
          other.ayahStart == this.ayahStart &&
          other.ayahEnd == this.ayahEnd);
}

class StoryVerseRangesCompanion extends UpdateCompanion<StoryVerseRange> {
  final Value<String> storyId;
  final Value<int> surahNum;
  final Value<int> ayahStart;
  final Value<int> ayahEnd;
  final Value<int> rowid;
  const StoryVerseRangesCompanion({
    this.storyId = const Value.absent(),
    this.surahNum = const Value.absent(),
    this.ayahStart = const Value.absent(),
    this.ayahEnd = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StoryVerseRangesCompanion.insert({
    required String storyId,
    required int surahNum,
    required int ayahStart,
    required int ayahEnd,
    this.rowid = const Value.absent(),
  })  : storyId = Value(storyId),
        surahNum = Value(surahNum),
        ayahStart = Value(ayahStart),
        ayahEnd = Value(ayahEnd);
  static Insertable<StoryVerseRange> custom({
    Expression<String>? storyId,
    Expression<int>? surahNum,
    Expression<int>? ayahStart,
    Expression<int>? ayahEnd,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (storyId != null) 'story_id': storyId,
      if (surahNum != null) 'surah_num': surahNum,
      if (ayahStart != null) 'ayah_start': ayahStart,
      if (ayahEnd != null) 'ayah_end': ayahEnd,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StoryVerseRangesCompanion copyWith(
      {Value<String>? storyId,
      Value<int>? surahNum,
      Value<int>? ayahStart,
      Value<int>? ayahEnd,
      Value<int>? rowid}) {
    return StoryVerseRangesCompanion(
      storyId: storyId ?? this.storyId,
      surahNum: surahNum ?? this.surahNum,
      ayahStart: ayahStart ?? this.ayahStart,
      ayahEnd: ayahEnd ?? this.ayahEnd,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (storyId.present) {
      map['story_id'] = Variable<String>(storyId.value);
    }
    if (surahNum.present) {
      map['surah_num'] = Variable<int>(surahNum.value);
    }
    if (ayahStart.present) {
      map['ayah_start'] = Variable<int>(ayahStart.value);
    }
    if (ayahEnd.present) {
      map['ayah_end'] = Variable<int>(ayahEnd.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StoryVerseRangesCompanion(')
          ..write('storyId: $storyId, ')
          ..write('surahNum: $surahNum, ')
          ..write('ayahStart: $ayahStart, ')
          ..write('ayahEnd: $ayahEnd, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ThemesTable extends Themes with TableInfo<$ThemesTable, Theme> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ThemesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _currentXpMeta =
      const VerificationMeta('currentXp');
  @override
  late final GeneratedColumn<int> currentXp = GeneratedColumn<int>(
      'current_xp', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _maxXpMeta = const VerificationMeta('maxXp');
  @override
  late final GeneratedColumn<int> maxXp = GeneratedColumn<int>(
      'max_xp', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(100));
  @override
  List<GeneratedColumn> get $columns => [id, name, icon, currentXp, maxXp];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'themes';
  @override
  VerificationContext validateIntegrity(Insertable<Theme> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('current_xp')) {
      context.handle(_currentXpMeta,
          currentXp.isAcceptableOrUnknown(data['current_xp']!, _currentXpMeta));
    }
    if (data.containsKey('max_xp')) {
      context.handle(
          _maxXpMeta, maxXp.isAcceptableOrUnknown(data['max_xp']!, _maxXpMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Theme map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Theme(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon'])!,
      currentXp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}current_xp'])!,
      maxXp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}max_xp'])!,
    );
  }

  @override
  $ThemesTable createAlias(String alias) {
    return $ThemesTable(attachedDatabase, alias);
  }
}

class Theme extends DataClass implements Insertable<Theme> {
  final String id;
  final String name;
  final String icon;
  final int currentXp;
  final int maxXp;
  const Theme(
      {required this.id,
      required this.name,
      required this.icon,
      required this.currentXp,
      required this.maxXp});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['icon'] = Variable<String>(icon);
    map['current_xp'] = Variable<int>(currentXp);
    map['max_xp'] = Variable<int>(maxXp);
    return map;
  }

  ThemesCompanion toCompanion(bool nullToAbsent) {
    return ThemesCompanion(
      id: Value(id),
      name: Value(name),
      icon: Value(icon),
      currentXp: Value(currentXp),
      maxXp: Value(maxXp),
    );
  }

  factory Theme.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Theme(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      icon: serializer.fromJson<String>(json['icon']),
      currentXp: serializer.fromJson<int>(json['currentXp']),
      maxXp: serializer.fromJson<int>(json['maxXp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'icon': serializer.toJson<String>(icon),
      'currentXp': serializer.toJson<int>(currentXp),
      'maxXp': serializer.toJson<int>(maxXp),
    };
  }

  Theme copyWith(
          {String? id,
          String? name,
          String? icon,
          int? currentXp,
          int? maxXp}) =>
      Theme(
        id: id ?? this.id,
        name: name ?? this.name,
        icon: icon ?? this.icon,
        currentXp: currentXp ?? this.currentXp,
        maxXp: maxXp ?? this.maxXp,
      );
  Theme copyWithCompanion(ThemesCompanion data) {
    return Theme(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      icon: data.icon.present ? data.icon.value : this.icon,
      currentXp: data.currentXp.present ? data.currentXp.value : this.currentXp,
      maxXp: data.maxXp.present ? data.maxXp.value : this.maxXp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Theme(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('currentXp: $currentXp, ')
          ..write('maxXp: $maxXp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, icon, currentXp, maxXp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Theme &&
          other.id == this.id &&
          other.name == this.name &&
          other.icon == this.icon &&
          other.currentXp == this.currentXp &&
          other.maxXp == this.maxXp);
}

class ThemesCompanion extends UpdateCompanion<Theme> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> icon;
  final Value<int> currentXp;
  final Value<int> maxXp;
  final Value<int> rowid;
  const ThemesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.icon = const Value.absent(),
    this.currentXp = const Value.absent(),
    this.maxXp = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ThemesCompanion.insert({
    required String id,
    required String name,
    required String icon,
    this.currentXp = const Value.absent(),
    this.maxXp = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        icon = Value(icon);
  static Insertable<Theme> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? icon,
    Expression<int>? currentXp,
    Expression<int>? maxXp,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (icon != null) 'icon': icon,
      if (currentXp != null) 'current_xp': currentXp,
      if (maxXp != null) 'max_xp': maxXp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ThemesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? icon,
      Value<int>? currentXp,
      Value<int>? maxXp,
      Value<int>? rowid}) {
    return ThemesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      currentXp: currentXp ?? this.currentXp,
      maxXp: maxXp ?? this.maxXp,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (currentXp.present) {
      map['current_xp'] = Variable<int>(currentXp.value);
    }
    if (maxXp.present) {
      map['max_xp'] = Variable<int>(maxXp.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ThemesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('currentXp: $currentXp, ')
          ..write('maxXp: $maxXp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ThemeLevelsTable extends ThemeLevels
    with TableInfo<$ThemeLevelsTable, ThemeLevel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ThemeLevelsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _themeIdMeta =
      const VerificationMeta('themeId');
  @override
  late final GeneratedColumn<String> themeId = GeneratedColumn<String>(
      'theme_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES themes (id) ON DELETE CASCADE'));
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
      'level', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _xpRequiredMeta =
      const VerificationMeta('xpRequired');
  @override
  late final GeneratedColumn<int> xpRequired = GeneratedColumn<int>(
      'xp_required', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [themeId, level, xpRequired];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'theme_levels';
  @override
  VerificationContext validateIntegrity(Insertable<ThemeLevel> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('theme_id')) {
      context.handle(_themeIdMeta,
          themeId.isAcceptableOrUnknown(data['theme_id']!, _themeIdMeta));
    } else if (isInserting) {
      context.missing(_themeIdMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('xp_required')) {
      context.handle(
          _xpRequiredMeta,
          xpRequired.isAcceptableOrUnknown(
              data['xp_required']!, _xpRequiredMeta));
    } else if (isInserting) {
      context.missing(_xpRequiredMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {themeId, level};
  @override
  ThemeLevel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ThemeLevel(
      themeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}theme_id'])!,
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}level'])!,
      xpRequired: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}xp_required'])!,
    );
  }

  @override
  $ThemeLevelsTable createAlias(String alias) {
    return $ThemeLevelsTable(attachedDatabase, alias);
  }
}

class ThemeLevel extends DataClass implements Insertable<ThemeLevel> {
  final String themeId;
  final int level;
  final int xpRequired;
  const ThemeLevel(
      {required this.themeId, required this.level, required this.xpRequired});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['theme_id'] = Variable<String>(themeId);
    map['level'] = Variable<int>(level);
    map['xp_required'] = Variable<int>(xpRequired);
    return map;
  }

  ThemeLevelsCompanion toCompanion(bool nullToAbsent) {
    return ThemeLevelsCompanion(
      themeId: Value(themeId),
      level: Value(level),
      xpRequired: Value(xpRequired),
    );
  }

  factory ThemeLevel.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ThemeLevel(
      themeId: serializer.fromJson<String>(json['themeId']),
      level: serializer.fromJson<int>(json['level']),
      xpRequired: serializer.fromJson<int>(json['xpRequired']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'themeId': serializer.toJson<String>(themeId),
      'level': serializer.toJson<int>(level),
      'xpRequired': serializer.toJson<int>(xpRequired),
    };
  }

  ThemeLevel copyWith({String? themeId, int? level, int? xpRequired}) =>
      ThemeLevel(
        themeId: themeId ?? this.themeId,
        level: level ?? this.level,
        xpRequired: xpRequired ?? this.xpRequired,
      );
  ThemeLevel copyWithCompanion(ThemeLevelsCompanion data) {
    return ThemeLevel(
      themeId: data.themeId.present ? data.themeId.value : this.themeId,
      level: data.level.present ? data.level.value : this.level,
      xpRequired:
          data.xpRequired.present ? data.xpRequired.value : this.xpRequired,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ThemeLevel(')
          ..write('themeId: $themeId, ')
          ..write('level: $level, ')
          ..write('xpRequired: $xpRequired')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(themeId, level, xpRequired);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ThemeLevel &&
          other.themeId == this.themeId &&
          other.level == this.level &&
          other.xpRequired == this.xpRequired);
}

class ThemeLevelsCompanion extends UpdateCompanion<ThemeLevel> {
  final Value<String> themeId;
  final Value<int> level;
  final Value<int> xpRequired;
  final Value<int> rowid;
  const ThemeLevelsCompanion({
    this.themeId = const Value.absent(),
    this.level = const Value.absent(),
    this.xpRequired = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ThemeLevelsCompanion.insert({
    required String themeId,
    required int level,
    required int xpRequired,
    this.rowid = const Value.absent(),
  })  : themeId = Value(themeId),
        level = Value(level),
        xpRequired = Value(xpRequired);
  static Insertable<ThemeLevel> custom({
    Expression<String>? themeId,
    Expression<int>? level,
    Expression<int>? xpRequired,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (themeId != null) 'theme_id': themeId,
      if (level != null) 'level': level,
      if (xpRequired != null) 'xp_required': xpRequired,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ThemeLevelsCompanion copyWith(
      {Value<String>? themeId,
      Value<int>? level,
      Value<int>? xpRequired,
      Value<int>? rowid}) {
    return ThemeLevelsCompanion(
      themeId: themeId ?? this.themeId,
      level: level ?? this.level,
      xpRequired: xpRequired ?? this.xpRequired,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (themeId.present) {
      map['theme_id'] = Variable<String>(themeId.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (xpRequired.present) {
      map['xp_required'] = Variable<int>(xpRequired.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ThemeLevelsCompanion(')
          ..write('themeId: $themeId, ')
          ..write('level: $level, ')
          ..write('xpRequired: $xpRequired, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ThemeTriggersTable extends ThemeTriggers
    with TableInfo<$ThemeTriggersTable, ThemeTrigger> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ThemeTriggersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _themeIdMeta =
      const VerificationMeta('themeId');
  @override
  late final GeneratedColumn<String> themeId = GeneratedColumn<String>(
      'theme_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES themes (id) ON DELETE CASCADE'));
  static const VerificationMeta _surahNumMeta =
      const VerificationMeta('surahNum');
  @override
  late final GeneratedColumn<int> surahNum = GeneratedColumn<int>(
      'surah_num', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _ayahNumMeta =
      const VerificationMeta('ayahNum');
  @override
  late final GeneratedColumn<int> ayahNum = GeneratedColumn<int>(
      'ayah_num', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _xpRewardMeta =
      const VerificationMeta('xpReward');
  @override
  late final GeneratedColumn<int> xpReward = GeneratedColumn<int>(
      'xp_reward', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(10));
  @override
  List<GeneratedColumn> get $columns => [themeId, surahNum, ayahNum, xpReward];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'theme_triggers';
  @override
  VerificationContext validateIntegrity(Insertable<ThemeTrigger> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('theme_id')) {
      context.handle(_themeIdMeta,
          themeId.isAcceptableOrUnknown(data['theme_id']!, _themeIdMeta));
    } else if (isInserting) {
      context.missing(_themeIdMeta);
    }
    if (data.containsKey('surah_num')) {
      context.handle(_surahNumMeta,
          surahNum.isAcceptableOrUnknown(data['surah_num']!, _surahNumMeta));
    } else if (isInserting) {
      context.missing(_surahNumMeta);
    }
    if (data.containsKey('ayah_num')) {
      context.handle(_ayahNumMeta,
          ayahNum.isAcceptableOrUnknown(data['ayah_num']!, _ayahNumMeta));
    } else if (isInserting) {
      context.missing(_ayahNumMeta);
    }
    if (data.containsKey('xp_reward')) {
      context.handle(_xpRewardMeta,
          xpReward.isAcceptableOrUnknown(data['xp_reward']!, _xpRewardMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {themeId, surahNum, ayahNum};
  @override
  ThemeTrigger map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ThemeTrigger(
      themeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}theme_id'])!,
      surahNum: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}surah_num'])!,
      ayahNum: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ayah_num'])!,
      xpReward: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}xp_reward'])!,
    );
  }

  @override
  $ThemeTriggersTable createAlias(String alias) {
    return $ThemeTriggersTable(attachedDatabase, alias);
  }
}

class ThemeTrigger extends DataClass implements Insertable<ThemeTrigger> {
  final String themeId;
  final int surahNum;
  final int ayahNum;
  final int xpReward;
  const ThemeTrigger(
      {required this.themeId,
      required this.surahNum,
      required this.ayahNum,
      required this.xpReward});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['theme_id'] = Variable<String>(themeId);
    map['surah_num'] = Variable<int>(surahNum);
    map['ayah_num'] = Variable<int>(ayahNum);
    map['xp_reward'] = Variable<int>(xpReward);
    return map;
  }

  ThemeTriggersCompanion toCompanion(bool nullToAbsent) {
    return ThemeTriggersCompanion(
      themeId: Value(themeId),
      surahNum: Value(surahNum),
      ayahNum: Value(ayahNum),
      xpReward: Value(xpReward),
    );
  }

  factory ThemeTrigger.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ThemeTrigger(
      themeId: serializer.fromJson<String>(json['themeId']),
      surahNum: serializer.fromJson<int>(json['surahNum']),
      ayahNum: serializer.fromJson<int>(json['ayahNum']),
      xpReward: serializer.fromJson<int>(json['xpReward']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'themeId': serializer.toJson<String>(themeId),
      'surahNum': serializer.toJson<int>(surahNum),
      'ayahNum': serializer.toJson<int>(ayahNum),
      'xpReward': serializer.toJson<int>(xpReward),
    };
  }

  ThemeTrigger copyWith(
          {String? themeId, int? surahNum, int? ayahNum, int? xpReward}) =>
      ThemeTrigger(
        themeId: themeId ?? this.themeId,
        surahNum: surahNum ?? this.surahNum,
        ayahNum: ayahNum ?? this.ayahNum,
        xpReward: xpReward ?? this.xpReward,
      );
  ThemeTrigger copyWithCompanion(ThemeTriggersCompanion data) {
    return ThemeTrigger(
      themeId: data.themeId.present ? data.themeId.value : this.themeId,
      surahNum: data.surahNum.present ? data.surahNum.value : this.surahNum,
      ayahNum: data.ayahNum.present ? data.ayahNum.value : this.ayahNum,
      xpReward: data.xpReward.present ? data.xpReward.value : this.xpReward,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ThemeTrigger(')
          ..write('themeId: $themeId, ')
          ..write('surahNum: $surahNum, ')
          ..write('ayahNum: $ayahNum, ')
          ..write('xpReward: $xpReward')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(themeId, surahNum, ayahNum, xpReward);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ThemeTrigger &&
          other.themeId == this.themeId &&
          other.surahNum == this.surahNum &&
          other.ayahNum == this.ayahNum &&
          other.xpReward == this.xpReward);
}

class ThemeTriggersCompanion extends UpdateCompanion<ThemeTrigger> {
  final Value<String> themeId;
  final Value<int> surahNum;
  final Value<int> ayahNum;
  final Value<int> xpReward;
  final Value<int> rowid;
  const ThemeTriggersCompanion({
    this.themeId = const Value.absent(),
    this.surahNum = const Value.absent(),
    this.ayahNum = const Value.absent(),
    this.xpReward = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ThemeTriggersCompanion.insert({
    required String themeId,
    required int surahNum,
    required int ayahNum,
    this.xpReward = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : themeId = Value(themeId),
        surahNum = Value(surahNum),
        ayahNum = Value(ayahNum);
  static Insertable<ThemeTrigger> custom({
    Expression<String>? themeId,
    Expression<int>? surahNum,
    Expression<int>? ayahNum,
    Expression<int>? xpReward,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (themeId != null) 'theme_id': themeId,
      if (surahNum != null) 'surah_num': surahNum,
      if (ayahNum != null) 'ayah_num': ayahNum,
      if (xpReward != null) 'xp_reward': xpReward,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ThemeTriggersCompanion copyWith(
      {Value<String>? themeId,
      Value<int>? surahNum,
      Value<int>? ayahNum,
      Value<int>? xpReward,
      Value<int>? rowid}) {
    return ThemeTriggersCompanion(
      themeId: themeId ?? this.themeId,
      surahNum: surahNum ?? this.surahNum,
      ayahNum: ayahNum ?? this.ayahNum,
      xpReward: xpReward ?? this.xpReward,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (themeId.present) {
      map['theme_id'] = Variable<String>(themeId.value);
    }
    if (surahNum.present) {
      map['surah_num'] = Variable<int>(surahNum.value);
    }
    if (ayahNum.present) {
      map['ayah_num'] = Variable<int>(ayahNum.value);
    }
    if (xpReward.present) {
      map['xp_reward'] = Variable<int>(xpReward.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ThemeTriggersCompanion(')
          ..write('themeId: $themeId, ')
          ..write('surahNum: $surahNum, ')
          ..write('ayahNum: $ayahNum, ')
          ..write('xpReward: $xpReward, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SetsTable extends Sets with TableInfo<$SetsTable, SetsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('// TODO: Tafsir — content team to supply'));
  static const VerificationMeta _isHiddenMeta =
      const VerificationMeta('isHidden');
  @override
  late final GeneratedColumn<bool> isHidden = GeneratedColumn<bool>(
      'is_hidden', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_hidden" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isVisibleMeta =
      const VerificationMeta('isVisible');
  @override
  late final GeneratedColumn<bool> isVisible = GeneratedColumn<bool>(
      'is_visible', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_visible" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, description, isHidden, isVisible, isCompleted];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sets';
  @override
  VerificationContext validateIntegrity(Insertable<SetsData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('is_hidden')) {
      context.handle(_isHiddenMeta,
          isHidden.isAcceptableOrUnknown(data['is_hidden']!, _isHiddenMeta));
    }
    if (data.containsKey('is_visible')) {
      context.handle(_isVisibleMeta,
          isVisible.isAcceptableOrUnknown(data['is_visible']!, _isVisibleMeta));
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SetsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SetsData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      isHidden: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_hidden'])!,
      isVisible: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_visible'])!,
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
    );
  }

  @override
  $SetsTable createAlias(String alias) {
    return $SetsTable(attachedDatabase, alias);
  }
}

class SetsData extends DataClass implements Insertable<SetsData> {
  final String id;
  final String name;
  final String description;
  final bool isHidden;
  final bool isVisible;
  final bool isCompleted;
  const SetsData(
      {required this.id,
      required this.name,
      required this.description,
      required this.isHidden,
      required this.isVisible,
      required this.isCompleted});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['is_hidden'] = Variable<bool>(isHidden);
    map['is_visible'] = Variable<bool>(isVisible);
    map['is_completed'] = Variable<bool>(isCompleted);
    return map;
  }

  SetsCompanion toCompanion(bool nullToAbsent) {
    return SetsCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      isHidden: Value(isHidden),
      isVisible: Value(isVisible),
      isCompleted: Value(isCompleted),
    );
  }

  factory SetsData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SetsData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      isHidden: serializer.fromJson<bool>(json['isHidden']),
      isVisible: serializer.fromJson<bool>(json['isVisible']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'isHidden': serializer.toJson<bool>(isHidden),
      'isVisible': serializer.toJson<bool>(isVisible),
      'isCompleted': serializer.toJson<bool>(isCompleted),
    };
  }

  SetsData copyWith(
          {String? id,
          String? name,
          String? description,
          bool? isHidden,
          bool? isVisible,
          bool? isCompleted}) =>
      SetsData(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        isHidden: isHidden ?? this.isHidden,
        isVisible: isVisible ?? this.isVisible,
        isCompleted: isCompleted ?? this.isCompleted,
      );
  SetsData copyWithCompanion(SetsCompanion data) {
    return SetsData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      isHidden: data.isHidden.present ? data.isHidden.value : this.isHidden,
      isVisible: data.isVisible.present ? data.isVisible.value : this.isVisible,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SetsData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('isHidden: $isHidden, ')
          ..write('isVisible: $isVisible, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, description, isHidden, isVisible, isCompleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SetsData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.isHidden == this.isHidden &&
          other.isVisible == this.isVisible &&
          other.isCompleted == this.isCompleted);
}

class SetsCompanion extends UpdateCompanion<SetsData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> description;
  final Value<bool> isHidden;
  final Value<bool> isVisible;
  final Value<bool> isCompleted;
  final Value<int> rowid;
  const SetsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.isHidden = const Value.absent(),
    this.isVisible = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SetsCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    this.isHidden = const Value.absent(),
    this.isVisible = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<SetsData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<bool>? isHidden,
    Expression<bool>? isVisible,
    Expression<bool>? isCompleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (isHidden != null) 'is_hidden': isHidden,
      if (isVisible != null) 'is_visible': isVisible,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SetsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? description,
      Value<bool>? isHidden,
      Value<bool>? isVisible,
      Value<bool>? isCompleted,
      Value<int>? rowid}) {
    return SetsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      isHidden: isHidden ?? this.isHidden,
      isVisible: isVisible ?? this.isVisible,
      isCompleted: isCompleted ?? this.isCompleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isHidden.present) {
      map['is_hidden'] = Variable<bool>(isHidden.value);
    }
    if (isVisible.present) {
      map['is_visible'] = Variable<bool>(isVisible.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SetsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('isHidden: $isHidden, ')
          ..write('isVisible: $isVisible, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SetRequirementsTable extends SetRequirements
    with TableInfo<$SetRequirementsTable, SetRequirement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SetRequirementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _setIdMeta = const VerificationMeta('setId');
  @override
  late final GeneratedColumn<String> setId = GeneratedColumn<String>(
      'set_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES sets (id) ON DELETE CASCADE'));
  static const VerificationMeta _requiredEntityIdMeta =
      const VerificationMeta('requiredEntityId');
  @override
  late final GeneratedColumn<String> requiredEntityId = GeneratedColumn<String>(
      'required_entity_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES entities (id) ON DELETE CASCADE'));
  @override
  List<GeneratedColumn> get $columns => [setId, requiredEntityId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'set_requirements';
  @override
  VerificationContext validateIntegrity(Insertable<SetRequirement> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('set_id')) {
      context.handle(
          _setIdMeta, setId.isAcceptableOrUnknown(data['set_id']!, _setIdMeta));
    } else if (isInserting) {
      context.missing(_setIdMeta);
    }
    if (data.containsKey('required_entity_id')) {
      context.handle(
          _requiredEntityIdMeta,
          requiredEntityId.isAcceptableOrUnknown(
              data['required_entity_id']!, _requiredEntityIdMeta));
    } else if (isInserting) {
      context.missing(_requiredEntityIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {setId, requiredEntityId};
  @override
  SetRequirement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SetRequirement(
      setId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}set_id'])!,
      requiredEntityId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}required_entity_id'])!,
    );
  }

  @override
  $SetRequirementsTable createAlias(String alias) {
    return $SetRequirementsTable(attachedDatabase, alias);
  }
}

class SetRequirement extends DataClass implements Insertable<SetRequirement> {
  final String setId;
  final String requiredEntityId;
  const SetRequirement({required this.setId, required this.requiredEntityId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['set_id'] = Variable<String>(setId);
    map['required_entity_id'] = Variable<String>(requiredEntityId);
    return map;
  }

  SetRequirementsCompanion toCompanion(bool nullToAbsent) {
    return SetRequirementsCompanion(
      setId: Value(setId),
      requiredEntityId: Value(requiredEntityId),
    );
  }

  factory SetRequirement.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SetRequirement(
      setId: serializer.fromJson<String>(json['setId']),
      requiredEntityId: serializer.fromJson<String>(json['requiredEntityId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'setId': serializer.toJson<String>(setId),
      'requiredEntityId': serializer.toJson<String>(requiredEntityId),
    };
  }

  SetRequirement copyWith({String? setId, String? requiredEntityId}) =>
      SetRequirement(
        setId: setId ?? this.setId,
        requiredEntityId: requiredEntityId ?? this.requiredEntityId,
      );
  SetRequirement copyWithCompanion(SetRequirementsCompanion data) {
    return SetRequirement(
      setId: data.setId.present ? data.setId.value : this.setId,
      requiredEntityId: data.requiredEntityId.present
          ? data.requiredEntityId.value
          : this.requiredEntityId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SetRequirement(')
          ..write('setId: $setId, ')
          ..write('requiredEntityId: $requiredEntityId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(setId, requiredEntityId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SetRequirement &&
          other.setId == this.setId &&
          other.requiredEntityId == this.requiredEntityId);
}

class SetRequirementsCompanion extends UpdateCompanion<SetRequirement> {
  final Value<String> setId;
  final Value<String> requiredEntityId;
  final Value<int> rowid;
  const SetRequirementsCompanion({
    this.setId = const Value.absent(),
    this.requiredEntityId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SetRequirementsCompanion.insert({
    required String setId,
    required String requiredEntityId,
    this.rowid = const Value.absent(),
  })  : setId = Value(setId),
        requiredEntityId = Value(requiredEntityId);
  static Insertable<SetRequirement> custom({
    Expression<String>? setId,
    Expression<String>? requiredEntityId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (setId != null) 'set_id': setId,
      if (requiredEntityId != null) 'required_entity_id': requiredEntityId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SetRequirementsCompanion copyWith(
      {Value<String>? setId,
      Value<String>? requiredEntityId,
      Value<int>? rowid}) {
    return SetRequirementsCompanion(
      setId: setId ?? this.setId,
      requiredEntityId: requiredEntityId ?? this.requiredEntityId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (setId.present) {
      map['set_id'] = Variable<String>(setId.value);
    }
    if (requiredEntityId.present) {
      map['required_entity_id'] = Variable<String>(requiredEntityId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SetRequirementsCompanion(')
          ..write('setId: $setId, ')
          ..write('requiredEntityId: $requiredEntityId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CollectionsTable extends Collections
    with TableInfo<$CollectionsTable, Collection> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CollectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('// TODO: Tafsir — content team to supply'));
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [id, name, description, isCompleted];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'collections';
  @override
  VerificationContext validateIntegrity(Insertable<Collection> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Collection map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Collection(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
    );
  }

  @override
  $CollectionsTable createAlias(String alias) {
    return $CollectionsTable(attachedDatabase, alias);
  }
}

class Collection extends DataClass implements Insertable<Collection> {
  final String id;
  final String name;
  final String description;
  final bool isCompleted;
  const Collection(
      {required this.id,
      required this.name,
      required this.description,
      required this.isCompleted});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['is_completed'] = Variable<bool>(isCompleted);
    return map;
  }

  CollectionsCompanion toCompanion(bool nullToAbsent) {
    return CollectionsCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      isCompleted: Value(isCompleted),
    );
  }

  factory Collection.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Collection(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'isCompleted': serializer.toJson<bool>(isCompleted),
    };
  }

  Collection copyWith(
          {String? id, String? name, String? description, bool? isCompleted}) =>
      Collection(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        isCompleted: isCompleted ?? this.isCompleted,
      );
  Collection copyWithCompanion(CollectionsCompanion data) {
    return Collection(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Collection(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, isCompleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Collection &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.isCompleted == this.isCompleted);
}

class CollectionsCompanion extends UpdateCompanion<Collection> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> description;
  final Value<bool> isCompleted;
  final Value<int> rowid;
  const CollectionsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CollectionsCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<Collection> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<bool>? isCompleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CollectionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? description,
      Value<bool>? isCompleted,
      Value<int>? rowid}) {
    return CollectionsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CollectionsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CollectionEntitiesTable extends CollectionEntities
    with TableInfo<$CollectionEntitiesTable, CollectionEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CollectionEntitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _collectionIdMeta =
      const VerificationMeta('collectionId');
  @override
  late final GeneratedColumn<String> collectionId = GeneratedColumn<String>(
      'collection_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES collections (id) ON DELETE CASCADE'));
  static const VerificationMeta _entityIdMeta =
      const VerificationMeta('entityId');
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
      'entity_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES entities (id) ON DELETE CASCADE'));
  @override
  List<GeneratedColumn> get $columns => [collectionId, entityId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'collection_entities';
  @override
  VerificationContext validateIntegrity(Insertable<CollectionEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('collection_id')) {
      context.handle(
          _collectionIdMeta,
          collectionId.isAcceptableOrUnknown(
              data['collection_id']!, _collectionIdMeta));
    } else if (isInserting) {
      context.missing(_collectionIdMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(_entityIdMeta,
          entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta));
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {collectionId, entityId};
  @override
  CollectionEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CollectionEntity(
      collectionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}collection_id'])!,
      entityId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_id'])!,
    );
  }

  @override
  $CollectionEntitiesTable createAlias(String alias) {
    return $CollectionEntitiesTable(attachedDatabase, alias);
  }
}

class CollectionEntity extends DataClass
    implements Insertable<CollectionEntity> {
  final String collectionId;
  final String entityId;
  const CollectionEntity({required this.collectionId, required this.entityId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['collection_id'] = Variable<String>(collectionId);
    map['entity_id'] = Variable<String>(entityId);
    return map;
  }

  CollectionEntitiesCompanion toCompanion(bool nullToAbsent) {
    return CollectionEntitiesCompanion(
      collectionId: Value(collectionId),
      entityId: Value(entityId),
    );
  }

  factory CollectionEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CollectionEntity(
      collectionId: serializer.fromJson<String>(json['collectionId']),
      entityId: serializer.fromJson<String>(json['entityId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'collectionId': serializer.toJson<String>(collectionId),
      'entityId': serializer.toJson<String>(entityId),
    };
  }

  CollectionEntity copyWith({String? collectionId, String? entityId}) =>
      CollectionEntity(
        collectionId: collectionId ?? this.collectionId,
        entityId: entityId ?? this.entityId,
      );
  CollectionEntity copyWithCompanion(CollectionEntitiesCompanion data) {
    return CollectionEntity(
      collectionId: data.collectionId.present
          ? data.collectionId.value
          : this.collectionId,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CollectionEntity(')
          ..write('collectionId: $collectionId, ')
          ..write('entityId: $entityId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(collectionId, entityId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CollectionEntity &&
          other.collectionId == this.collectionId &&
          other.entityId == this.entityId);
}

class CollectionEntitiesCompanion extends UpdateCompanion<CollectionEntity> {
  final Value<String> collectionId;
  final Value<String> entityId;
  final Value<int> rowid;
  const CollectionEntitiesCompanion({
    this.collectionId = const Value.absent(),
    this.entityId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CollectionEntitiesCompanion.insert({
    required String collectionId,
    required String entityId,
    this.rowid = const Value.absent(),
  })  : collectionId = Value(collectionId),
        entityId = Value(entityId);
  static Insertable<CollectionEntity> custom({
    Expression<String>? collectionId,
    Expression<String>? entityId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (collectionId != null) 'collection_id': collectionId,
      if (entityId != null) 'entity_id': entityId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CollectionEntitiesCompanion copyWith(
      {Value<String>? collectionId,
      Value<String>? entityId,
      Value<int>? rowid}) {
    return CollectionEntitiesCompanion(
      collectionId: collectionId ?? this.collectionId,
      entityId: entityId ?? this.entityId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (collectionId.present) {
      map['collection_id'] = Variable<String>(collectionId.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CollectionEntitiesCompanion(')
          ..write('collectionId: $collectionId, ')
          ..write('entityId: $entityId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExpeditionsTable extends Expeditions
    with TableInfo<$ExpeditionsTable, Expedition> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpeditionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('// TODO: Tafsir — content team to supply'));
  static const VerificationMeta _progressMeta =
      const VerificationMeta('progress');
  @override
  late final GeneratedColumn<double> progress = GeneratedColumn<double>(
      'progress', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, description, progress, isCompleted];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expeditions';
  @override
  VerificationContext validateIntegrity(Insertable<Expedition> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('progress')) {
      context.handle(_progressMeta,
          progress.isAcceptableOrUnknown(data['progress']!, _progressMeta));
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Expedition map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Expedition(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      progress: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}progress'])!,
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
    );
  }

  @override
  $ExpeditionsTable createAlias(String alias) {
    return $ExpeditionsTable(attachedDatabase, alias);
  }
}

class Expedition extends DataClass implements Insertable<Expedition> {
  final String id;
  final String name;
  final String description;
  final double progress;
  final bool isCompleted;
  const Expedition(
      {required this.id,
      required this.name,
      required this.description,
      required this.progress,
      required this.isCompleted});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['progress'] = Variable<double>(progress);
    map['is_completed'] = Variable<bool>(isCompleted);
    return map;
  }

  ExpeditionsCompanion toCompanion(bool nullToAbsent) {
    return ExpeditionsCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      progress: Value(progress),
      isCompleted: Value(isCompleted),
    );
  }

  factory Expedition.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Expedition(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      progress: serializer.fromJson<double>(json['progress']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'progress': serializer.toJson<double>(progress),
      'isCompleted': serializer.toJson<bool>(isCompleted),
    };
  }

  Expedition copyWith(
          {String? id,
          String? name,
          String? description,
          double? progress,
          bool? isCompleted}) =>
      Expedition(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        progress: progress ?? this.progress,
        isCompleted: isCompleted ?? this.isCompleted,
      );
  Expedition copyWithCompanion(ExpeditionsCompanion data) {
    return Expedition(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      progress: data.progress.present ? data.progress.value : this.progress,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Expedition(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('progress: $progress, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, progress, isCompleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Expedition &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.progress == this.progress &&
          other.isCompleted == this.isCompleted);
}

class ExpeditionsCompanion extends UpdateCompanion<Expedition> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> description;
  final Value<double> progress;
  final Value<bool> isCompleted;
  final Value<int> rowid;
  const ExpeditionsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.progress = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpeditionsCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    this.progress = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<Expedition> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<double>? progress,
    Expression<bool>? isCompleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (progress != null) 'progress': progress,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpeditionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? description,
      Value<double>? progress,
      Value<bool>? isCompleted,
      Value<int>? rowid}) {
    return ExpeditionsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      progress: progress ?? this.progress,
      isCompleted: isCompleted ?? this.isCompleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (progress.present) {
      map['progress'] = Variable<double>(progress.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpeditionsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('progress: $progress, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserProgressTable extends UserProgress
    with TableInfo<$UserProgressTable, UserProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _totalVersesReadMeta =
      const VerificationMeta('totalVersesRead');
  @override
  late final GeneratedColumn<int> totalVersesRead = GeneratedColumn<int>(
      'total_verses_read', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _streakDaysMeta =
      const VerificationMeta('streakDays');
  @override
  late final GeneratedColumn<int> streakDays = GeneratedColumn<int>(
      'streak_days', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lastReadDateMeta =
      const VerificationMeta('lastReadDate');
  @override
  late final GeneratedColumn<String> lastReadDate = GeneratedColumn<String>(
      'last_read_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _premiumUnlockedMeta =
      const VerificationMeta('premiumUnlocked');
  @override
  late final GeneratedColumn<bool> premiumUnlocked = GeneratedColumn<bool>(
      'premium_unlocked', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("premium_unlocked" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, totalVersesRead, streakDays, lastReadDate, premiumUnlocked];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_progress';
  @override
  VerificationContext validateIntegrity(Insertable<UserProgressData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('total_verses_read')) {
      context.handle(
          _totalVersesReadMeta,
          totalVersesRead.isAcceptableOrUnknown(
              data['total_verses_read']!, _totalVersesReadMeta));
    }
    if (data.containsKey('streak_days')) {
      context.handle(
          _streakDaysMeta,
          streakDays.isAcceptableOrUnknown(
              data['streak_days']!, _streakDaysMeta));
    }
    if (data.containsKey('last_read_date')) {
      context.handle(
          _lastReadDateMeta,
          lastReadDate.isAcceptableOrUnknown(
              data['last_read_date']!, _lastReadDateMeta));
    }
    if (data.containsKey('premium_unlocked')) {
      context.handle(
          _premiumUnlockedMeta,
          premiumUnlocked.isAcceptableOrUnknown(
              data['premium_unlocked']!, _premiumUnlockedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProgressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProgressData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      totalVersesRead: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_verses_read'])!,
      streakDays: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}streak_days'])!,
      lastReadDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_read_date']),
      premiumUnlocked: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}premium_unlocked'])!,
    );
  }

  @override
  $UserProgressTable createAlias(String alias) {
    return $UserProgressTable(attachedDatabase, alias);
  }
}

class UserProgressData extends DataClass
    implements Insertable<UserProgressData> {
  final int id;
  final int totalVersesRead;
  final int streakDays;
  final String? lastReadDate;
  final bool premiumUnlocked;
  const UserProgressData(
      {required this.id,
      required this.totalVersesRead,
      required this.streakDays,
      this.lastReadDate,
      required this.premiumUnlocked});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['total_verses_read'] = Variable<int>(totalVersesRead);
    map['streak_days'] = Variable<int>(streakDays);
    if (!nullToAbsent || lastReadDate != null) {
      map['last_read_date'] = Variable<String>(lastReadDate);
    }
    map['premium_unlocked'] = Variable<bool>(premiumUnlocked);
    return map;
  }

  UserProgressCompanion toCompanion(bool nullToAbsent) {
    return UserProgressCompanion(
      id: Value(id),
      totalVersesRead: Value(totalVersesRead),
      streakDays: Value(streakDays),
      lastReadDate: lastReadDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastReadDate),
      premiumUnlocked: Value(premiumUnlocked),
    );
  }

  factory UserProgressData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProgressData(
      id: serializer.fromJson<int>(json['id']),
      totalVersesRead: serializer.fromJson<int>(json['totalVersesRead']),
      streakDays: serializer.fromJson<int>(json['streakDays']),
      lastReadDate: serializer.fromJson<String?>(json['lastReadDate']),
      premiumUnlocked: serializer.fromJson<bool>(json['premiumUnlocked']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'totalVersesRead': serializer.toJson<int>(totalVersesRead),
      'streakDays': serializer.toJson<int>(streakDays),
      'lastReadDate': serializer.toJson<String?>(lastReadDate),
      'premiumUnlocked': serializer.toJson<bool>(premiumUnlocked),
    };
  }

  UserProgressData copyWith(
          {int? id,
          int? totalVersesRead,
          int? streakDays,
          Value<String?> lastReadDate = const Value.absent(),
          bool? premiumUnlocked}) =>
      UserProgressData(
        id: id ?? this.id,
        totalVersesRead: totalVersesRead ?? this.totalVersesRead,
        streakDays: streakDays ?? this.streakDays,
        lastReadDate:
            lastReadDate.present ? lastReadDate.value : this.lastReadDate,
        premiumUnlocked: premiumUnlocked ?? this.premiumUnlocked,
      );
  UserProgressData copyWithCompanion(UserProgressCompanion data) {
    return UserProgressData(
      id: data.id.present ? data.id.value : this.id,
      totalVersesRead: data.totalVersesRead.present
          ? data.totalVersesRead.value
          : this.totalVersesRead,
      streakDays:
          data.streakDays.present ? data.streakDays.value : this.streakDays,
      lastReadDate: data.lastReadDate.present
          ? data.lastReadDate.value
          : this.lastReadDate,
      premiumUnlocked: data.premiumUnlocked.present
          ? data.premiumUnlocked.value
          : this.premiumUnlocked,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProgressData(')
          ..write('id: $id, ')
          ..write('totalVersesRead: $totalVersesRead, ')
          ..write('streakDays: $streakDays, ')
          ..write('lastReadDate: $lastReadDate, ')
          ..write('premiumUnlocked: $premiumUnlocked')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, totalVersesRead, streakDays, lastReadDate, premiumUnlocked);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProgressData &&
          other.id == this.id &&
          other.totalVersesRead == this.totalVersesRead &&
          other.streakDays == this.streakDays &&
          other.lastReadDate == this.lastReadDate &&
          other.premiumUnlocked == this.premiumUnlocked);
}

class UserProgressCompanion extends UpdateCompanion<UserProgressData> {
  final Value<int> id;
  final Value<int> totalVersesRead;
  final Value<int> streakDays;
  final Value<String?> lastReadDate;
  final Value<bool> premiumUnlocked;
  const UserProgressCompanion({
    this.id = const Value.absent(),
    this.totalVersesRead = const Value.absent(),
    this.streakDays = const Value.absent(),
    this.lastReadDate = const Value.absent(),
    this.premiumUnlocked = const Value.absent(),
  });
  UserProgressCompanion.insert({
    this.id = const Value.absent(),
    this.totalVersesRead = const Value.absent(),
    this.streakDays = const Value.absent(),
    this.lastReadDate = const Value.absent(),
    this.premiumUnlocked = const Value.absent(),
  });
  static Insertable<UserProgressData> custom({
    Expression<int>? id,
    Expression<int>? totalVersesRead,
    Expression<int>? streakDays,
    Expression<String>? lastReadDate,
    Expression<bool>? premiumUnlocked,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (totalVersesRead != null) 'total_verses_read': totalVersesRead,
      if (streakDays != null) 'streak_days': streakDays,
      if (lastReadDate != null) 'last_read_date': lastReadDate,
      if (premiumUnlocked != null) 'premium_unlocked': premiumUnlocked,
    });
  }

  UserProgressCompanion copyWith(
      {Value<int>? id,
      Value<int>? totalVersesRead,
      Value<int>? streakDays,
      Value<String?>? lastReadDate,
      Value<bool>? premiumUnlocked}) {
    return UserProgressCompanion(
      id: id ?? this.id,
      totalVersesRead: totalVersesRead ?? this.totalVersesRead,
      streakDays: streakDays ?? this.streakDays,
      lastReadDate: lastReadDate ?? this.lastReadDate,
      premiumUnlocked: premiumUnlocked ?? this.premiumUnlocked,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (totalVersesRead.present) {
      map['total_verses_read'] = Variable<int>(totalVersesRead.value);
    }
    if (streakDays.present) {
      map['streak_days'] = Variable<int>(streakDays.value);
    }
    if (lastReadDate.present) {
      map['last_read_date'] = Variable<String>(lastReadDate.value);
    }
    if (premiumUnlocked.present) {
      map['premium_unlocked'] = Variable<bool>(premiumUnlocked.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProgressCompanion(')
          ..write('id: $id, ')
          ..write('totalVersesRead: $totalVersesRead, ')
          ..write('streakDays: $streakDays, ')
          ..write('lastReadDate: $lastReadDate, ')
          ..write('premiumUnlocked: $premiumUnlocked')
          ..write(')'))
        .toString();
  }
}

class $BookmarksTable extends Bookmarks
    with TableInfo<$BookmarksTable, Bookmark> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookmarksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _surahNumMeta =
      const VerificationMeta('surahNum');
  @override
  late final GeneratedColumn<int> surahNum = GeneratedColumn<int>(
      'surah_num', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _ayahNumMeta =
      const VerificationMeta('ayahNum');
  @override
  late final GeneratedColumn<int> ayahNum = GeneratedColumn<int>(
      'ayah_num', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _bookmarkedAtMeta =
      const VerificationMeta('bookmarkedAt');
  @override
  late final GeneratedColumn<String> bookmarkedAt = GeneratedColumn<String>(
      'bookmarked_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, surahNum, ayahNum, bookmarkedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bookmarks';
  @override
  VerificationContext validateIntegrity(Insertable<Bookmark> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('surah_num')) {
      context.handle(_surahNumMeta,
          surahNum.isAcceptableOrUnknown(data['surah_num']!, _surahNumMeta));
    } else if (isInserting) {
      context.missing(_surahNumMeta);
    }
    if (data.containsKey('ayah_num')) {
      context.handle(_ayahNumMeta,
          ayahNum.isAcceptableOrUnknown(data['ayah_num']!, _ayahNumMeta));
    } else if (isInserting) {
      context.missing(_ayahNumMeta);
    }
    if (data.containsKey('bookmarked_at')) {
      context.handle(
          _bookmarkedAtMeta,
          bookmarkedAt.isAcceptableOrUnknown(
              data['bookmarked_at']!, _bookmarkedAtMeta));
    } else if (isInserting) {
      context.missing(_bookmarkedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Bookmark map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Bookmark(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      surahNum: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}surah_num'])!,
      ayahNum: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ayah_num'])!,
      bookmarkedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}bookmarked_at'])!,
    );
  }

  @override
  $BookmarksTable createAlias(String alias) {
    return $BookmarksTable(attachedDatabase, alias);
  }
}

class Bookmark extends DataClass implements Insertable<Bookmark> {
  final int id;
  final int surahNum;
  final int ayahNum;
  final String bookmarkedAt;
  const Bookmark(
      {required this.id,
      required this.surahNum,
      required this.ayahNum,
      required this.bookmarkedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['surah_num'] = Variable<int>(surahNum);
    map['ayah_num'] = Variable<int>(ayahNum);
    map['bookmarked_at'] = Variable<String>(bookmarkedAt);
    return map;
  }

  BookmarksCompanion toCompanion(bool nullToAbsent) {
    return BookmarksCompanion(
      id: Value(id),
      surahNum: Value(surahNum),
      ayahNum: Value(ayahNum),
      bookmarkedAt: Value(bookmarkedAt),
    );
  }

  factory Bookmark.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Bookmark(
      id: serializer.fromJson<int>(json['id']),
      surahNum: serializer.fromJson<int>(json['surahNum']),
      ayahNum: serializer.fromJson<int>(json['ayahNum']),
      bookmarkedAt: serializer.fromJson<String>(json['bookmarkedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'surahNum': serializer.toJson<int>(surahNum),
      'ayahNum': serializer.toJson<int>(ayahNum),
      'bookmarkedAt': serializer.toJson<String>(bookmarkedAt),
    };
  }

  Bookmark copyWith(
          {int? id, int? surahNum, int? ayahNum, String? bookmarkedAt}) =>
      Bookmark(
        id: id ?? this.id,
        surahNum: surahNum ?? this.surahNum,
        ayahNum: ayahNum ?? this.ayahNum,
        bookmarkedAt: bookmarkedAt ?? this.bookmarkedAt,
      );
  Bookmark copyWithCompanion(BookmarksCompanion data) {
    return Bookmark(
      id: data.id.present ? data.id.value : this.id,
      surahNum: data.surahNum.present ? data.surahNum.value : this.surahNum,
      ayahNum: data.ayahNum.present ? data.ayahNum.value : this.ayahNum,
      bookmarkedAt: data.bookmarkedAt.present
          ? data.bookmarkedAt.value
          : this.bookmarkedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Bookmark(')
          ..write('id: $id, ')
          ..write('surahNum: $surahNum, ')
          ..write('ayahNum: $ayahNum, ')
          ..write('bookmarkedAt: $bookmarkedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, surahNum, ayahNum, bookmarkedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bookmark &&
          other.id == this.id &&
          other.surahNum == this.surahNum &&
          other.ayahNum == this.ayahNum &&
          other.bookmarkedAt == this.bookmarkedAt);
}

class BookmarksCompanion extends UpdateCompanion<Bookmark> {
  final Value<int> id;
  final Value<int> surahNum;
  final Value<int> ayahNum;
  final Value<String> bookmarkedAt;
  const BookmarksCompanion({
    this.id = const Value.absent(),
    this.surahNum = const Value.absent(),
    this.ayahNum = const Value.absent(),
    this.bookmarkedAt = const Value.absent(),
  });
  BookmarksCompanion.insert({
    this.id = const Value.absent(),
    required int surahNum,
    required int ayahNum,
    required String bookmarkedAt,
  })  : surahNum = Value(surahNum),
        ayahNum = Value(ayahNum),
        bookmarkedAt = Value(bookmarkedAt);
  static Insertable<Bookmark> custom({
    Expression<int>? id,
    Expression<int>? surahNum,
    Expression<int>? ayahNum,
    Expression<String>? bookmarkedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surahNum != null) 'surah_num': surahNum,
      if (ayahNum != null) 'ayah_num': ayahNum,
      if (bookmarkedAt != null) 'bookmarked_at': bookmarkedAt,
    });
  }

  BookmarksCompanion copyWith(
      {Value<int>? id,
      Value<int>? surahNum,
      Value<int>? ayahNum,
      Value<String>? bookmarkedAt}) {
    return BookmarksCompanion(
      id: id ?? this.id,
      surahNum: surahNum ?? this.surahNum,
      ayahNum: ayahNum ?? this.ayahNum,
      bookmarkedAt: bookmarkedAt ?? this.bookmarkedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (surahNum.present) {
      map['surah_num'] = Variable<int>(surahNum.value);
    }
    if (ayahNum.present) {
      map['ayah_num'] = Variable<int>(ayahNum.value);
    }
    if (bookmarkedAt.present) {
      map['bookmarked_at'] = Variable<String>(bookmarkedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookmarksCompanion(')
          ..write('id: $id, ')
          ..write('surahNum: $surahNum, ')
          ..write('ayahNum: $ayahNum, ')
          ..write('bookmarkedAt: $bookmarkedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $VersesTable verses = $VersesTable(this);
  late final $EntitiesTable entities = $EntitiesTable(this);
  late final $EntityTriggersTable entityTriggers = $EntityTriggersTable(this);
  late final $RelationEdgesTable relationEdges = $RelationEdgesTable(this);
  late final $ConstellationEdgesTable constellationEdges =
      $ConstellationEdgesTable(this);
  late final $StoriesTable stories = $StoriesTable(this);
  late final $StoryVerseRangesTable storyVerseRanges =
      $StoryVerseRangesTable(this);
  late final $ThemesTable themes = $ThemesTable(this);
  late final $ThemeLevelsTable themeLevels = $ThemeLevelsTable(this);
  late final $ThemeTriggersTable themeTriggers = $ThemeTriggersTable(this);
  late final $SetsTable sets = $SetsTable(this);
  late final $SetRequirementsTable setRequirements =
      $SetRequirementsTable(this);
  late final $CollectionsTable collections = $CollectionsTable(this);
  late final $CollectionEntitiesTable collectionEntities =
      $CollectionEntitiesTable(this);
  late final $ExpeditionsTable expeditions = $ExpeditionsTable(this);
  late final $UserProgressTable userProgress = $UserProgressTable(this);
  late final $BookmarksTable bookmarks = $BookmarksTable(this);
  late final ReaderDao readerDao = ReaderDao(this as AppDatabase);
  late final EntityDao entityDao = EntityDao(this as AppDatabase);
  late final StoryThemeDao storyThemeDao = StoryThemeDao(this as AppDatabase);
  late final SetCollectionDao setCollectionDao =
      SetCollectionDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        verses,
        entities,
        entityTriggers,
        relationEdges,
        constellationEdges,
        stories,
        storyVerseRanges,
        themes,
        themeLevels,
        themeTriggers,
        sets,
        setRequirements,
        collections,
        collectionEntities,
        expeditions,
        userProgress,
        bookmarks
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('entities',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('entity_triggers', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('entities',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('relation_edges', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('entities',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('relation_edges', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('entities',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('constellation_edges', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('entities',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('constellation_edges', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('stories',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('story_verse_ranges', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('themes',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('theme_levels', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('themes',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('theme_triggers', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('sets',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('set_requirements', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('entities',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('set_requirements', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('collections',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('collection_entities', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('entities',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('collection_entities', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$VersesTableCreateCompanionBuilder = VersesCompanion Function({
  required int surahNum,
  required int ayahNum,
  required String textArabic,
  required String textTranslation,
  Value<bool> isRead,
  Value<int> rowid,
});
typedef $$VersesTableUpdateCompanionBuilder = VersesCompanion Function({
  Value<int> surahNum,
  Value<int> ayahNum,
  Value<String> textArabic,
  Value<String> textTranslation,
  Value<bool> isRead,
  Value<int> rowid,
});

class $$VersesTableFilterComposer
    extends Composer<_$AppDatabase, $VersesTable> {
  $$VersesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get surahNum => $composableBuilder(
      column: $table.surahNum, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ayahNum => $composableBuilder(
      column: $table.ayahNum, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get textArabic => $composableBuilder(
      column: $table.textArabic, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get textTranslation => $composableBuilder(
      column: $table.textTranslation,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isRead => $composableBuilder(
      column: $table.isRead, builder: (column) => ColumnFilters(column));
}

class $$VersesTableOrderingComposer
    extends Composer<_$AppDatabase, $VersesTable> {
  $$VersesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get surahNum => $composableBuilder(
      column: $table.surahNum, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ayahNum => $composableBuilder(
      column: $table.ayahNum, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get textArabic => $composableBuilder(
      column: $table.textArabic, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get textTranslation => $composableBuilder(
      column: $table.textTranslation,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isRead => $composableBuilder(
      column: $table.isRead, builder: (column) => ColumnOrderings(column));
}

class $$VersesTableAnnotationComposer
    extends Composer<_$AppDatabase, $VersesTable> {
  $$VersesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get surahNum =>
      $composableBuilder(column: $table.surahNum, builder: (column) => column);

  GeneratedColumn<int> get ayahNum =>
      $composableBuilder(column: $table.ayahNum, builder: (column) => column);

  GeneratedColumn<String> get textArabic => $composableBuilder(
      column: $table.textArabic, builder: (column) => column);

  GeneratedColumn<String> get textTranslation => $composableBuilder(
      column: $table.textTranslation, builder: (column) => column);

  GeneratedColumn<bool> get isRead =>
      $composableBuilder(column: $table.isRead, builder: (column) => column);
}

class $$VersesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $VersesTable,
    Verse,
    $$VersesTableFilterComposer,
    $$VersesTableOrderingComposer,
    $$VersesTableAnnotationComposer,
    $$VersesTableCreateCompanionBuilder,
    $$VersesTableUpdateCompanionBuilder,
    (Verse, BaseReferences<_$AppDatabase, $VersesTable, Verse>),
    Verse,
    PrefetchHooks Function()> {
  $$VersesTableTableManager(_$AppDatabase db, $VersesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VersesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VersesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VersesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> surahNum = const Value.absent(),
            Value<int> ayahNum = const Value.absent(),
            Value<String> textArabic = const Value.absent(),
            Value<String> textTranslation = const Value.absent(),
            Value<bool> isRead = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              VersesCompanion(
            surahNum: surahNum,
            ayahNum: ayahNum,
            textArabic: textArabic,
            textTranslation: textTranslation,
            isRead: isRead,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int surahNum,
            required int ayahNum,
            required String textArabic,
            required String textTranslation,
            Value<bool> isRead = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              VersesCompanion.insert(
            surahNum: surahNum,
            ayahNum: ayahNum,
            textArabic: textArabic,
            textTranslation: textTranslation,
            isRead: isRead,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$VersesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $VersesTable,
    Verse,
    $$VersesTableFilterComposer,
    $$VersesTableOrderingComposer,
    $$VersesTableAnnotationComposer,
    $$VersesTableCreateCompanionBuilder,
    $$VersesTableUpdateCompanionBuilder,
    (Verse, BaseReferences<_$AppDatabase, $VersesTable, Verse>),
    Verse,
    PrefetchHooks Function()>;
typedef $$EntitiesTableCreateCompanionBuilder = EntitiesCompanion Function({
  required String id,
  required String name,
  required String type,
  Value<bool> isRare,
  Value<String?> region,
  Value<String> description,
  Value<bool> isDiscovered,
  Value<int> rowid,
});
typedef $$EntitiesTableUpdateCompanionBuilder = EntitiesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> type,
  Value<bool> isRare,
  Value<String?> region,
  Value<String> description,
  Value<bool> isDiscovered,
  Value<int> rowid,
});

final class $$EntitiesTableReferences
    extends BaseReferences<_$AppDatabase, $EntitiesTable, Entity> {
  $$EntitiesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EntityTriggersTable, List<EntityTrigger>>
      _entityTriggersRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.entityTriggers,
              aliasName: $_aliasNameGenerator(
                  db.entities.id, db.entityTriggers.entityId));

  $$EntityTriggersTableProcessedTableManager get entityTriggersRefs {
    final manager = $$EntityTriggersTableTableManager($_db, $_db.entityTriggers)
        .filter((f) => f.entityId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_entityTriggersRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SetRequirementsTable, List<SetRequirement>>
      _setRequirementsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.setRequirements,
              aliasName: $_aliasNameGenerator(
                  db.entities.id, db.setRequirements.requiredEntityId));

  $$SetRequirementsTableProcessedTableManager get setRequirementsRefs {
    final manager =
        $$SetRequirementsTableTableManager($_db, $_db.setRequirements).filter(
            (f) =>
                f.requiredEntityId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_setRequirementsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$CollectionEntitiesTable, List<CollectionEntity>>
      _collectionEntitiesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.collectionEntities,
              aliasName: $_aliasNameGenerator(
                  db.entities.id, db.collectionEntities.entityId));

  $$CollectionEntitiesTableProcessedTableManager get collectionEntitiesRefs {
    final manager = $$CollectionEntitiesTableTableManager(
            $_db, $_db.collectionEntities)
        .filter((f) => f.entityId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_collectionEntitiesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$EntitiesTableFilterComposer
    extends Composer<_$AppDatabase, $EntitiesTable> {
  $$EntitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isRare => $composableBuilder(
      column: $table.isRare, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get region => $composableBuilder(
      column: $table.region, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDiscovered => $composableBuilder(
      column: $table.isDiscovered, builder: (column) => ColumnFilters(column));

  Expression<bool> entityTriggersRefs(
      Expression<bool> Function($$EntityTriggersTableFilterComposer f) f) {
    final $$EntityTriggersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.entityTriggers,
        getReferencedColumn: (t) => t.entityId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntityTriggersTableFilterComposer(
              $db: $db,
              $table: $db.entityTriggers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> setRequirementsRefs(
      Expression<bool> Function($$SetRequirementsTableFilterComposer f) f) {
    final $$SetRequirementsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.setRequirements,
        getReferencedColumn: (t) => t.requiredEntityId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SetRequirementsTableFilterComposer(
              $db: $db,
              $table: $db.setRequirements,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> collectionEntitiesRefs(
      Expression<bool> Function($$CollectionEntitiesTableFilterComposer f) f) {
    final $$CollectionEntitiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.collectionEntities,
        getReferencedColumn: (t) => t.entityId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CollectionEntitiesTableFilterComposer(
              $db: $db,
              $table: $db.collectionEntities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$EntitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $EntitiesTable> {
  $$EntitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isRare => $composableBuilder(
      column: $table.isRare, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get region => $composableBuilder(
      column: $table.region, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDiscovered => $composableBuilder(
      column: $table.isDiscovered,
      builder: (column) => ColumnOrderings(column));
}

class $$EntitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $EntitiesTable> {
  $$EntitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<bool> get isRare =>
      $composableBuilder(column: $table.isRare, builder: (column) => column);

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<bool> get isDiscovered => $composableBuilder(
      column: $table.isDiscovered, builder: (column) => column);

  Expression<T> entityTriggersRefs<T extends Object>(
      Expression<T> Function($$EntityTriggersTableAnnotationComposer a) f) {
    final $$EntityTriggersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.entityTriggers,
        getReferencedColumn: (t) => t.entityId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntityTriggersTableAnnotationComposer(
              $db: $db,
              $table: $db.entityTriggers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> setRequirementsRefs<T extends Object>(
      Expression<T> Function($$SetRequirementsTableAnnotationComposer a) f) {
    final $$SetRequirementsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.setRequirements,
        getReferencedColumn: (t) => t.requiredEntityId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SetRequirementsTableAnnotationComposer(
              $db: $db,
              $table: $db.setRequirements,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> collectionEntitiesRefs<T extends Object>(
      Expression<T> Function($$CollectionEntitiesTableAnnotationComposer a) f) {
    final $$CollectionEntitiesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.collectionEntities,
            getReferencedColumn: (t) => t.entityId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$CollectionEntitiesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.collectionEntities,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$EntitiesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EntitiesTable,
    Entity,
    $$EntitiesTableFilterComposer,
    $$EntitiesTableOrderingComposer,
    $$EntitiesTableAnnotationComposer,
    $$EntitiesTableCreateCompanionBuilder,
    $$EntitiesTableUpdateCompanionBuilder,
    (Entity, $$EntitiesTableReferences),
    Entity,
    PrefetchHooks Function(
        {bool entityTriggersRefs,
        bool setRequirementsRefs,
        bool collectionEntitiesRefs})> {
  $$EntitiesTableTableManager(_$AppDatabase db, $EntitiesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EntitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EntitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EntitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<bool> isRare = const Value.absent(),
            Value<String?> region = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<bool> isDiscovered = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EntitiesCompanion(
            id: id,
            name: name,
            type: type,
            isRare: isRare,
            region: region,
            description: description,
            isDiscovered: isDiscovered,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String type,
            Value<bool> isRare = const Value.absent(),
            Value<String?> region = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<bool> isDiscovered = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EntitiesCompanion.insert(
            id: id,
            name: name,
            type: type,
            isRare: isRare,
            region: region,
            description: description,
            isDiscovered: isDiscovered,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$EntitiesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {entityTriggersRefs = false,
              setRequirementsRefs = false,
              collectionEntitiesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (entityTriggersRefs) db.entityTriggers,
                if (setRequirementsRefs) db.setRequirements,
                if (collectionEntitiesRefs) db.collectionEntities
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (entityTriggersRefs)
                    await $_getPrefetchedData<Entity, $EntitiesTable,
                            EntityTrigger>(
                        currentTable: table,
                        referencedTable: $$EntitiesTableReferences
                            ._entityTriggersRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$EntitiesTableReferences(db, table, p0)
                                .entityTriggersRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.entityId == item.id),
                        typedResults: items),
                  if (setRequirementsRefs)
                    await $_getPrefetchedData<Entity, $EntitiesTable,
                            SetRequirement>(
                        currentTable: table,
                        referencedTable: $$EntitiesTableReferences
                            ._setRequirementsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$EntitiesTableReferences(db, table, p0)
                                .setRequirementsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.requiredEntityId == item.id),
                        typedResults: items),
                  if (collectionEntitiesRefs)
                    await $_getPrefetchedData<Entity, $EntitiesTable,
                            CollectionEntity>(
                        currentTable: table,
                        referencedTable: $$EntitiesTableReferences
                            ._collectionEntitiesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$EntitiesTableReferences(db, table, p0)
                                .collectionEntitiesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.entityId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$EntitiesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EntitiesTable,
    Entity,
    $$EntitiesTableFilterComposer,
    $$EntitiesTableOrderingComposer,
    $$EntitiesTableAnnotationComposer,
    $$EntitiesTableCreateCompanionBuilder,
    $$EntitiesTableUpdateCompanionBuilder,
    (Entity, $$EntitiesTableReferences),
    Entity,
    PrefetchHooks Function(
        {bool entityTriggersRefs,
        bool setRequirementsRefs,
        bool collectionEntitiesRefs})>;
typedef $$EntityTriggersTableCreateCompanionBuilder = EntityTriggersCompanion
    Function({
  required String entityId,
  required int surahNum,
  required int ayahNum,
  Value<int> rowid,
});
typedef $$EntityTriggersTableUpdateCompanionBuilder = EntityTriggersCompanion
    Function({
  Value<String> entityId,
  Value<int> surahNum,
  Value<int> ayahNum,
  Value<int> rowid,
});

final class $$EntityTriggersTableReferences
    extends BaseReferences<_$AppDatabase, $EntityTriggersTable, EntityTrigger> {
  $$EntityTriggersTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $EntitiesTable _entityIdTable(_$AppDatabase db) =>
      db.entities.createAlias(
          $_aliasNameGenerator(db.entityTriggers.entityId, db.entities.id));

  $$EntitiesTableProcessedTableManager get entityId {
    final $_column = $_itemColumn<String>('entity_id')!;

    final manager = $$EntitiesTableTableManager($_db, $_db.entities)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entityIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$EntityTriggersTableFilterComposer
    extends Composer<_$AppDatabase, $EntityTriggersTable> {
  $$EntityTriggersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get surahNum => $composableBuilder(
      column: $table.surahNum, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ayahNum => $composableBuilder(
      column: $table.ayahNum, builder: (column) => ColumnFilters(column));

  $$EntitiesTableFilterComposer get entityId {
    final $$EntitiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.entityId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntitiesTableFilterComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EntityTriggersTableOrderingComposer
    extends Composer<_$AppDatabase, $EntityTriggersTable> {
  $$EntityTriggersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get surahNum => $composableBuilder(
      column: $table.surahNum, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ayahNum => $composableBuilder(
      column: $table.ayahNum, builder: (column) => ColumnOrderings(column));

  $$EntitiesTableOrderingComposer get entityId {
    final $$EntitiesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.entityId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntitiesTableOrderingComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EntityTriggersTableAnnotationComposer
    extends Composer<_$AppDatabase, $EntityTriggersTable> {
  $$EntityTriggersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get surahNum =>
      $composableBuilder(column: $table.surahNum, builder: (column) => column);

  GeneratedColumn<int> get ayahNum =>
      $composableBuilder(column: $table.ayahNum, builder: (column) => column);

  $$EntitiesTableAnnotationComposer get entityId {
    final $$EntitiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.entityId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntitiesTableAnnotationComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EntityTriggersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EntityTriggersTable,
    EntityTrigger,
    $$EntityTriggersTableFilterComposer,
    $$EntityTriggersTableOrderingComposer,
    $$EntityTriggersTableAnnotationComposer,
    $$EntityTriggersTableCreateCompanionBuilder,
    $$EntityTriggersTableUpdateCompanionBuilder,
    (EntityTrigger, $$EntityTriggersTableReferences),
    EntityTrigger,
    PrefetchHooks Function({bool entityId})> {
  $$EntityTriggersTableTableManager(
      _$AppDatabase db, $EntityTriggersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EntityTriggersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EntityTriggersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EntityTriggersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> entityId = const Value.absent(),
            Value<int> surahNum = const Value.absent(),
            Value<int> ayahNum = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EntityTriggersCompanion(
            entityId: entityId,
            surahNum: surahNum,
            ayahNum: ayahNum,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String entityId,
            required int surahNum,
            required int ayahNum,
            Value<int> rowid = const Value.absent(),
          }) =>
              EntityTriggersCompanion.insert(
            entityId: entityId,
            surahNum: surahNum,
            ayahNum: ayahNum,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$EntityTriggersTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({entityId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (entityId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.entityId,
                    referencedTable:
                        $$EntityTriggersTableReferences._entityIdTable(db),
                    referencedColumn:
                        $$EntityTriggersTableReferences._entityIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$EntityTriggersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EntityTriggersTable,
    EntityTrigger,
    $$EntityTriggersTableFilterComposer,
    $$EntityTriggersTableOrderingComposer,
    $$EntityTriggersTableAnnotationComposer,
    $$EntityTriggersTableCreateCompanionBuilder,
    $$EntityTriggersTableUpdateCompanionBuilder,
    (EntityTrigger, $$EntityTriggersTableReferences),
    EntityTrigger,
    PrefetchHooks Function({bool entityId})>;
typedef $$RelationEdgesTableCreateCompanionBuilder = RelationEdgesCompanion
    Function({
  required String entityAId,
  required String entityBId,
  required String relationType,
  Value<int> rowid,
});
typedef $$RelationEdgesTableUpdateCompanionBuilder = RelationEdgesCompanion
    Function({
  Value<String> entityAId,
  Value<String> entityBId,
  Value<String> relationType,
  Value<int> rowid,
});

final class $$RelationEdgesTableReferences
    extends BaseReferences<_$AppDatabase, $RelationEdgesTable, RelationEdge> {
  $$RelationEdgesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $EntitiesTable _entityAIdTable(_$AppDatabase db) =>
      db.entities.createAlias(
          $_aliasNameGenerator(db.relationEdges.entityAId, db.entities.id));

  $$EntitiesTableProcessedTableManager get entityAId {
    final $_column = $_itemColumn<String>('entity_a_id')!;

    final manager = $$EntitiesTableTableManager($_db, $_db.entities)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entityAIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $EntitiesTable _entityBIdTable(_$AppDatabase db) =>
      db.entities.createAlias(
          $_aliasNameGenerator(db.relationEdges.entityBId, db.entities.id));

  $$EntitiesTableProcessedTableManager get entityBId {
    final $_column = $_itemColumn<String>('entity_b_id')!;

    final manager = $$EntitiesTableTableManager($_db, $_db.entities)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entityBIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$RelationEdgesTableFilterComposer
    extends Composer<_$AppDatabase, $RelationEdgesTable> {
  $$RelationEdgesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get relationType => $composableBuilder(
      column: $table.relationType, builder: (column) => ColumnFilters(column));

  $$EntitiesTableFilterComposer get entityAId {
    final $$EntitiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.entityAId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntitiesTableFilterComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EntitiesTableFilterComposer get entityBId {
    final $$EntitiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.entityBId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntitiesTableFilterComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RelationEdgesTableOrderingComposer
    extends Composer<_$AppDatabase, $RelationEdgesTable> {
  $$RelationEdgesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get relationType => $composableBuilder(
      column: $table.relationType,
      builder: (column) => ColumnOrderings(column));

  $$EntitiesTableOrderingComposer get entityAId {
    final $$EntitiesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.entityAId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntitiesTableOrderingComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EntitiesTableOrderingComposer get entityBId {
    final $$EntitiesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.entityBId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntitiesTableOrderingComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RelationEdgesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RelationEdgesTable> {
  $$RelationEdgesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get relationType => $composableBuilder(
      column: $table.relationType, builder: (column) => column);

  $$EntitiesTableAnnotationComposer get entityAId {
    final $$EntitiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.entityAId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntitiesTableAnnotationComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EntitiesTableAnnotationComposer get entityBId {
    final $$EntitiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.entityBId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntitiesTableAnnotationComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RelationEdgesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RelationEdgesTable,
    RelationEdge,
    $$RelationEdgesTableFilterComposer,
    $$RelationEdgesTableOrderingComposer,
    $$RelationEdgesTableAnnotationComposer,
    $$RelationEdgesTableCreateCompanionBuilder,
    $$RelationEdgesTableUpdateCompanionBuilder,
    (RelationEdge, $$RelationEdgesTableReferences),
    RelationEdge,
    PrefetchHooks Function({bool entityAId, bool entityBId})> {
  $$RelationEdgesTableTableManager(_$AppDatabase db, $RelationEdgesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RelationEdgesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RelationEdgesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RelationEdgesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> entityAId = const Value.absent(),
            Value<String> entityBId = const Value.absent(),
            Value<String> relationType = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RelationEdgesCompanion(
            entityAId: entityAId,
            entityBId: entityBId,
            relationType: relationType,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String entityAId,
            required String entityBId,
            required String relationType,
            Value<int> rowid = const Value.absent(),
          }) =>
              RelationEdgesCompanion.insert(
            entityAId: entityAId,
            entityBId: entityBId,
            relationType: relationType,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$RelationEdgesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({entityAId = false, entityBId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (entityAId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.entityAId,
                    referencedTable:
                        $$RelationEdgesTableReferences._entityAIdTable(db),
                    referencedColumn:
                        $$RelationEdgesTableReferences._entityAIdTable(db).id,
                  ) as T;
                }
                if (entityBId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.entityBId,
                    referencedTable:
                        $$RelationEdgesTableReferences._entityBIdTable(db),
                    referencedColumn:
                        $$RelationEdgesTableReferences._entityBIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$RelationEdgesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RelationEdgesTable,
    RelationEdge,
    $$RelationEdgesTableFilterComposer,
    $$RelationEdgesTableOrderingComposer,
    $$RelationEdgesTableAnnotationComposer,
    $$RelationEdgesTableCreateCompanionBuilder,
    $$RelationEdgesTableUpdateCompanionBuilder,
    (RelationEdge, $$RelationEdgesTableReferences),
    RelationEdge,
    PrefetchHooks Function({bool entityAId, bool entityBId})>;
typedef $$ConstellationEdgesTableCreateCompanionBuilder
    = ConstellationEdgesCompanion Function({
  required String entityAId,
  required String entityBId,
  required int sharedSurah,
  Value<int> weight,
  Value<int> rowid,
});
typedef $$ConstellationEdgesTableUpdateCompanionBuilder
    = ConstellationEdgesCompanion Function({
  Value<String> entityAId,
  Value<String> entityBId,
  Value<int> sharedSurah,
  Value<int> weight,
  Value<int> rowid,
});

final class $$ConstellationEdgesTableReferences extends BaseReferences<
    _$AppDatabase, $ConstellationEdgesTable, ConstellationEdge> {
  $$ConstellationEdgesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $EntitiesTable _entityAIdTable(_$AppDatabase db) =>
      db.entities.createAlias($_aliasNameGenerator(
          db.constellationEdges.entityAId, db.entities.id));

  $$EntitiesTableProcessedTableManager get entityAId {
    final $_column = $_itemColumn<String>('entity_a_id')!;

    final manager = $$EntitiesTableTableManager($_db, $_db.entities)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entityAIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $EntitiesTable _entityBIdTable(_$AppDatabase db) =>
      db.entities.createAlias($_aliasNameGenerator(
          db.constellationEdges.entityBId, db.entities.id));

  $$EntitiesTableProcessedTableManager get entityBId {
    final $_column = $_itemColumn<String>('entity_b_id')!;

    final manager = $$EntitiesTableTableManager($_db, $_db.entities)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entityBIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ConstellationEdgesTableFilterComposer
    extends Composer<_$AppDatabase, $ConstellationEdgesTable> {
  $$ConstellationEdgesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get sharedSurah => $composableBuilder(
      column: $table.sharedSurah, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnFilters(column));

  $$EntitiesTableFilterComposer get entityAId {
    final $$EntitiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.entityAId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntitiesTableFilterComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EntitiesTableFilterComposer get entityBId {
    final $$EntitiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.entityBId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntitiesTableFilterComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ConstellationEdgesTableOrderingComposer
    extends Composer<_$AppDatabase, $ConstellationEdgesTable> {
  $$ConstellationEdgesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get sharedSurah => $composableBuilder(
      column: $table.sharedSurah, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnOrderings(column));

  $$EntitiesTableOrderingComposer get entityAId {
    final $$EntitiesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.entityAId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntitiesTableOrderingComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EntitiesTableOrderingComposer get entityBId {
    final $$EntitiesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.entityBId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntitiesTableOrderingComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ConstellationEdgesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ConstellationEdgesTable> {
  $$ConstellationEdgesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get sharedSurah => $composableBuilder(
      column: $table.sharedSurah, builder: (column) => column);

  GeneratedColumn<int> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  $$EntitiesTableAnnotationComposer get entityAId {
    final $$EntitiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.entityAId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntitiesTableAnnotationComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EntitiesTableAnnotationComposer get entityBId {
    final $$EntitiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.entityBId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntitiesTableAnnotationComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ConstellationEdgesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ConstellationEdgesTable,
    ConstellationEdge,
    $$ConstellationEdgesTableFilterComposer,
    $$ConstellationEdgesTableOrderingComposer,
    $$ConstellationEdgesTableAnnotationComposer,
    $$ConstellationEdgesTableCreateCompanionBuilder,
    $$ConstellationEdgesTableUpdateCompanionBuilder,
    (ConstellationEdge, $$ConstellationEdgesTableReferences),
    ConstellationEdge,
    PrefetchHooks Function({bool entityAId, bool entityBId})> {
  $$ConstellationEdgesTableTableManager(
      _$AppDatabase db, $ConstellationEdgesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConstellationEdgesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ConstellationEdgesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ConstellationEdgesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> entityAId = const Value.absent(),
            Value<String> entityBId = const Value.absent(),
            Value<int> sharedSurah = const Value.absent(),
            Value<int> weight = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ConstellationEdgesCompanion(
            entityAId: entityAId,
            entityBId: entityBId,
            sharedSurah: sharedSurah,
            weight: weight,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String entityAId,
            required String entityBId,
            required int sharedSurah,
            Value<int> weight = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ConstellationEdgesCompanion.insert(
            entityAId: entityAId,
            entityBId: entityBId,
            sharedSurah: sharedSurah,
            weight: weight,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ConstellationEdgesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({entityAId = false, entityBId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (entityAId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.entityAId,
                    referencedTable:
                        $$ConstellationEdgesTableReferences._entityAIdTable(db),
                    referencedColumn: $$ConstellationEdgesTableReferences
                        ._entityAIdTable(db)
                        .id,
                  ) as T;
                }
                if (entityBId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.entityBId,
                    referencedTable:
                        $$ConstellationEdgesTableReferences._entityBIdTable(db),
                    referencedColumn: $$ConstellationEdgesTableReferences
                        ._entityBIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ConstellationEdgesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ConstellationEdgesTable,
    ConstellationEdge,
    $$ConstellationEdgesTableFilterComposer,
    $$ConstellationEdgesTableOrderingComposer,
    $$ConstellationEdgesTableAnnotationComposer,
    $$ConstellationEdgesTableCreateCompanionBuilder,
    $$ConstellationEdgesTableUpdateCompanionBuilder,
    (ConstellationEdge, $$ConstellationEdgesTableReferences),
    ConstellationEdge,
    PrefetchHooks Function({bool entityAId, bool entityBId})>;
typedef $$StoriesTableCreateCompanionBuilder = StoriesCompanion Function({
  required String id,
  required String title,
  Value<String> description,
  Value<double> progressValue,
  Value<int> rowid,
});
typedef $$StoriesTableUpdateCompanionBuilder = StoriesCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String> description,
  Value<double> progressValue,
  Value<int> rowid,
});

final class $$StoriesTableReferences
    extends BaseReferences<_$AppDatabase, $StoriesTable, Story> {
  $$StoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$StoryVerseRangesTable, List<StoryVerseRange>>
      _storyVerseRangesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.storyVerseRanges,
              aliasName: $_aliasNameGenerator(
                  db.stories.id, db.storyVerseRanges.storyId));

  $$StoryVerseRangesTableProcessedTableManager get storyVerseRangesRefs {
    final manager =
        $$StoryVerseRangesTableTableManager($_db, $_db.storyVerseRanges)
            .filter((f) => f.storyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_storyVerseRangesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$StoriesTableFilterComposer
    extends Composer<_$AppDatabase, $StoriesTable> {
  $$StoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get progressValue => $composableBuilder(
      column: $table.progressValue, builder: (column) => ColumnFilters(column));

  Expression<bool> storyVerseRangesRefs(
      Expression<bool> Function($$StoryVerseRangesTableFilterComposer f) f) {
    final $$StoryVerseRangesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.storyVerseRanges,
        getReferencedColumn: (t) => t.storyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StoryVerseRangesTableFilterComposer(
              $db: $db,
              $table: $db.storyVerseRanges,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$StoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $StoriesTable> {
  $$StoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get progressValue => $composableBuilder(
      column: $table.progressValue,
      builder: (column) => ColumnOrderings(column));
}

class $$StoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $StoriesTable> {
  $$StoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<double> get progressValue => $composableBuilder(
      column: $table.progressValue, builder: (column) => column);

  Expression<T> storyVerseRangesRefs<T extends Object>(
      Expression<T> Function($$StoryVerseRangesTableAnnotationComposer a) f) {
    final $$StoryVerseRangesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.storyVerseRanges,
        getReferencedColumn: (t) => t.storyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StoryVerseRangesTableAnnotationComposer(
              $db: $db,
              $table: $db.storyVerseRanges,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$StoriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $StoriesTable,
    Story,
    $$StoriesTableFilterComposer,
    $$StoriesTableOrderingComposer,
    $$StoriesTableAnnotationComposer,
    $$StoriesTableCreateCompanionBuilder,
    $$StoriesTableUpdateCompanionBuilder,
    (Story, $$StoriesTableReferences),
    Story,
    PrefetchHooks Function({bool storyVerseRangesRefs})> {
  $$StoriesTableTableManager(_$AppDatabase db, $StoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<double> progressValue = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              StoriesCompanion(
            id: id,
            title: title,
            description: description,
            progressValue: progressValue,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            Value<String> description = const Value.absent(),
            Value<double> progressValue = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              StoriesCompanion.insert(
            id: id,
            title: title,
            description: description,
            progressValue: progressValue,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$StoriesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({storyVerseRangesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (storyVerseRangesRefs) db.storyVerseRanges
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (storyVerseRangesRefs)
                    await $_getPrefetchedData<Story, $StoriesTable,
                            StoryVerseRange>(
                        currentTable: table,
                        referencedTable: $$StoriesTableReferences
                            ._storyVerseRangesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$StoriesTableReferences(db, table, p0)
                                .storyVerseRangesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.storyId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$StoriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $StoriesTable,
    Story,
    $$StoriesTableFilterComposer,
    $$StoriesTableOrderingComposer,
    $$StoriesTableAnnotationComposer,
    $$StoriesTableCreateCompanionBuilder,
    $$StoriesTableUpdateCompanionBuilder,
    (Story, $$StoriesTableReferences),
    Story,
    PrefetchHooks Function({bool storyVerseRangesRefs})>;
typedef $$StoryVerseRangesTableCreateCompanionBuilder
    = StoryVerseRangesCompanion Function({
  required String storyId,
  required int surahNum,
  required int ayahStart,
  required int ayahEnd,
  Value<int> rowid,
});
typedef $$StoryVerseRangesTableUpdateCompanionBuilder
    = StoryVerseRangesCompanion Function({
  Value<String> storyId,
  Value<int> surahNum,
  Value<int> ayahStart,
  Value<int> ayahEnd,
  Value<int> rowid,
});

final class $$StoryVerseRangesTableReferences extends BaseReferences<
    _$AppDatabase, $StoryVerseRangesTable, StoryVerseRange> {
  $$StoryVerseRangesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $StoriesTable _storyIdTable(_$AppDatabase db) =>
      db.stories.createAlias(
          $_aliasNameGenerator(db.storyVerseRanges.storyId, db.stories.id));

  $$StoriesTableProcessedTableManager get storyId {
    final $_column = $_itemColumn<String>('story_id')!;

    final manager = $$StoriesTableTableManager($_db, $_db.stories)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_storyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$StoryVerseRangesTableFilterComposer
    extends Composer<_$AppDatabase, $StoryVerseRangesTable> {
  $$StoryVerseRangesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get surahNum => $composableBuilder(
      column: $table.surahNum, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ayahStart => $composableBuilder(
      column: $table.ayahStart, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ayahEnd => $composableBuilder(
      column: $table.ayahEnd, builder: (column) => ColumnFilters(column));

  $$StoriesTableFilterComposer get storyId {
    final $$StoriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.storyId,
        referencedTable: $db.stories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StoriesTableFilterComposer(
              $db: $db,
              $table: $db.stories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StoryVerseRangesTableOrderingComposer
    extends Composer<_$AppDatabase, $StoryVerseRangesTable> {
  $$StoryVerseRangesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get surahNum => $composableBuilder(
      column: $table.surahNum, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ayahStart => $composableBuilder(
      column: $table.ayahStart, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ayahEnd => $composableBuilder(
      column: $table.ayahEnd, builder: (column) => ColumnOrderings(column));

  $$StoriesTableOrderingComposer get storyId {
    final $$StoriesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.storyId,
        referencedTable: $db.stories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StoriesTableOrderingComposer(
              $db: $db,
              $table: $db.stories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StoryVerseRangesTableAnnotationComposer
    extends Composer<_$AppDatabase, $StoryVerseRangesTable> {
  $$StoryVerseRangesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get surahNum =>
      $composableBuilder(column: $table.surahNum, builder: (column) => column);

  GeneratedColumn<int> get ayahStart =>
      $composableBuilder(column: $table.ayahStart, builder: (column) => column);

  GeneratedColumn<int> get ayahEnd =>
      $composableBuilder(column: $table.ayahEnd, builder: (column) => column);

  $$StoriesTableAnnotationComposer get storyId {
    final $$StoriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.storyId,
        referencedTable: $db.stories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StoriesTableAnnotationComposer(
              $db: $db,
              $table: $db.stories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StoryVerseRangesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $StoryVerseRangesTable,
    StoryVerseRange,
    $$StoryVerseRangesTableFilterComposer,
    $$StoryVerseRangesTableOrderingComposer,
    $$StoryVerseRangesTableAnnotationComposer,
    $$StoryVerseRangesTableCreateCompanionBuilder,
    $$StoryVerseRangesTableUpdateCompanionBuilder,
    (StoryVerseRange, $$StoryVerseRangesTableReferences),
    StoryVerseRange,
    PrefetchHooks Function({bool storyId})> {
  $$StoryVerseRangesTableTableManager(
      _$AppDatabase db, $StoryVerseRangesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StoryVerseRangesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StoryVerseRangesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StoryVerseRangesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> storyId = const Value.absent(),
            Value<int> surahNum = const Value.absent(),
            Value<int> ayahStart = const Value.absent(),
            Value<int> ayahEnd = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              StoryVerseRangesCompanion(
            storyId: storyId,
            surahNum: surahNum,
            ayahStart: ayahStart,
            ayahEnd: ayahEnd,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String storyId,
            required int surahNum,
            required int ayahStart,
            required int ayahEnd,
            Value<int> rowid = const Value.absent(),
          }) =>
              StoryVerseRangesCompanion.insert(
            storyId: storyId,
            surahNum: surahNum,
            ayahStart: ayahStart,
            ayahEnd: ayahEnd,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$StoryVerseRangesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({storyId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (storyId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.storyId,
                    referencedTable:
                        $$StoryVerseRangesTableReferences._storyIdTable(db),
                    referencedColumn:
                        $$StoryVerseRangesTableReferences._storyIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$StoryVerseRangesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $StoryVerseRangesTable,
    StoryVerseRange,
    $$StoryVerseRangesTableFilterComposer,
    $$StoryVerseRangesTableOrderingComposer,
    $$StoryVerseRangesTableAnnotationComposer,
    $$StoryVerseRangesTableCreateCompanionBuilder,
    $$StoryVerseRangesTableUpdateCompanionBuilder,
    (StoryVerseRange, $$StoryVerseRangesTableReferences),
    StoryVerseRange,
    PrefetchHooks Function({bool storyId})>;
typedef $$ThemesTableCreateCompanionBuilder = ThemesCompanion Function({
  required String id,
  required String name,
  required String icon,
  Value<int> currentXp,
  Value<int> maxXp,
  Value<int> rowid,
});
typedef $$ThemesTableUpdateCompanionBuilder = ThemesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> icon,
  Value<int> currentXp,
  Value<int> maxXp,
  Value<int> rowid,
});

final class $$ThemesTableReferences
    extends BaseReferences<_$AppDatabase, $ThemesTable, Theme> {
  $$ThemesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ThemeLevelsTable, List<ThemeLevel>>
      _themeLevelsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.themeLevels,
              aliasName:
                  $_aliasNameGenerator(db.themes.id, db.themeLevels.themeId));

  $$ThemeLevelsTableProcessedTableManager get themeLevelsRefs {
    final manager = $$ThemeLevelsTableTableManager($_db, $_db.themeLevels)
        .filter((f) => f.themeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_themeLevelsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ThemeTriggersTable, List<ThemeTrigger>>
      _themeTriggersRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.themeTriggers,
              aliasName:
                  $_aliasNameGenerator(db.themes.id, db.themeTriggers.themeId));

  $$ThemeTriggersTableProcessedTableManager get themeTriggersRefs {
    final manager = $$ThemeTriggersTableTableManager($_db, $_db.themeTriggers)
        .filter((f) => f.themeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_themeTriggersRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ThemesTableFilterComposer
    extends Composer<_$AppDatabase, $ThemesTable> {
  $$ThemesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get currentXp => $composableBuilder(
      column: $table.currentXp, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get maxXp => $composableBuilder(
      column: $table.maxXp, builder: (column) => ColumnFilters(column));

  Expression<bool> themeLevelsRefs(
      Expression<bool> Function($$ThemeLevelsTableFilterComposer f) f) {
    final $$ThemeLevelsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.themeLevels,
        getReferencedColumn: (t) => t.themeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ThemeLevelsTableFilterComposer(
              $db: $db,
              $table: $db.themeLevels,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> themeTriggersRefs(
      Expression<bool> Function($$ThemeTriggersTableFilterComposer f) f) {
    final $$ThemeTriggersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.themeTriggers,
        getReferencedColumn: (t) => t.themeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ThemeTriggersTableFilterComposer(
              $db: $db,
              $table: $db.themeTriggers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ThemesTableOrderingComposer
    extends Composer<_$AppDatabase, $ThemesTable> {
  $$ThemesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get currentXp => $composableBuilder(
      column: $table.currentXp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get maxXp => $composableBuilder(
      column: $table.maxXp, builder: (column) => ColumnOrderings(column));
}

class $$ThemesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ThemesTable> {
  $$ThemesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<int> get currentXp =>
      $composableBuilder(column: $table.currentXp, builder: (column) => column);

  GeneratedColumn<int> get maxXp =>
      $composableBuilder(column: $table.maxXp, builder: (column) => column);

  Expression<T> themeLevelsRefs<T extends Object>(
      Expression<T> Function($$ThemeLevelsTableAnnotationComposer a) f) {
    final $$ThemeLevelsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.themeLevels,
        getReferencedColumn: (t) => t.themeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ThemeLevelsTableAnnotationComposer(
              $db: $db,
              $table: $db.themeLevels,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> themeTriggersRefs<T extends Object>(
      Expression<T> Function($$ThemeTriggersTableAnnotationComposer a) f) {
    final $$ThemeTriggersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.themeTriggers,
        getReferencedColumn: (t) => t.themeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ThemeTriggersTableAnnotationComposer(
              $db: $db,
              $table: $db.themeTriggers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ThemesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ThemesTable,
    Theme,
    $$ThemesTableFilterComposer,
    $$ThemesTableOrderingComposer,
    $$ThemesTableAnnotationComposer,
    $$ThemesTableCreateCompanionBuilder,
    $$ThemesTableUpdateCompanionBuilder,
    (Theme, $$ThemesTableReferences),
    Theme,
    PrefetchHooks Function({bool themeLevelsRefs, bool themeTriggersRefs})> {
  $$ThemesTableTableManager(_$AppDatabase db, $ThemesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ThemesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ThemesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ThemesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> icon = const Value.absent(),
            Value<int> currentXp = const Value.absent(),
            Value<int> maxXp = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ThemesCompanion(
            id: id,
            name: name,
            icon: icon,
            currentXp: currentXp,
            maxXp: maxXp,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String icon,
            Value<int> currentXp = const Value.absent(),
            Value<int> maxXp = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ThemesCompanion.insert(
            id: id,
            name: name,
            icon: icon,
            currentXp: currentXp,
            maxXp: maxXp,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ThemesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {themeLevelsRefs = false, themeTriggersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (themeLevelsRefs) db.themeLevels,
                if (themeTriggersRefs) db.themeTriggers
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (themeLevelsRefs)
                    await $_getPrefetchedData<Theme, $ThemesTable, ThemeLevel>(
                        currentTable: table,
                        referencedTable:
                            $$ThemesTableReferences._themeLevelsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ThemesTableReferences(db, table, p0)
                                .themeLevelsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.themeId == item.id),
                        typedResults: items),
                  if (themeTriggersRefs)
                    await $_getPrefetchedData<Theme, $ThemesTable,
                            ThemeTrigger>(
                        currentTable: table,
                        referencedTable:
                            $$ThemesTableReferences._themeTriggersRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ThemesTableReferences(db, table, p0)
                                .themeTriggersRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.themeId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ThemesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ThemesTable,
    Theme,
    $$ThemesTableFilterComposer,
    $$ThemesTableOrderingComposer,
    $$ThemesTableAnnotationComposer,
    $$ThemesTableCreateCompanionBuilder,
    $$ThemesTableUpdateCompanionBuilder,
    (Theme, $$ThemesTableReferences),
    Theme,
    PrefetchHooks Function({bool themeLevelsRefs, bool themeTriggersRefs})>;
typedef $$ThemeLevelsTableCreateCompanionBuilder = ThemeLevelsCompanion
    Function({
  required String themeId,
  required int level,
  required int xpRequired,
  Value<int> rowid,
});
typedef $$ThemeLevelsTableUpdateCompanionBuilder = ThemeLevelsCompanion
    Function({
  Value<String> themeId,
  Value<int> level,
  Value<int> xpRequired,
  Value<int> rowid,
});

final class $$ThemeLevelsTableReferences
    extends BaseReferences<_$AppDatabase, $ThemeLevelsTable, ThemeLevel> {
  $$ThemeLevelsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ThemesTable _themeIdTable(_$AppDatabase db) => db.themes
      .createAlias($_aliasNameGenerator(db.themeLevels.themeId, db.themes.id));

  $$ThemesTableProcessedTableManager get themeId {
    final $_column = $_itemColumn<String>('theme_id')!;

    final manager = $$ThemesTableTableManager($_db, $_db.themes)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_themeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ThemeLevelsTableFilterComposer
    extends Composer<_$AppDatabase, $ThemeLevelsTable> {
  $$ThemeLevelsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get xpRequired => $composableBuilder(
      column: $table.xpRequired, builder: (column) => ColumnFilters(column));

  $$ThemesTableFilterComposer get themeId {
    final $$ThemesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.themeId,
        referencedTable: $db.themes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ThemesTableFilterComposer(
              $db: $db,
              $table: $db.themes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ThemeLevelsTableOrderingComposer
    extends Composer<_$AppDatabase, $ThemeLevelsTable> {
  $$ThemeLevelsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get xpRequired => $composableBuilder(
      column: $table.xpRequired, builder: (column) => ColumnOrderings(column));

  $$ThemesTableOrderingComposer get themeId {
    final $$ThemesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.themeId,
        referencedTable: $db.themes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ThemesTableOrderingComposer(
              $db: $db,
              $table: $db.themes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ThemeLevelsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ThemeLevelsTable> {
  $$ThemeLevelsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get xpRequired => $composableBuilder(
      column: $table.xpRequired, builder: (column) => column);

  $$ThemesTableAnnotationComposer get themeId {
    final $$ThemesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.themeId,
        referencedTable: $db.themes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ThemesTableAnnotationComposer(
              $db: $db,
              $table: $db.themes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ThemeLevelsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ThemeLevelsTable,
    ThemeLevel,
    $$ThemeLevelsTableFilterComposer,
    $$ThemeLevelsTableOrderingComposer,
    $$ThemeLevelsTableAnnotationComposer,
    $$ThemeLevelsTableCreateCompanionBuilder,
    $$ThemeLevelsTableUpdateCompanionBuilder,
    (ThemeLevel, $$ThemeLevelsTableReferences),
    ThemeLevel,
    PrefetchHooks Function({bool themeId})> {
  $$ThemeLevelsTableTableManager(_$AppDatabase db, $ThemeLevelsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ThemeLevelsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ThemeLevelsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ThemeLevelsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> themeId = const Value.absent(),
            Value<int> level = const Value.absent(),
            Value<int> xpRequired = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ThemeLevelsCompanion(
            themeId: themeId,
            level: level,
            xpRequired: xpRequired,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String themeId,
            required int level,
            required int xpRequired,
            Value<int> rowid = const Value.absent(),
          }) =>
              ThemeLevelsCompanion.insert(
            themeId: themeId,
            level: level,
            xpRequired: xpRequired,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ThemeLevelsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({themeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (themeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.themeId,
                    referencedTable:
                        $$ThemeLevelsTableReferences._themeIdTable(db),
                    referencedColumn:
                        $$ThemeLevelsTableReferences._themeIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ThemeLevelsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ThemeLevelsTable,
    ThemeLevel,
    $$ThemeLevelsTableFilterComposer,
    $$ThemeLevelsTableOrderingComposer,
    $$ThemeLevelsTableAnnotationComposer,
    $$ThemeLevelsTableCreateCompanionBuilder,
    $$ThemeLevelsTableUpdateCompanionBuilder,
    (ThemeLevel, $$ThemeLevelsTableReferences),
    ThemeLevel,
    PrefetchHooks Function({bool themeId})>;
typedef $$ThemeTriggersTableCreateCompanionBuilder = ThemeTriggersCompanion
    Function({
  required String themeId,
  required int surahNum,
  required int ayahNum,
  Value<int> xpReward,
  Value<int> rowid,
});
typedef $$ThemeTriggersTableUpdateCompanionBuilder = ThemeTriggersCompanion
    Function({
  Value<String> themeId,
  Value<int> surahNum,
  Value<int> ayahNum,
  Value<int> xpReward,
  Value<int> rowid,
});

final class $$ThemeTriggersTableReferences
    extends BaseReferences<_$AppDatabase, $ThemeTriggersTable, ThemeTrigger> {
  $$ThemeTriggersTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ThemesTable _themeIdTable(_$AppDatabase db) => db.themes.createAlias(
      $_aliasNameGenerator(db.themeTriggers.themeId, db.themes.id));

  $$ThemesTableProcessedTableManager get themeId {
    final $_column = $_itemColumn<String>('theme_id')!;

    final manager = $$ThemesTableTableManager($_db, $_db.themes)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_themeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ThemeTriggersTableFilterComposer
    extends Composer<_$AppDatabase, $ThemeTriggersTable> {
  $$ThemeTriggersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get surahNum => $composableBuilder(
      column: $table.surahNum, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ayahNum => $composableBuilder(
      column: $table.ayahNum, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get xpReward => $composableBuilder(
      column: $table.xpReward, builder: (column) => ColumnFilters(column));

  $$ThemesTableFilterComposer get themeId {
    final $$ThemesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.themeId,
        referencedTable: $db.themes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ThemesTableFilterComposer(
              $db: $db,
              $table: $db.themes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ThemeTriggersTableOrderingComposer
    extends Composer<_$AppDatabase, $ThemeTriggersTable> {
  $$ThemeTriggersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get surahNum => $composableBuilder(
      column: $table.surahNum, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ayahNum => $composableBuilder(
      column: $table.ayahNum, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get xpReward => $composableBuilder(
      column: $table.xpReward, builder: (column) => ColumnOrderings(column));

  $$ThemesTableOrderingComposer get themeId {
    final $$ThemesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.themeId,
        referencedTable: $db.themes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ThemesTableOrderingComposer(
              $db: $db,
              $table: $db.themes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ThemeTriggersTableAnnotationComposer
    extends Composer<_$AppDatabase, $ThemeTriggersTable> {
  $$ThemeTriggersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get surahNum =>
      $composableBuilder(column: $table.surahNum, builder: (column) => column);

  GeneratedColumn<int> get ayahNum =>
      $composableBuilder(column: $table.ayahNum, builder: (column) => column);

  GeneratedColumn<int> get xpReward =>
      $composableBuilder(column: $table.xpReward, builder: (column) => column);

  $$ThemesTableAnnotationComposer get themeId {
    final $$ThemesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.themeId,
        referencedTable: $db.themes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ThemesTableAnnotationComposer(
              $db: $db,
              $table: $db.themes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ThemeTriggersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ThemeTriggersTable,
    ThemeTrigger,
    $$ThemeTriggersTableFilterComposer,
    $$ThemeTriggersTableOrderingComposer,
    $$ThemeTriggersTableAnnotationComposer,
    $$ThemeTriggersTableCreateCompanionBuilder,
    $$ThemeTriggersTableUpdateCompanionBuilder,
    (ThemeTrigger, $$ThemeTriggersTableReferences),
    ThemeTrigger,
    PrefetchHooks Function({bool themeId})> {
  $$ThemeTriggersTableTableManager(_$AppDatabase db, $ThemeTriggersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ThemeTriggersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ThemeTriggersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ThemeTriggersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> themeId = const Value.absent(),
            Value<int> surahNum = const Value.absent(),
            Value<int> ayahNum = const Value.absent(),
            Value<int> xpReward = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ThemeTriggersCompanion(
            themeId: themeId,
            surahNum: surahNum,
            ayahNum: ayahNum,
            xpReward: xpReward,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String themeId,
            required int surahNum,
            required int ayahNum,
            Value<int> xpReward = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ThemeTriggersCompanion.insert(
            themeId: themeId,
            surahNum: surahNum,
            ayahNum: ayahNum,
            xpReward: xpReward,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ThemeTriggersTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({themeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (themeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.themeId,
                    referencedTable:
                        $$ThemeTriggersTableReferences._themeIdTable(db),
                    referencedColumn:
                        $$ThemeTriggersTableReferences._themeIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ThemeTriggersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ThemeTriggersTable,
    ThemeTrigger,
    $$ThemeTriggersTableFilterComposer,
    $$ThemeTriggersTableOrderingComposer,
    $$ThemeTriggersTableAnnotationComposer,
    $$ThemeTriggersTableCreateCompanionBuilder,
    $$ThemeTriggersTableUpdateCompanionBuilder,
    (ThemeTrigger, $$ThemeTriggersTableReferences),
    ThemeTrigger,
    PrefetchHooks Function({bool themeId})>;
typedef $$SetsTableCreateCompanionBuilder = SetsCompanion Function({
  required String id,
  required String name,
  Value<String> description,
  Value<bool> isHidden,
  Value<bool> isVisible,
  Value<bool> isCompleted,
  Value<int> rowid,
});
typedef $$SetsTableUpdateCompanionBuilder = SetsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> description,
  Value<bool> isHidden,
  Value<bool> isVisible,
  Value<bool> isCompleted,
  Value<int> rowid,
});

final class $$SetsTableReferences
    extends BaseReferences<_$AppDatabase, $SetsTable, SetsData> {
  $$SetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SetRequirementsTable, List<SetRequirement>>
      _setRequirementsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.setRequirements,
              aliasName:
                  $_aliasNameGenerator(db.sets.id, db.setRequirements.setId));

  $$SetRequirementsTableProcessedTableManager get setRequirementsRefs {
    final manager =
        $$SetRequirementsTableTableManager($_db, $_db.setRequirements)
            .filter((f) => f.setId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_setRequirementsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SetsTableFilterComposer extends Composer<_$AppDatabase, $SetsTable> {
  $$SetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isHidden => $composableBuilder(
      column: $table.isHidden, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isVisible => $composableBuilder(
      column: $table.isVisible, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnFilters(column));

  Expression<bool> setRequirementsRefs(
      Expression<bool> Function($$SetRequirementsTableFilterComposer f) f) {
    final $$SetRequirementsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.setRequirements,
        getReferencedColumn: (t) => t.setId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SetRequirementsTableFilterComposer(
              $db: $db,
              $table: $db.setRequirements,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SetsTableOrderingComposer extends Composer<_$AppDatabase, $SetsTable> {
  $$SetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isHidden => $composableBuilder(
      column: $table.isHidden, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isVisible => $composableBuilder(
      column: $table.isVisible, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnOrderings(column));
}

class $$SetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SetsTable> {
  $$SetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<bool> get isHidden =>
      $composableBuilder(column: $table.isHidden, builder: (column) => column);

  GeneratedColumn<bool> get isVisible =>
      $composableBuilder(column: $table.isVisible, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => column);

  Expression<T> setRequirementsRefs<T extends Object>(
      Expression<T> Function($$SetRequirementsTableAnnotationComposer a) f) {
    final $$SetRequirementsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.setRequirements,
        getReferencedColumn: (t) => t.setId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SetRequirementsTableAnnotationComposer(
              $db: $db,
              $table: $db.setRequirements,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SetsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SetsTable,
    SetsData,
    $$SetsTableFilterComposer,
    $$SetsTableOrderingComposer,
    $$SetsTableAnnotationComposer,
    $$SetsTableCreateCompanionBuilder,
    $$SetsTableUpdateCompanionBuilder,
    (SetsData, $$SetsTableReferences),
    SetsData,
    PrefetchHooks Function({bool setRequirementsRefs})> {
  $$SetsTableTableManager(_$AppDatabase db, $SetsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<bool> isHidden = const Value.absent(),
            Value<bool> isVisible = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SetsCompanion(
            id: id,
            name: name,
            description: description,
            isHidden: isHidden,
            isVisible: isVisible,
            isCompleted: isCompleted,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String> description = const Value.absent(),
            Value<bool> isHidden = const Value.absent(),
            Value<bool> isVisible = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SetsCompanion.insert(
            id: id,
            name: name,
            description: description,
            isHidden: isHidden,
            isVisible: isVisible,
            isCompleted: isCompleted,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$SetsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({setRequirementsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (setRequirementsRefs) db.setRequirements
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (setRequirementsRefs)
                    await $_getPrefetchedData<SetsData, $SetsTable,
                            SetRequirement>(
                        currentTable: table,
                        referencedTable:
                            $$SetsTableReferences._setRequirementsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SetsTableReferences(db, table, p0)
                                .setRequirementsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.setId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$SetsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SetsTable,
    SetsData,
    $$SetsTableFilterComposer,
    $$SetsTableOrderingComposer,
    $$SetsTableAnnotationComposer,
    $$SetsTableCreateCompanionBuilder,
    $$SetsTableUpdateCompanionBuilder,
    (SetsData, $$SetsTableReferences),
    SetsData,
    PrefetchHooks Function({bool setRequirementsRefs})>;
typedef $$SetRequirementsTableCreateCompanionBuilder = SetRequirementsCompanion
    Function({
  required String setId,
  required String requiredEntityId,
  Value<int> rowid,
});
typedef $$SetRequirementsTableUpdateCompanionBuilder = SetRequirementsCompanion
    Function({
  Value<String> setId,
  Value<String> requiredEntityId,
  Value<int> rowid,
});

final class $$SetRequirementsTableReferences extends BaseReferences<
    _$AppDatabase, $SetRequirementsTable, SetRequirement> {
  $$SetRequirementsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $SetsTable _setIdTable(_$AppDatabase db) => db.sets
      .createAlias($_aliasNameGenerator(db.setRequirements.setId, db.sets.id));

  $$SetsTableProcessedTableManager get setId {
    final $_column = $_itemColumn<String>('set_id')!;

    final manager = $$SetsTableTableManager($_db, $_db.sets)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_setIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $EntitiesTable _requiredEntityIdTable(_$AppDatabase db) =>
      db.entities.createAlias($_aliasNameGenerator(
          db.setRequirements.requiredEntityId, db.entities.id));

  $$EntitiesTableProcessedTableManager get requiredEntityId {
    final $_column = $_itemColumn<String>('required_entity_id')!;

    final manager = $$EntitiesTableTableManager($_db, $_db.entities)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_requiredEntityIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SetRequirementsTableFilterComposer
    extends Composer<_$AppDatabase, $SetRequirementsTable> {
  $$SetRequirementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$SetsTableFilterComposer get setId {
    final $$SetsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.setId,
        referencedTable: $db.sets,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SetsTableFilterComposer(
              $db: $db,
              $table: $db.sets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EntitiesTableFilterComposer get requiredEntityId {
    final $$EntitiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.requiredEntityId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntitiesTableFilterComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SetRequirementsTableOrderingComposer
    extends Composer<_$AppDatabase, $SetRequirementsTable> {
  $$SetRequirementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$SetsTableOrderingComposer get setId {
    final $$SetsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.setId,
        referencedTable: $db.sets,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SetsTableOrderingComposer(
              $db: $db,
              $table: $db.sets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EntitiesTableOrderingComposer get requiredEntityId {
    final $$EntitiesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.requiredEntityId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntitiesTableOrderingComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SetRequirementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SetRequirementsTable> {
  $$SetRequirementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$SetsTableAnnotationComposer get setId {
    final $$SetsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.setId,
        referencedTable: $db.sets,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SetsTableAnnotationComposer(
              $db: $db,
              $table: $db.sets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EntitiesTableAnnotationComposer get requiredEntityId {
    final $$EntitiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.requiredEntityId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntitiesTableAnnotationComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SetRequirementsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SetRequirementsTable,
    SetRequirement,
    $$SetRequirementsTableFilterComposer,
    $$SetRequirementsTableOrderingComposer,
    $$SetRequirementsTableAnnotationComposer,
    $$SetRequirementsTableCreateCompanionBuilder,
    $$SetRequirementsTableUpdateCompanionBuilder,
    (SetRequirement, $$SetRequirementsTableReferences),
    SetRequirement,
    PrefetchHooks Function({bool setId, bool requiredEntityId})> {
  $$SetRequirementsTableTableManager(
      _$AppDatabase db, $SetRequirementsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SetRequirementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SetRequirementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SetRequirementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> setId = const Value.absent(),
            Value<String> requiredEntityId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SetRequirementsCompanion(
            setId: setId,
            requiredEntityId: requiredEntityId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String setId,
            required String requiredEntityId,
            Value<int> rowid = const Value.absent(),
          }) =>
              SetRequirementsCompanion.insert(
            setId: setId,
            requiredEntityId: requiredEntityId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SetRequirementsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({setId = false, requiredEntityId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (setId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.setId,
                    referencedTable:
                        $$SetRequirementsTableReferences._setIdTable(db),
                    referencedColumn:
                        $$SetRequirementsTableReferences._setIdTable(db).id,
                  ) as T;
                }
                if (requiredEntityId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.requiredEntityId,
                    referencedTable: $$SetRequirementsTableReferences
                        ._requiredEntityIdTable(db),
                    referencedColumn: $$SetRequirementsTableReferences
                        ._requiredEntityIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$SetRequirementsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SetRequirementsTable,
    SetRequirement,
    $$SetRequirementsTableFilterComposer,
    $$SetRequirementsTableOrderingComposer,
    $$SetRequirementsTableAnnotationComposer,
    $$SetRequirementsTableCreateCompanionBuilder,
    $$SetRequirementsTableUpdateCompanionBuilder,
    (SetRequirement, $$SetRequirementsTableReferences),
    SetRequirement,
    PrefetchHooks Function({bool setId, bool requiredEntityId})>;
typedef $$CollectionsTableCreateCompanionBuilder = CollectionsCompanion
    Function({
  required String id,
  required String name,
  Value<String> description,
  Value<bool> isCompleted,
  Value<int> rowid,
});
typedef $$CollectionsTableUpdateCompanionBuilder = CollectionsCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<String> description,
  Value<bool> isCompleted,
  Value<int> rowid,
});

final class $$CollectionsTableReferences
    extends BaseReferences<_$AppDatabase, $CollectionsTable, Collection> {
  $$CollectionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CollectionEntitiesTable, List<CollectionEntity>>
      _collectionEntitiesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.collectionEntities,
              aliasName: $_aliasNameGenerator(
                  db.collections.id, db.collectionEntities.collectionId));

  $$CollectionEntitiesTableProcessedTableManager get collectionEntitiesRefs {
    final manager = $$CollectionEntitiesTableTableManager(
            $_db, $_db.collectionEntities)
        .filter(
            (f) => f.collectionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_collectionEntitiesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CollectionsTableFilterComposer
    extends Composer<_$AppDatabase, $CollectionsTable> {
  $$CollectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnFilters(column));

  Expression<bool> collectionEntitiesRefs(
      Expression<bool> Function($$CollectionEntitiesTableFilterComposer f) f) {
    final $$CollectionEntitiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.collectionEntities,
        getReferencedColumn: (t) => t.collectionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CollectionEntitiesTableFilterComposer(
              $db: $db,
              $table: $db.collectionEntities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CollectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $CollectionsTable> {
  $$CollectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnOrderings(column));
}

class $$CollectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CollectionsTable> {
  $$CollectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => column);

  Expression<T> collectionEntitiesRefs<T extends Object>(
      Expression<T> Function($$CollectionEntitiesTableAnnotationComposer a) f) {
    final $$CollectionEntitiesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.collectionEntities,
            getReferencedColumn: (t) => t.collectionId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$CollectionEntitiesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.collectionEntities,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$CollectionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CollectionsTable,
    Collection,
    $$CollectionsTableFilterComposer,
    $$CollectionsTableOrderingComposer,
    $$CollectionsTableAnnotationComposer,
    $$CollectionsTableCreateCompanionBuilder,
    $$CollectionsTableUpdateCompanionBuilder,
    (Collection, $$CollectionsTableReferences),
    Collection,
    PrefetchHooks Function({bool collectionEntitiesRefs})> {
  $$CollectionsTableTableManager(_$AppDatabase db, $CollectionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CollectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CollectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CollectionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CollectionsCompanion(
            id: id,
            name: name,
            description: description,
            isCompleted: isCompleted,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String> description = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CollectionsCompanion.insert(
            id: id,
            name: name,
            description: description,
            isCompleted: isCompleted,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CollectionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({collectionEntitiesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (collectionEntitiesRefs) db.collectionEntities
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (collectionEntitiesRefs)
                    await $_getPrefetchedData<Collection, $CollectionsTable,
                            CollectionEntity>(
                        currentTable: table,
                        referencedTable: $$CollectionsTableReferences
                            ._collectionEntitiesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CollectionsTableReferences(db, table, p0)
                                .collectionEntitiesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.collectionId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CollectionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CollectionsTable,
    Collection,
    $$CollectionsTableFilterComposer,
    $$CollectionsTableOrderingComposer,
    $$CollectionsTableAnnotationComposer,
    $$CollectionsTableCreateCompanionBuilder,
    $$CollectionsTableUpdateCompanionBuilder,
    (Collection, $$CollectionsTableReferences),
    Collection,
    PrefetchHooks Function({bool collectionEntitiesRefs})>;
typedef $$CollectionEntitiesTableCreateCompanionBuilder
    = CollectionEntitiesCompanion Function({
  required String collectionId,
  required String entityId,
  Value<int> rowid,
});
typedef $$CollectionEntitiesTableUpdateCompanionBuilder
    = CollectionEntitiesCompanion Function({
  Value<String> collectionId,
  Value<String> entityId,
  Value<int> rowid,
});

final class $$CollectionEntitiesTableReferences extends BaseReferences<
    _$AppDatabase, $CollectionEntitiesTable, CollectionEntity> {
  $$CollectionEntitiesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $CollectionsTable _collectionIdTable(_$AppDatabase db) =>
      db.collections.createAlias($_aliasNameGenerator(
          db.collectionEntities.collectionId, db.collections.id));

  $$CollectionsTableProcessedTableManager get collectionId {
    final $_column = $_itemColumn<String>('collection_id')!;

    final manager = $$CollectionsTableTableManager($_db, $_db.collections)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_collectionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $EntitiesTable _entityIdTable(_$AppDatabase db) =>
      db.entities.createAlias(
          $_aliasNameGenerator(db.collectionEntities.entityId, db.entities.id));

  $$EntitiesTableProcessedTableManager get entityId {
    final $_column = $_itemColumn<String>('entity_id')!;

    final manager = $$EntitiesTableTableManager($_db, $_db.entities)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entityIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$CollectionEntitiesTableFilterComposer
    extends Composer<_$AppDatabase, $CollectionEntitiesTable> {
  $$CollectionEntitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$CollectionsTableFilterComposer get collectionId {
    final $$CollectionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.collectionId,
        referencedTable: $db.collections,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CollectionsTableFilterComposer(
              $db: $db,
              $table: $db.collections,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EntitiesTableFilterComposer get entityId {
    final $$EntitiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.entityId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntitiesTableFilterComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CollectionEntitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $CollectionEntitiesTable> {
  $$CollectionEntitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$CollectionsTableOrderingComposer get collectionId {
    final $$CollectionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.collectionId,
        referencedTable: $db.collections,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CollectionsTableOrderingComposer(
              $db: $db,
              $table: $db.collections,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EntitiesTableOrderingComposer get entityId {
    final $$EntitiesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.entityId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntitiesTableOrderingComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CollectionEntitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CollectionEntitiesTable> {
  $$CollectionEntitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$CollectionsTableAnnotationComposer get collectionId {
    final $$CollectionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.collectionId,
        referencedTable: $db.collections,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CollectionsTableAnnotationComposer(
              $db: $db,
              $table: $db.collections,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EntitiesTableAnnotationComposer get entityId {
    final $$EntitiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.entityId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntitiesTableAnnotationComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CollectionEntitiesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CollectionEntitiesTable,
    CollectionEntity,
    $$CollectionEntitiesTableFilterComposer,
    $$CollectionEntitiesTableOrderingComposer,
    $$CollectionEntitiesTableAnnotationComposer,
    $$CollectionEntitiesTableCreateCompanionBuilder,
    $$CollectionEntitiesTableUpdateCompanionBuilder,
    (CollectionEntity, $$CollectionEntitiesTableReferences),
    CollectionEntity,
    PrefetchHooks Function({bool collectionId, bool entityId})> {
  $$CollectionEntitiesTableTableManager(
      _$AppDatabase db, $CollectionEntitiesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CollectionEntitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CollectionEntitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CollectionEntitiesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> collectionId = const Value.absent(),
            Value<String> entityId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CollectionEntitiesCompanion(
            collectionId: collectionId,
            entityId: entityId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String collectionId,
            required String entityId,
            Value<int> rowid = const Value.absent(),
          }) =>
              CollectionEntitiesCompanion.insert(
            collectionId: collectionId,
            entityId: entityId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CollectionEntitiesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({collectionId = false, entityId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (collectionId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.collectionId,
                    referencedTable: $$CollectionEntitiesTableReferences
                        ._collectionIdTable(db),
                    referencedColumn: $$CollectionEntitiesTableReferences
                        ._collectionIdTable(db)
                        .id,
                  ) as T;
                }
                if (entityId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.entityId,
                    referencedTable:
                        $$CollectionEntitiesTableReferences._entityIdTable(db),
                    referencedColumn: $$CollectionEntitiesTableReferences
                        ._entityIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$CollectionEntitiesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CollectionEntitiesTable,
    CollectionEntity,
    $$CollectionEntitiesTableFilterComposer,
    $$CollectionEntitiesTableOrderingComposer,
    $$CollectionEntitiesTableAnnotationComposer,
    $$CollectionEntitiesTableCreateCompanionBuilder,
    $$CollectionEntitiesTableUpdateCompanionBuilder,
    (CollectionEntity, $$CollectionEntitiesTableReferences),
    CollectionEntity,
    PrefetchHooks Function({bool collectionId, bool entityId})>;
typedef $$ExpeditionsTableCreateCompanionBuilder = ExpeditionsCompanion
    Function({
  required String id,
  required String name,
  Value<String> description,
  Value<double> progress,
  Value<bool> isCompleted,
  Value<int> rowid,
});
typedef $$ExpeditionsTableUpdateCompanionBuilder = ExpeditionsCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<String> description,
  Value<double> progress,
  Value<bool> isCompleted,
  Value<int> rowid,
});

class $$ExpeditionsTableFilterComposer
    extends Composer<_$AppDatabase, $ExpeditionsTable> {
  $$ExpeditionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get progress => $composableBuilder(
      column: $table.progress, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnFilters(column));
}

class $$ExpeditionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpeditionsTable> {
  $$ExpeditionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get progress => $composableBuilder(
      column: $table.progress, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnOrderings(column));
}

class $$ExpeditionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpeditionsTable> {
  $$ExpeditionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<double> get progress =>
      $composableBuilder(column: $table.progress, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => column);
}

class $$ExpeditionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExpeditionsTable,
    Expedition,
    $$ExpeditionsTableFilterComposer,
    $$ExpeditionsTableOrderingComposer,
    $$ExpeditionsTableAnnotationComposer,
    $$ExpeditionsTableCreateCompanionBuilder,
    $$ExpeditionsTableUpdateCompanionBuilder,
    (Expedition, BaseReferences<_$AppDatabase, $ExpeditionsTable, Expedition>),
    Expedition,
    PrefetchHooks Function()> {
  $$ExpeditionsTableTableManager(_$AppDatabase db, $ExpeditionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpeditionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpeditionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpeditionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<double> progress = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExpeditionsCompanion(
            id: id,
            name: name,
            description: description,
            progress: progress,
            isCompleted: isCompleted,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String> description = const Value.absent(),
            Value<double> progress = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExpeditionsCompanion.insert(
            id: id,
            name: name,
            description: description,
            progress: progress,
            isCompleted: isCompleted,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ExpeditionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExpeditionsTable,
    Expedition,
    $$ExpeditionsTableFilterComposer,
    $$ExpeditionsTableOrderingComposer,
    $$ExpeditionsTableAnnotationComposer,
    $$ExpeditionsTableCreateCompanionBuilder,
    $$ExpeditionsTableUpdateCompanionBuilder,
    (Expedition, BaseReferences<_$AppDatabase, $ExpeditionsTable, Expedition>),
    Expedition,
    PrefetchHooks Function()>;
typedef $$UserProgressTableCreateCompanionBuilder = UserProgressCompanion
    Function({
  Value<int> id,
  Value<int> totalVersesRead,
  Value<int> streakDays,
  Value<String?> lastReadDate,
  Value<bool> premiumUnlocked,
});
typedef $$UserProgressTableUpdateCompanionBuilder = UserProgressCompanion
    Function({
  Value<int> id,
  Value<int> totalVersesRead,
  Value<int> streakDays,
  Value<String?> lastReadDate,
  Value<bool> premiumUnlocked,
});

class $$UserProgressTableFilterComposer
    extends Composer<_$AppDatabase, $UserProgressTable> {
  $$UserProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalVersesRead => $composableBuilder(
      column: $table.totalVersesRead,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get streakDays => $composableBuilder(
      column: $table.streakDays, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastReadDate => $composableBuilder(
      column: $table.lastReadDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get premiumUnlocked => $composableBuilder(
      column: $table.premiumUnlocked,
      builder: (column) => ColumnFilters(column));
}

class $$UserProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProgressTable> {
  $$UserProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalVersesRead => $composableBuilder(
      column: $table.totalVersesRead,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get streakDays => $composableBuilder(
      column: $table.streakDays, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastReadDate => $composableBuilder(
      column: $table.lastReadDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get premiumUnlocked => $composableBuilder(
      column: $table.premiumUnlocked,
      builder: (column) => ColumnOrderings(column));
}

class $$UserProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProgressTable> {
  $$UserProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get totalVersesRead => $composableBuilder(
      column: $table.totalVersesRead, builder: (column) => column);

  GeneratedColumn<int> get streakDays => $composableBuilder(
      column: $table.streakDays, builder: (column) => column);

  GeneratedColumn<String> get lastReadDate => $composableBuilder(
      column: $table.lastReadDate, builder: (column) => column);

  GeneratedColumn<bool> get premiumUnlocked => $composableBuilder(
      column: $table.premiumUnlocked, builder: (column) => column);
}

class $$UserProgressTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserProgressTable,
    UserProgressData,
    $$UserProgressTableFilterComposer,
    $$UserProgressTableOrderingComposer,
    $$UserProgressTableAnnotationComposer,
    $$UserProgressTableCreateCompanionBuilder,
    $$UserProgressTableUpdateCompanionBuilder,
    (
      UserProgressData,
      BaseReferences<_$AppDatabase, $UserProgressTable, UserProgressData>
    ),
    UserProgressData,
    PrefetchHooks Function()> {
  $$UserProgressTableTableManager(_$AppDatabase db, $UserProgressTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProgressTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> totalVersesRead = const Value.absent(),
            Value<int> streakDays = const Value.absent(),
            Value<String?> lastReadDate = const Value.absent(),
            Value<bool> premiumUnlocked = const Value.absent(),
          }) =>
              UserProgressCompanion(
            id: id,
            totalVersesRead: totalVersesRead,
            streakDays: streakDays,
            lastReadDate: lastReadDate,
            premiumUnlocked: premiumUnlocked,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> totalVersesRead = const Value.absent(),
            Value<int> streakDays = const Value.absent(),
            Value<String?> lastReadDate = const Value.absent(),
            Value<bool> premiumUnlocked = const Value.absent(),
          }) =>
              UserProgressCompanion.insert(
            id: id,
            totalVersesRead: totalVersesRead,
            streakDays: streakDays,
            lastReadDate: lastReadDate,
            premiumUnlocked: premiumUnlocked,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UserProgressTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserProgressTable,
    UserProgressData,
    $$UserProgressTableFilterComposer,
    $$UserProgressTableOrderingComposer,
    $$UserProgressTableAnnotationComposer,
    $$UserProgressTableCreateCompanionBuilder,
    $$UserProgressTableUpdateCompanionBuilder,
    (
      UserProgressData,
      BaseReferences<_$AppDatabase, $UserProgressTable, UserProgressData>
    ),
    UserProgressData,
    PrefetchHooks Function()>;
typedef $$BookmarksTableCreateCompanionBuilder = BookmarksCompanion Function({
  Value<int> id,
  required int surahNum,
  required int ayahNum,
  required String bookmarkedAt,
});
typedef $$BookmarksTableUpdateCompanionBuilder = BookmarksCompanion Function({
  Value<int> id,
  Value<int> surahNum,
  Value<int> ayahNum,
  Value<String> bookmarkedAt,
});

class $$BookmarksTableFilterComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get surahNum => $composableBuilder(
      column: $table.surahNum, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ayahNum => $composableBuilder(
      column: $table.ayahNum, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get bookmarkedAt => $composableBuilder(
      column: $table.bookmarkedAt, builder: (column) => ColumnFilters(column));
}

class $$BookmarksTableOrderingComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get surahNum => $composableBuilder(
      column: $table.surahNum, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ayahNum => $composableBuilder(
      column: $table.ayahNum, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get bookmarkedAt => $composableBuilder(
      column: $table.bookmarkedAt,
      builder: (column) => ColumnOrderings(column));
}

class $$BookmarksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get surahNum =>
      $composableBuilder(column: $table.surahNum, builder: (column) => column);

  GeneratedColumn<int> get ayahNum =>
      $composableBuilder(column: $table.ayahNum, builder: (column) => column);

  GeneratedColumn<String> get bookmarkedAt => $composableBuilder(
      column: $table.bookmarkedAt, builder: (column) => column);
}

class $$BookmarksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BookmarksTable,
    Bookmark,
    $$BookmarksTableFilterComposer,
    $$BookmarksTableOrderingComposer,
    $$BookmarksTableAnnotationComposer,
    $$BookmarksTableCreateCompanionBuilder,
    $$BookmarksTableUpdateCompanionBuilder,
    (Bookmark, BaseReferences<_$AppDatabase, $BookmarksTable, Bookmark>),
    Bookmark,
    PrefetchHooks Function()> {
  $$BookmarksTableTableManager(_$AppDatabase db, $BookmarksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BookmarksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BookmarksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BookmarksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> surahNum = const Value.absent(),
            Value<int> ayahNum = const Value.absent(),
            Value<String> bookmarkedAt = const Value.absent(),
          }) =>
              BookmarksCompanion(
            id: id,
            surahNum: surahNum,
            ayahNum: ayahNum,
            bookmarkedAt: bookmarkedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int surahNum,
            required int ayahNum,
            required String bookmarkedAt,
          }) =>
              BookmarksCompanion.insert(
            id: id,
            surahNum: surahNum,
            ayahNum: ayahNum,
            bookmarkedAt: bookmarkedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BookmarksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BookmarksTable,
    Bookmark,
    $$BookmarksTableFilterComposer,
    $$BookmarksTableOrderingComposer,
    $$BookmarksTableAnnotationComposer,
    $$BookmarksTableCreateCompanionBuilder,
    $$BookmarksTableUpdateCompanionBuilder,
    (Bookmark, BaseReferences<_$AppDatabase, $BookmarksTable, Bookmark>),
    Bookmark,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$VersesTableTableManager get verses =>
      $$VersesTableTableManager(_db, _db.verses);
  $$EntitiesTableTableManager get entities =>
      $$EntitiesTableTableManager(_db, _db.entities);
  $$EntityTriggersTableTableManager get entityTriggers =>
      $$EntityTriggersTableTableManager(_db, _db.entityTriggers);
  $$RelationEdgesTableTableManager get relationEdges =>
      $$RelationEdgesTableTableManager(_db, _db.relationEdges);
  $$ConstellationEdgesTableTableManager get constellationEdges =>
      $$ConstellationEdgesTableTableManager(_db, _db.constellationEdges);
  $$StoriesTableTableManager get stories =>
      $$StoriesTableTableManager(_db, _db.stories);
  $$StoryVerseRangesTableTableManager get storyVerseRanges =>
      $$StoryVerseRangesTableTableManager(_db, _db.storyVerseRanges);
  $$ThemesTableTableManager get themes =>
      $$ThemesTableTableManager(_db, _db.themes);
  $$ThemeLevelsTableTableManager get themeLevels =>
      $$ThemeLevelsTableTableManager(_db, _db.themeLevels);
  $$ThemeTriggersTableTableManager get themeTriggers =>
      $$ThemeTriggersTableTableManager(_db, _db.themeTriggers);
  $$SetsTableTableManager get sets => $$SetsTableTableManager(_db, _db.sets);
  $$SetRequirementsTableTableManager get setRequirements =>
      $$SetRequirementsTableTableManager(_db, _db.setRequirements);
  $$CollectionsTableTableManager get collections =>
      $$CollectionsTableTableManager(_db, _db.collections);
  $$CollectionEntitiesTableTableManager get collectionEntities =>
      $$CollectionEntitiesTableTableManager(_db, _db.collectionEntities);
  $$ExpeditionsTableTableManager get expeditions =>
      $$ExpeditionsTableTableManager(_db, _db.expeditions);
  $$UserProgressTableTableManager get userProgress =>
      $$UserProgressTableTableManager(_db, _db.userProgress);
  $$BookmarksTableTableManager get bookmarks =>
      $$BookmarksTableTableManager(_db, _db.bookmarks);
}
