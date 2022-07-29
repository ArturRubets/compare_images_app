import 'package:compare_images_app/app.dart';
import 'package:compare_images_app/screens/compare_image/bloc/compare_image_bloc.dart';
import 'package:compare_images_app/screens/compare_image/model/card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  const listOfCards = [
    CardItem(asset: 'assets/images/car_bmw.jpg'),
    CardItem(asset: 'assets/images/car_rarity.jpg'),
    CardItem(asset: 'assets/images/wild_seal.jpg'),
    CardItem(asset: 'assets/images/car_bmw.jpg'),
    CardItem(asset: 'assets/images/car_rarity.jpg'),
    CardItem(asset: 'assets/images/wild_seal.jpg'),
  ];

  runApp(
    BlocProvider(
      create: (_) => CompareImageBloc(listOfCards: listOfCards),
      child: const App(),
    ),
  );
}
