part of 'compare_image_bloc.dart';

/// State for this page.
class CompareImageState extends Equatable {
  /// Number of compared pictures.
  static const int numberOfComparedPictures = 2;

  /// List of cards.
  final List<CardItem> listOfCards;

  /// Result of compare.
  final ResultOfCompare resultOfCompare;

  /// The list of properties that will be used to determine whether
  /// two instances are equal.
  @override
  List<Object> get props {
    return [
      listOfCards,
      resultOfCompare,
    ];
  }

  /// CompareImageState constructor.
  const CompareImageState({
    required this.listOfCards,
    this.resultOfCompare = ResultOfCompare.initial,
  });

  /// Сreates a new CompareImageState object with the given parameters.
  /// Need to create a new state to update the block.
  CompareImageState copyWith({
    List<CardItem>? listOfCards,
    ResultOfCompare? resultOfCompare,
  }) {
    return CompareImageState(
      listOfCards: listOfCards ?? this.listOfCards,
      resultOfCompare: resultOfCompare ?? this.resultOfCompare,
    );
  }
}
