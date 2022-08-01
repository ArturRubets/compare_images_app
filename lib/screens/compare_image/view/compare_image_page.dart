import 'package:compare_images_app/screens/compare_image/bloc/compare_image_bloc.dart';
import 'package:compare_images_app/screens/compare_image/widgets/card_selectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// HomePage.
class CompareImagePage extends StatefulWidget {
  /// Max cross axis extent.
  static const maxCrossAxisExtent = 200.0;

  /// Max cross axis extent.
  static const crossAxisSpacing = 8.0;

  /// Max cross axis extent.
  static const mainAxisSpacing = 8.0;

  /// Bottom padding so that the button does not overlap the system bar.
  static const bottomPaddingForButton = 10.0;

  /// Title this page.
  final String title;

  /// CompareImagePage constructor. [title] is needed to display the title
  /// of the page in the appbar.
  const CompareImagePage({
    required this.title,
    super.key,
  });

  @override
  State<CompareImagePage> createState() => _CompareImagePageState();
}

class _CompareImagePageState extends State<CompareImagePage> {
  @override
  Widget build(BuildContext context) {
    final listOfCards = context.read<CompareImageBloc>().state.listOfCards;

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Stack(
          alignment: Alignment.bottomCenter,
          fit: StackFit.expand,
          children: [
            GridView.extent(
              shrinkWrap: true,
              maxCrossAxisExtent: CompareImagePage.maxCrossAxisExtent,
              crossAxisSpacing: CompareImagePage.crossAxisSpacing,
              mainAxisSpacing: CompareImagePage.mainAxisSpacing,
              children: List.generate(
                listOfCards.length,
                (index) => CardSelectable(
                  card: listOfCards[index],
                  key: Key('cardselectable_$index'),
                ),
              ),
            ),
            Positioned(
              bottom: CompareImagePage.bottomPaddingForButton,
              child: ElevatedButton(
                onPressed: () => context
                    .read<CompareImageBloc>()
                    .add(const CompareCardComparedEvent()),
                child: const Text('Compare'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
