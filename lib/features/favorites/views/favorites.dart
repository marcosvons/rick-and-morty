import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_challenge/core/core.dart';
import 'package:rick_and_morty_challenge/features/features.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const FavoritesView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(
            fontFamily: 'PTSans',
          ),
        ),
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const Center(child: CircularProgressIndicator()),
            loaded: (favorites) => ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(
                  left: Spacers.medium,
                  right: Spacers.medium,
                  top: Spacers.medium,
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Spacers.medium),
                  ),
                  tileColor: Theme.of(context).backgroundColor,
                  title: Text(
                    favorites[index].name,
                    style: const TextStyle(
                      fontFamily: 'PTSans',
                    ),
                  ),
                  leading: CachedNetworkImage(
                    imageUrl: favorites[index].image,
                    imageBuilder: (context, imageProvider) => Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Spacers.small),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
