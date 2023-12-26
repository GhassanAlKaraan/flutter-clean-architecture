//! Added the whole file to the widgets folder
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mapp_clean_architecture/features/pokemon_image/business/entities/pokemon_image_entity.dart';
import 'package:provider/provider.dart';

import '../../../../../core/errors/failure.dart';
import '../providers/pokemon_image_provider.dart';

class PokemonImageWidget extends StatelessWidget {
  const PokemonImageWidget({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    //! Get provider data. Either fields can be null
    PokemonImageEntity? pokemonImageEntity =
        Provider.of<PokemonImageProvider>(context).pokemonImage;
    Failure? failure = Provider.of<PokemonImageProvider>(context).failure;
    //!

    late Widget widget;
    //! Added Flow control
    if (pokemonImageEntity != null) {
      // return image if we have data
      widget = Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.orange,
            image: DecorationImage(
              //! rplace the file image
              //!image: AssetImage('assets/images/mapp.png'),
              image: FileImage(File(pokemonImageEntity.path)),
              //!
            ),
          ),
          child: child,
        ),
      );
    } else if (failure != null) {
      // return error message if we have failure
      widget = Expanded(
        child: Center(
            child: Text(
          failure.errorMessage,
          style: const TextStyle(fontSize: 20),
        )),
      );
    } else {
      // show loading
      widget =
          const Expanded(child: Center(child: CircularProgressIndicator()));
    }
    //!
    return widget;
  }
}
