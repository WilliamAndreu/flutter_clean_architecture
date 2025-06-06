import 'package:flutter/material.dart';
import 'package:flutter_moshimoshi/authenticationCard/password/password_authentication_card.dart';
import 'package:flutter_moshimoshi/authenticator/app/authenticator.dart';
import 'package:flutter_moshimoshi/entities/endpoint.dart';
import 'package:flutter_moshimoshi/entities/moshi_interceptor.dart';
import 'package:flutter_moshimoshi/flutter_moshimoshi.dart';
import 'package:flutter_moshimoshi/interceptor/AuthInterceptor.dart';
import 'package:flutter_moshimoshi/storage/shared_preferences/shared_preferences_storage.dart';
import 'package:flutter_moshimoshi/storage/storage_interface.dart';
import 'package:rickmorty/core/interceptors/dio_interceptor.dart';
import 'package:rickmorty/layers/presentation/features/characters_list/characters_list_page.dart';

class Endpoints {
  static final Endpoint loginEndpoint = Endpoint(
    url: '/auth/token',
    headers: {'Content-Type': 'application/json'},
    method: Method.post,
  );

  static final Endpoint refreshEndpoint = Endpoint(
    url: '/auth/token',
    headers: {'Content-Type': 'application/json'},
    method: Method.post,
  );
}

class MoshiWrapper {
  late final StorageInterface _tokenStore;
  late final PasswordAuthenticationCard _authCard;
  late final AuthInterceptor _authInterceptor;
  late final Authenticator _authenticator;
  late final MoshiMoshi _moshi;

  factory MoshiWrapper() => _singleton;
  MoshiWrapper._internal();

  static final MoshiWrapper _singleton = MoshiWrapper._internal();

  void initialize(BuildContext? context) {
    _tokenStore = SharedPreferencesStorage();
    _authCard = _buildAuthCard(context);
    _authenticator = Authenticator(_tokenStore, _authCard);
    _authInterceptor = AuthInterceptor(authenticator: _authenticator);
    _moshi = _buildMoshi(_authenticator, _tokenStore, _authInterceptor);
  }

  PasswordAuthenticationCard _buildAuthCard(BuildContext? context) {
    return PasswordAuthenticationCard(
      loginEndpoint: Endpoints.loginEndpoint,
      refreshEndpoint: Endpoints.refreshEndpoint,
      context: context,
      loginPage: const CharactersListView(),
    );
  }

  MoshiMoshi _buildMoshi(
    Authenticator authenticator,
    StorageInterface tokenStore,
    AuthInterceptor authInterceptor,
  ) {
    final moshi = MoshiMoshi(
      authenticator: authenticator,
      storage: tokenStore,
      interceptors: [
        MoshiInterceptor(
          type: InterceptorType.nonAuthenticated,
          interceptor: CustomInterceptor(),
        ),
      ],
    );
    moshi.call.interceptors.add(CustomInterceptor());
    return moshi;
  }

  MoshiMoshi get moshi => _moshi;
  Authenticator get authenticator => _authenticator;
}
