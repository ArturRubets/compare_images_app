part of 'compare_image_bloc.dart';

/// State for this page.
class CompareImageState extends Equatable {
  /// List of cards
  final List<CardItem> listOfCards;

  /// The list of properties that will be used to determine whether
  /// two instances are equal.
  @override
  List<Object> get props {
    return [
      listOfCards,
    ];
  }

  /// CompareImageState constructor
  const CompareImageState({required this.listOfCards});

  /// Сreates a new CompareImageState object with the given parameters.
  /// Need to create a new state to update the block.
  CompareImageState copyWith({
    List<CardItem>? listOfCards,
  }) {
    return CompareImageState(
      listOfCards: listOfCards ?? this.listOfCards,
    );
  }
}
