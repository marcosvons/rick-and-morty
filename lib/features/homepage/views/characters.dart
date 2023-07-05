import 'package:characters_package/characters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_challenge/core/core.dart';
import 'package:rick_and_morty_challenge/features/auth/bloc/auth_bloc.dart';
import 'package:rick_and_morty_challenge/features/favorites/favorites.dart';
import 'package:rick_and_morty_challenge/features/homepage/bloc/characters_bloc.dart';
import 'package:rick_and_morty_challenge/features/homepage/widgets/characters_list.dart';
import 'package:rick_and_morty_challenge/features/login/views/login.dart';

class CharactersView extends StatelessWidget {
  const CharactersView({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const CharactersView());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          unauthenticated: () => Navigator.of(context).push<void>(
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const LoginView(),
            ),
          ),
        );
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CharactersBloc>(
            create: (context) => CharactersBloc(
              charactersRepository: getIt<ICharactersRepository>(),
            )..add(const CharactersEvent.getCharacters()),
          ),
          BlocProvider<FavoritesBloc>(
            create: (context) => FavoritesBloc(
              charactersRepository: getIt<ICharactersRepository>(),
            )..add(const FavoritesEvent.loadFavorites()),
          ),
        ],
        child: const CharactersList(),
      ),
    );
  }
}
