import 'package:compare_images_app/screens/compare_image/bloc/compare_image_bloc.dart';
import 'package:compare_images_app/screens/compare_image/model/card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Image picker widget.
class CardSelectable extends StatelessWidget {
  /// Image opacity.
  static const opacity = 0.5;

  /// Card border radius.
  static const borderRadius = 10.0;

  /// Index card in list
  final int indexCard;

  /// CardSelectable constructor takes the index of the card
  /// in the list of cards
  const CardSelectable({
    required this.indexCard,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context
          .read<CompareImageBloc>()
          .add(CompareCardTappedEvent(indexCard)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(CardSelectable.borderRadius),
        child: ColoredBox(
          color: Colors.black,
          child: BlocSelector<CompareImageBloc, CompareImageState, CardItem>(
            selector: (state) => state.listOfCards[indexCard],
            builder: (context, card) {
              return AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: card.isTaped ? CardSelectable.opacity : 1,
                child: Image.asset(
                  card.asset,
                  fit: BoxFit.fill,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
