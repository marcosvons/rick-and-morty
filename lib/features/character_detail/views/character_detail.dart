import 'package:cached_network_image/cached_network_image.dart';
import 'package:characters_package/characters.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_challenge/core/core.dart';

class CharacterDetail extends StatelessWidget {
  const CharacterDetail({super.key, required this.character});

  final Character character;

  static Route<dynamic> route({required Character character}) {
    return MaterialPageRoute<void>(
      builder: (_) => CharacterDetail(
        character: character,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Spacers.medium,
          vertical: Spacers.large,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      imageUrl: character.image,
                      imageBuilder: (context, imageProvider) => Container(
                        width: MediaQuery.of(context).size.width * 0.42,
                        height: MediaQuery.of(context).size.height * 0.3,
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
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                text: 'Status: ',
                                style: const TextStyle(
                                  fontSize: Spacers.medium,
                                  fontWeight: FontWeight.w600,
                                ),
                                children: [
                                  TextSpan(
                                    text: character.status,
                                    style: const TextStyle(
                                      fontSize: Spacers.medium,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                text: 'Species: ',
                                style: const TextStyle(
                                  fontSize: Spacers.medium,
                                  fontWeight: FontWeight.w600,
                                ),
                                children: [
                                  TextSpan(
                                    text: character.species,
                                    style: const TextStyle(
                                      fontSize: Spacers.medium,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                text: 'Type: ',
                                style: const TextStyle(
                                  fontSize: Spacers.medium,
                                  fontWeight: FontWeight.w600,
                                ),
                                children: [
                                  TextSpan(
                                    text: character.type.isNotEmpty
                                        ? character.type
                                        : 'Unknown',
                                    style: const TextStyle(
                                      fontSize: Spacers.medium,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                text: 'Gender: ',
                                style: const TextStyle(
                                  fontSize: Spacers.medium,
                                  fontWeight: FontWeight.w600,
                                ),
                                children: [
                                  TextSpan(
                                    text: character.gender,
                                    style: const TextStyle(
                                      fontSize: Spacers.medium,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                text: 'Origin: ',
                                style: const TextStyle(
                                  fontSize: Spacers.medium,
                                  fontWeight: FontWeight.w600,
                                ),
                                children: [
                                  TextSpan(
                                    text: character.origin?.name ?? 'Unknown',
                                    style: const TextStyle(
                                      fontSize: Spacers.medium,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                text: 'Last known location: ',
                                style: const TextStyle(
                                  fontSize: Spacers.medium,
                                  fontWeight: FontWeight.w600,
                                ),
                                children: [
                                  TextSpan(
                                    text: character.location?.name ?? 'Unknown',
                                    style: const TextStyle(
                                      fontSize: Spacers.medium,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: Spacers.large),
              //Line division
              const Divider(
                color: Colors.grey,
                height: Spacers.large,
              ),
              const SizedBox(height: Spacers.large),
              Text(
                'Episodes',
                style: TextStyle(
                  fontSize: Spacers.large * 1.5,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: Spacers.medium),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: character.episode.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(Spacers.small),
                  child: ListTile(
                    tileColor: Theme.of(context).cardColor,
                    title: Text(character.episode[index].name),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Spacers.small),
                    ),
                    subtitle: Row(
                      children: [
                        Text(character.episode[index].episode),
                        const Spacer(),
                        Text(character.episode[index].airDate),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
