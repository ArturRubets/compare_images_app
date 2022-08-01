import 'package:collection/collection.dart';
import 'package:compare_images_app/screens/compare_image/bloc/compare_image_bloc.dart';
import 'package:compare_images_app/screens/compare_image/model/card_item.dart';
import 'package:compare_images_app/screens/compare_image/model/result_of_compare.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Image picker widget.
class CardSelectable extends StatefulWidget {
  /// Card in list.
  final CardItem card;

  /// CardSelectable constructor takes the index of the card
  /// in the list of cards.
  const CardSelectable({
    required this.card,
    super.key,
  });

  @override
  State<CardSelectable> createState() => _CardSelectableState();
}

class _CardSelectableState extends State<CardSelectable> {
  static const opacity = 0.4;
  static const borderRadius = 10.0;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BlocSelector<CompareImageBloc, CompareImageState, CardItem?>(
        selector: (state) => state.listOfCards
            .firstWhereOrNull((element) => element.id == widget.card.id),
        builder: (_, card) {
          if (card == null) return const SizedBox.shrink();

          final Color color;
          switch (card.resultOfCompare) {
            case ResultOfCompare.initial:
              color = Colors.black;
              break;
            case ResultOfCompare.equal:
              color = Colors.green;
              break;
            case ResultOfCompare.notEqual:
              color = Colors.red;
              break;
          }

          return GestureDetector(
            onTap: () {
              if (card.resultOfCompare == ResultOfCompare.initial) {
                context
                    .read<CompareImageBloc>()
                    .add(CompareCardTappedEvent(widget.card));
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 1000),
              color: color,
              onEnd: () => context
                  .read<CompareImageBloc>()
                  .add(CompareCardResetCardToInitialStateEvent(widget.card)),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: card.isTaped ? opacity : 1,
                child: ColoredBox(
                  color: Colors.black,
                  child: Image.asset(
                    card.asset,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
