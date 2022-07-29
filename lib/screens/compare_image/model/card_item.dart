/// One card with image path to asset and pressing condition.
class CardItem {
  /// Path to image in directory asset.
  final String asset;

  /// Clicking on a card.
  final bool isTaped;

  /// Be sure to pass the path to the file and optionally the click state.
  const CardItem({
    required this.asset,
    this.isTaped = false,
  });

  /// Сreates a new CardItem object with the given parameters.
  CardItem copyWith({
    String? asset,
    bool? isTaped,
  }) {
    return CardItem(
      asset: asset ?? this.asset,
      isTaped: isTaped ?? this.isTaped,
    );
  }
}
