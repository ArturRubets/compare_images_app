import 'package:compare_images_app/screens/compare_image/model/result_of_compare.dart';
import 'package:equatable/equatable.dart';

/// One card with image path to asset and pressing condition.
class CardItem extends Equatable {
  /// Unique id image.
  final int id;

  /// Path to image in directory asset.
  final String asset;

  /// Clicking on a card.
  final bool isTaped;

  /// Result of compare.
  final ResultOfCompare resultOfCompare;

  @override
  List<Object?> get props => [
        asset,
        isTaped,
        resultOfCompare,
      ];

  /// Be sure to pass the path to the file and optionally the click state.
  const CardItem({
    required this.id,
    required this.asset,
    this.isTaped = false,
    this.resultOfCompare = ResultOfCompare.initial,
  });

  /// Сreates a new CardItem object with the given parameters.
  CardItem copyWith({
    int? id,
    String? asset,
    bool? isTaped,
    ResultOfCompare? resultOfCompare,
  }) {
    return CardItem(
      id: id ?? this.id,
      asset: asset ?? this.asset,
      isTaped: isTaped ?? this.isTaped,
      resultOfCompare: resultOfCompare ?? this.resultOfCompare,
    );
  }
}
