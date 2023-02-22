import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_challenge/core/constants/dimens.dart';
import 'package:rick_and_morty_challenge/features/auth/bloc/auth_bloc.dart';
import 'package:rick_and_morty_challenge/features/homepage/bloc/characters_bloc.dart';

class CharactersList extends StatelessWidget {
  const CharactersList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          BlocBuilder<CharactersBloc, CharactersState>(
            builder: (context, state) {
              return state.when(
                initial: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                loaded: (characters, page, hasReachedMax) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: characters.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(Spacers.small),
                          height: MediaQuery.of(context).size.height * 0.17,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Spacers.small),
                            color: theme.backgroundColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CachedNetworkImage(
                                imageUrl: characters[index].image,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  height:
                                      MediaQuery.of(context).size.height * 0.17,
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
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    AutoSizeText(
                                      characters[index].name,
                                      style: theme.textTheme.headline6,
                                      maxLines: 3,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: Spacers.small,
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
                                          style: theme.textTheme.bodyText2,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Last known location:',
                                      style: TextStyle(
                                        color: theme.disabledColor,
                                      ),
                                    ),
                                    Text(
                                      characters[index].location?.name ??
                                          'Unknown',
                                    ),
                                    Text(
                                      'First seen in:',
                                      style: TextStyle(
                                        color: theme.disabledColor,
                                      ),
                                    ),
                                    Text(
                                      characters[index].episode.isNotEmpty
                                          ? characters[index].episode.first.name
                                          : 'Unknown',
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
                error: (failure) => Center(
                  child: Text(failure.toString()),
                ),
              );
            },
          ),
          ElevatedButton(
            onPressed: () =>
                context.read<AuthBloc>().add(const AuthEvent.logout()),
            child: const Text('Logout'),
          )
        ],
      ),
    );
  }
}
