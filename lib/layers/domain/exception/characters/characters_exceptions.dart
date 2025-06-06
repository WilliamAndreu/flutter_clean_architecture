import 'package:rickmorty/core/exceptions/custom_exception.dart';

sealed class CharactersException extends CustomException {
  const CharactersException();
}

final class CharactersGenericException extends CharactersException {
  @override
  String get title => 'Characters had an error';

  @override
  String get message => 'An error occurred while fetching characters. Please try again later.';

  const CharactersGenericException();
}

final class CharactersEndpointGoneException extends CharactersException {
  @override
  String get title => 'Characters Endpoint Gone';

  @override
  String get message => 'The characters endpoint is no longer available.';

  const CharactersEndpointGoneException();
}
