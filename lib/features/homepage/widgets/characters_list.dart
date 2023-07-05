import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_challenge/app/view/app.dart';
import 'package:rick_and_morty_challenge/core/constants/dimens.dart';
import 'package:rick_and_morty_challenge/core/constants/string_constants.dart';
import 'package:rick_and_morty_challenge/features/features.dart';

class CharactersList extends StatelessWidget {
  const CharactersList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Characters',
          style: TextStyle(
            fontFamily: 'PTSans',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(const AuthEvent.logout());
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const App(),
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Image.asset(
                AssetConstants.rickAndMortyLogo,
                fit: BoxFit.contain,
              ),
            ),
            ListTile(
              title: const Text(
                'Characters',
                style: TextStyle(
                  fontSize: Spacers.medium * 1.25,
                  fontFamily: 'PTSans',
                ),
              ),
              onTap: () {
                Navigator.of(context).push<void>(
                  CharactersView.route(),
                );
              },
            ),
            ListTile(
              title: const Text(
                'Favorites',
                style: TextStyle(
                  fontSize: Spacers.medium * 1.25,
                  fontFamily: 'PTSans',
                ),
              ),
              onTap: () {
                Navigator.of(context).push<void>(
                  MaterialPageRoute<dynamic>(
                    builder: (_) => BlocProvider.value(
                      value: BlocProvider.of<FavoritesBloc>(context),
                      child: const FavoritesView(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: BlocBuilder<CharactersBloc, CharactersState>(
        builder: (context, state) {
          return state.when(
            initial: () => Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            ),
            loading: () => Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            ),
            loaded: (characters, page, hasReachedMax) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: characters.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<dynamic>(
                          builder: (_) => BlocProvider.value(
                            value: BlocProvider.of<FavoritesBloc>(context),
                            child: CharacterDetail(
                              character: characters[index],
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(Spacers.medium),
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Spacers.small),
                        color: theme.backgroundColor,
                      ),
                      child: Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl: characters[index].image,
                            imageBuilder: (context, imageProvider) => Container(
                              width: MediaQuery.of(context).size.width * 0.32,
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Spacers.small),
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
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: Spacers.medium,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AutoSizeText(
                                    characters[index].name,
                                    style: theme.textTheme.headline6!.copyWith(
                                      fontFamily: 'PTSans',
                                    ),
                                    maxLines: 3,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 10,
                                        height: 10,
                                        margin: const EdgeInsets.only(
                                          right: Spacers.small,
                                        ),
                                        decoration: BoxDecoration(
                                          color: characters[index].status ==
                                                  'Alive'
                                              ? Colors.green
                                              : characters[index].status ==
                                                      'Dead'
                                                  ? Colors.red
                                                  : Colors.grey,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      Text(
                                        '${characters[index].status} - ${characters[index].species}',
                                        style:
                                            theme.textTheme.bodyText2!.copyWith(
                                          fontFamily: 'PTSans',
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Last known location:',
                                    style: TextStyle(
                                      color: theme.disabledColor,
                                      fontFamily: 'PTSans',
                                    ),
                                  ),
                                  Text(
                                    characters[index].location?.name ??
                                        'Unknown',
                                    style: const TextStyle(
                                      fontFamily: 'PTSans',
                                    ),
                                  ),
                                  Text(
                                    'First seen in:',
                                    style: TextStyle(
                                      color: theme.disabledColor,
                                      fontFamily: 'PTSans',
                                    ),
                                  ),
                                  Text(
                                    characters[index].episode.isNotEmpty
                                        ? characters[index].episode.first.name
                                        : 'Unknown',
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontFamily: 'PTSans',
                                    ),
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            error: (failure) => Center(
              child: Text(failure.toString()),
            ),
          );
        },
      ),
    );
  }
}