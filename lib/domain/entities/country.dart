class Country {
  final String name;
  final String code;
  final String flagAsset;

  const Country({
    required this.name,
    required this.code,
    required this.flagAsset,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Country &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          code == other.code &&
          flagAsset == other.flagAsset;

  @override
  int get hashCode => name.hashCode ^ code.hashCode ^ flagAsset.hashCode;
}

