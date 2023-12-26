class NoParams {}

class TemplateParams {}

//! Add parameters
//! class PokemonImageParams {}
class PokemonImageParams {
  final String name;
  final String imageUrl;
  const PokemonImageParams({ required this.name, required this.imageUrl
  });
}
//!

class PokemonParams {
  final String id;
  const PokemonParams({
    required this.id,
  });
}