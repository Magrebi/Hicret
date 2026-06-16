// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reader_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$verseListHash() => r'e2bc0b0d027481cc2cb6487c74ad887a71991921';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Exposes the list of verses fetched from the database for a specific Surah chapter.
///
/// Copied from [verseList].
@ProviderFor(verseList)
const verseListProvider = VerseListFamily();

/// Exposes the list of verses fetched from the database for a specific Surah chapter.
///
/// Copied from [verseList].
class VerseListFamily extends Family<AsyncValue<List<Verse>>> {
  /// Exposes the list of verses fetched from the database for a specific Surah chapter.
  ///
  /// Copied from [verseList].
  const VerseListFamily();

  /// Exposes the list of verses fetched from the database for a specific Surah chapter.
  ///
  /// Copied from [verseList].
  VerseListProvider call(
    int surahNum,
  ) {
    return VerseListProvider(
      surahNum,
    );
  }

  @override
  VerseListProvider getProviderOverride(
    covariant VerseListProvider provider,
  ) {
    return call(
      provider.surahNum,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'verseListProvider';
}

/// Exposes the list of verses fetched from the database for a specific Surah chapter.
///
/// Copied from [verseList].
class VerseListProvider extends AutoDisposeFutureProvider<List<Verse>> {
  /// Exposes the list of verses fetched from the database for a specific Surah chapter.
  ///
  /// Copied from [verseList].
  VerseListProvider(
    int surahNum,
  ) : this._internal(
          (ref) => verseList(
            ref as VerseListRef,
            surahNum,
          ),
          from: verseListProvider,
          name: r'verseListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$verseListHash,
          dependencies: VerseListFamily._dependencies,
          allTransitiveDependencies: VerseListFamily._allTransitiveDependencies,
          surahNum: surahNum,
        );

  VerseListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.surahNum,
  }) : super.internal();

  final int surahNum;

  @override
  Override overrideWith(
    FutureOr<List<Verse>> Function(VerseListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: VerseListProvider._internal(
        (ref) => create(ref as VerseListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        surahNum: surahNum,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Verse>> createElement() {
    return _VerseListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is VerseListProvider && other.surahNum == surahNum;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, surahNum.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin VerseListRef on AutoDisposeFutureProviderRef<List<Verse>> {
  /// The parameter `surahNum` of this provider.
  int get surahNum;
}

class _VerseListProviderElement
    extends AutoDisposeFutureProviderElement<List<Verse>> with VerseListRef {
  _VerseListProviderElement(super.provider);

  @override
  int get surahNum => (origin as VerseListProvider).surahNum;
}

String _$readerStateNotifierHash() =>
    r'b437542bdc954599d17c07756d86368b8ff0f0b4';

/// State notifier managing ephemeral settings on the reader screen.
///
/// Copied from [ReaderStateNotifier].
@ProviderFor(ReaderStateNotifier)
final readerStateNotifierProvider =
    AutoDisposeNotifierProvider<ReaderStateNotifier, ReaderState>.internal(
  ReaderStateNotifier.new,
  name: r'readerStateNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$readerStateNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ReaderStateNotifier = AutoDisposeNotifier<ReaderState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
