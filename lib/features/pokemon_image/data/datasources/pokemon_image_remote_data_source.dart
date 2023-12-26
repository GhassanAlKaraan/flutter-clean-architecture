import 'dart:io';

import 'package:dio/dio.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/params/params.dart';
import '../../../../core/constants/constants.dart';
import '../models/pokemon_image_model.dart';
import 'package:path_provider/path_provider.dart';

abstract class PokemonImageRemoteDataSource {
  Future<PokemonImageModel> getPokemonImage(
      {required PokemonImageParams pokemonImageParams});
}

class PokemonImageRemoteDataSourceImpl implements PokemonImageRemoteDataSource {
  final Dio dio;

  PokemonImageRemoteDataSourceImpl({required this.dio});

  @override
  Future<PokemonImageModel> getPokemonImage(
      {required PokemonImageParams pokemonImageParams}) async {
    //! Add logic
    Directory directory = await getApplicationDocumentsDirectory();
    directory.deleteSync(recursive: true); // false if directory is empty
    final String pathFile = '${directory.path}/${pokemonImageParams.name}.png';
    //!

    //! Replace the dio methods
    //! final response = await dio.get(
    //!   'https://pokeapi.co/api/v2/pokemon/',
    //!   queryParameters: {
    //!     'api_key': 'if needed',
    //!   },
    //! );
    //! if (response.statusCode == 200) {
    //!       //save image on phone is success
    //!       return PokemonImageModel.fromJson(json: response.data);
    //!     } else {
    //!       throw ServerException();
    //!     }

    final response = await dio.download(pokemonImageParams.imageUrl, pathFile);

    if (response.statusCode == 200) {
      //save image on phone is success
      return PokemonImageModel.fromJson(
          json: {kPath: pathFile}); // map= {key:val}
    } else {
      throw ServerException();
    }
    //!
  }
}
