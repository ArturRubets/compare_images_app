import 'package:compare_images_app/app.dart';
import 'package:compare_images_app/screens/compare_image/bloc/compare_image_bloc.dart';
import 'package:compare_images_app/screens/compare_image/model/card_item.dart';
import 'package:compare_images_app/screens/compare_image/widgets/card_selectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CardSelectable', () {
    const listOfCards = [
      CardItem(id: 0, asset: 'assets/images/car_bmw.jpg'),
      CardItem(id: 1, asset: 'assets/images/car_rarity.jpg'),
    ];
    testWidgets('renders correct cards', (tester) async {
      await tester.pumpWidget(
        BlocProvider(
          create: (_) => CompareImageBloc(listOfCards: listOfCards),
          child: const App(),
        ),
      );

      expect(find.byType(CardSelectable), findsNWidgets(listOfCards.length));
    });
  });
}
