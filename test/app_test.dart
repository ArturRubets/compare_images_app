import 'package:compare_images_app/app.dart';
import 'package:compare_images_app/screens/compare_image/bloc/compare_image_bloc.dart';
import 'package:compare_images_app/screens/compare_image/model/card_item.dart';
import 'package:compare_images_app/screens/compare_image/view/compare_image_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders CompareImagePage', (tester) async {
      await tester.pumpWidget(
        BlocProvider(
          create: (_) => CompareImageBloc(listOfCards: <CardItem>[]),
          child: const App(),
        ),
      );

      expect(find.byType(CompareImagePage), findsOneWidget);
    });

    testWidgets('has correct theme primary color', (tester) async {
      const color = Colors.deepOrange;
      await tester.pumpWidget(
        BlocProvider(
          create: (_) => CompareImageBloc(listOfCards: <CardItem>[]),
          child: const App(),
        ),
      );
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.theme?.primaryColor, color);
    });
  });
}
