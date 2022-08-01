part of 'compare_image_bloc.dart';

/// CompareImageEvent.
@immutable
abstract class CompareImageEvent {
  /// CompareImageEvent constructor.
  const CompareImageEvent();
}

/// Photo click events.
class CompareCardTappedEvent extends CompareImageEvent {
  /// Clicked card.
  final CardItem cardItem;

  /// Constructor for CompareImageTappedEvent.
  const CompareCardTappedEvent(this.cardItem);
}

/// Button click events.
class CompareCardComparedEvent extends CompareImageEvent {
  /// Constructor for CompareCardComparedEvent.
  const CompareCardComparedEvent();
}

/// Event to reset the card state
class CompareCardResetCardToInitialStateEvent extends CompareImageEvent {
  /// Card in which you need to reset the state.
  final CardItem cardItem;

  /// Constructor  accepts a card [cardItem]
  const CompareCardResetCardToInitialStateEvent(this.cardItem);
}
