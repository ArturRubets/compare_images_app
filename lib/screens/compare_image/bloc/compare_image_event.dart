part of 'compare_image_bloc.dart';

/// CompareImageEvent.
@immutable
abstract class CompareImageEvent {
  /// CompareImageEvent constructor.
  const CompareImageEvent();
}

/// Photo click events.
class CompareCardTappedEvent extends CompareImageEvent {
  /// Index of cards.
  final int indexOfCards;

  /// Constructor for CompareImageTappedEvent.
  const CompareCardTappedEvent(this.indexOfCards);
}

/// Button click events.
class CompareCardComparedEvent extends CompareImageEvent {
  /// Constructor for CompareCardComparedEvent.
  const CompareCardComparedEvent();
}
