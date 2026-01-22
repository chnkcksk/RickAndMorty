import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty_2/views/screens/favourites_view/favourites_viewmodel.dart';
import 'package:rickandmorty_2/views/widgets/character_card_view.dart';

import '../../widgets/appbar_widget.dart';

class FavouritesView extends StatefulWidget {
  const FavouritesView({super.key});

  @override
  State<FavouritesView> createState() => _FavouritesViewState();
}

class _FavouritesViewState extends State<FavouritesView> {
  @override
  void initState() {
    super.initState();
    context.read<FavouritesViewmodel>().getFavouritedCharacters();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FavouritesViewmodel>();

    return Scaffold(

      appBar: AppBarWidget(title: 'Favorilerim'),
      body: Padding(
        padding: const EdgeInsets.all(17.0),
        child: Center(
          child: viewModel.characterModelFavourites == null
              ? const CircularProgressIndicator.adaptive()
              : Column(
                  children: [
                    Flexible(
                      child: ListView.builder(
                        itemCount: viewModel.characterModelFavourites!.length,
                        itemBuilder: (context, index) {
                          final selectedCharacter =
                              viewModel.characterModelFavourites![index];
                          return Column(
                            children: [
                              CharacterCardView(
                                characterModel: selectedCharacter,
                                isFavorited: true,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
