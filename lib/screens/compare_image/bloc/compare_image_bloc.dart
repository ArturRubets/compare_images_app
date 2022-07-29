import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:compare_images_app/screens/compare_image/model/card_item.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'compare_image_event.dart';
part 'compare_image_state.dart';

/// Business logic comparison photo.
class CompareImageBloc extends Bloc<CompareImageEvent, CompareImageState> {
  /// CompareImageBloc constructor.
  CompareImageBloc({required List<CardItem> listOfCards})
      : super(CompareImageState(listOfCards: listOfCards)) {
    on<CompareCardTappedEvent>(_tappedOnCard);
  }

  FutureOr<void> _tappedOnCard(
    CompareCardTappedEvent event,
    Emitter<CompareImageState> emit,
  ) {
    final listOfCards = List<CardItem>.from(state.listOfCards);
    final index = event.indexOfCards;

    final isTaped = listOfCards[index].isTaped;
    listOfCards[index] = listOfCards[index].copyWith(isTaped: !isTaped);
    emit(state.copyWith(listOfCards: listOfCards));
  }
}
