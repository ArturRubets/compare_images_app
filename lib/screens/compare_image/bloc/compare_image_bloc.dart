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
  }

  FutureOr<void> _onTappedCard(
    CompareCardTappedEvent event,
    Emitter<CompareImageState> emit,
  ) {
    if (state.resultOfCompare != ResultOfCompare.initial) {
      final listOfCards = List<CardItem>.from(state.listOfCards);
      emit(
        state.copyWith(
          resultOfCompare: ResultOfCompare.initial,
          listOfCards:
              listOfCards.map((e) => e.copyWith(isTaped: false)).toList(),
        ),
      );
    }

    final listOfCards = List<CardItem>.from(state.listOfCards);
    final index = event.indexOfCards;

    final isTaped = listOfCards[index].isTaped;
    listOfCards[index] = listOfCards[index].copyWith(isTaped: !isTaped);

    if (_selectedCards(listOfCards).length <=
        CompareImageState.numberOfComparedPictures) {
      emit(state.copyWith(listOfCards: listOfCards));
    }
  }

  FutureOr<void> _onCompareCards(
    CompareCardComparedEvent _,
    Emitter<CompareImageState> emit,
  ) async {
    if (!_isRequiredNumberOfPicturesSelected(state.listOfCards)) {
      return;
    }
    final selectedCards = _selectedCards(state.listOfCards);
    for (var i = 1; i < selectedCards.length; i++) {
      final imagePath1 = selectedCards[i - 1].asset;
      final imagePath2 = selectedCards[i].asset;

      final imageBytes1 = await getImageBytes(imagePath1);
      final imageBytes2 = await getImageBytes(imagePath2);

      final resultOfCompare = listEquals(imageBytes1, imageBytes2);
      if (!resultOfCompare) {
        emit(state.copyWith(resultOfCompare: ResultOfCompare.notEqual));

        return;
      }
    }

    emit(state.copyWith(resultOfCompare: ResultOfCompare.equal));
  }

  bool _isRequiredNumberOfPicturesSelected(List<CardItem> listOfCards) {
    return _selectedCards(listOfCards).length ==
        CompareImageState.numberOfComparedPictures;
  }

  List<CardItem> _selectedCards(List<CardItem> listOfCards) {
    return listOfCards.where((element) => element.isTaped == true).toList();
  }
}
