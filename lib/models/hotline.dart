class Hotline {
  const Hotline({
    required this.id,
    required this.name,
    required this.number,
    required this.asset,
    required this.source,
    this.note = '',
  });
  final String id, name, number, asset, source, note;
  String get dialNumber => number.replaceAll(RegExp(r'[^0-9+]'), '');
  Uri get phoneUri => Uri(scheme: 'tel', path: dialNumber);
}
