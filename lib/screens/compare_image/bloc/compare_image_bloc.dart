import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:compare_images_app/screens/compare_image/model/card_item.dart';
import 'package:compare_images_app/screens/compare_image/model/result_of_compare.dart';
import 'package:compare_images_app/utils/get_bytes_image.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'compare_image_event.dart';
part 'compare_image_state.dart';

/// Business logic comparison photo.
class CompareImageBloc extends Bloc<CompareImageEvent, CompareImageState> {
  /// CompareImageBloc constructor.
  CompareImageBloc({required List<CardItem> listOfCards})
      : super(CompareImageState(listOfCards: listOfCards)) {
    on<CompareCardTappedEvent>(_onTappedCard);
    on<CompareCardComparedEvent>(_onCompareCards);
    on<CompareCardResetCardToInitialStateEvent>(
      _onCompareCardResetCardToInitialStateEvent,
    );
  }

  FutureOr<void> _onTappedCard(
    CompareCardTappedEvent event,
    Emitter<CompareImageState> emit,
  ) async {
    final newList = List<CardItem>.from(state.listOfCards);
    final index = _indexCardInList(newList, event.cardItem);
    if (index == null) return;

    final isTaped = newList[index].isTaped;
    newList[index] = newList[index].copyWith(isTaped: !isTaped);

    if (_selectedCards(newList).length <=
        CompareImageState.numberOfComparedPictures) {
      emit(state.copyWith(listOfCards: newList));
    }
  }

  FutureOr<void> _onCompareCards(
    CompareCardComparedEvent _,
    Emitter<CompareImageState> emit,
  ) async {
    final selectedCards = _selectedCards(state.listOfCards);
    if (!_isRequiredNumberOfPicturesSelected(selectedCards)) {
      return;
    }
    for (var i = 1; i < selectedCards.length; i++) {
      final imagePath1 = selectedCards[i - 1].asset;
      final imagePath2 = selectedCards[i].asset;

      final imageBytes1 = await getImageBytes(imagePath1);
      final imageBytes2 = await getImageBytes(imagePath2);

      final isEqual = listEquals(imageBytes1, imageBytes2);

      if (isEqual) {
        final card1 = selectedCards[i - 1]
            .copyWith(resultOfCompare: ResultOfCompare.equal);
        _updateStateCard(emit, state.listOfCards, card1);

        final card2 =
            selectedCards[i].copyWith(resultOfCompare: ResultOfCompare.equal);
        _updateStateCard(emit, state.listOfCards, card2);
      } else {
        final card1 = selectedCards[i - 1]
            .copyWith(resultOfCompare: ResultOfCompare.notEqual);
        _updateStateCard(emit, state.listOfCards, card1);

        final card2 = selectedCards[i]
            .copyWith(resultOfCompare: ResultOfCompare.notEqual);
        _updateStateCard(emit, state.listOfCards, card2);
      }
    }
  }

  FutureOr<void> _onCompareCardResetCardToInitialStateEvent(
    CompareCardResetCardToInitialStateEvent event,
    Emitter<CompareImageState> emit,
  ) {
    _updateStateCard(
      emit,
      state.listOfCards,
      event.cardItem.copyWith(
        isTaped: false,
        resultOfCompare: ResultOfCompare.initial,
      ),
    );
  }

  void _updateStateCard(
    Emitter<CompareImageState> emit,
    List<CardItem> listOfCards,
    CardItem card,
  ) {
    final list = List<CardItem>.from(listOfCards);
    final listWithNewCard =
        list.map((c) => c.id == card.id ? card : c).toList();
    emit(state.copyWith(listOfCards: listWithNewCard));
  }

  bool _isRequiredNumberOfPicturesSelected(List<CardItem> listOfCards) =>
      listOfCards.length == CompareImageState.numberOfComparedPictures;

  List<CardItem> _selectedCards(List<CardItem> listOfCards) =>
      listOfCards.where((element) => element.isTaped == true).toList();

  int? _indexCardInList(List<CardItem> listOfCards, CardItem card) {
    final index = listOfCards.indexWhere((element) => element.id == card.id);

    return index != -1 ? index : null;
  }
}
