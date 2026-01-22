import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty_2/views/screens/characters_view/characters_viewmodel.dart';
import 'package:rickandmorty_2/views/widgets/character_card_listview.dart';
import 'package:rickandmorty_2/views/widgets/character_card_view.dart';

import '../../widgets/appbar_widget.dart';

class CharactersView extends StatefulWidget {
  const CharactersView({super.key});

  @override
  State<CharactersView> createState() => _CharactersViewState();
}

class _CharactersViewState extends State<CharactersView> {
  @override
  void initState() {
    super.initState();
    context.read<CharactersViewmodel>().getCharacters();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context
        .watch<
          CharactersViewmodel
        >(); //Gelen veri ilk basta null, o yuzden veriyi read() ile okumak yerine watch() ile izleyecegiz bu sayede loading vs de gosterebilecegiz.

    return Scaffold(
      appBar: AppBarWidget(title: "Rick And Morty"),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Column(
            children: [
              _searchInputWidget(context, viewmodel: viewModel),
              SizedBox(height: 16),
              Consumer<CharactersViewmodel>(
                builder: (context, viewModel, child) {
                  if (viewModel.charactersModel == null) {
                    //egerki veriler gelmediyse
                    return const CircularProgressIndicator.adaptive();
                  } else {
                    return CharacterCardListview(
                      characters: viewModel.charactersModel!.characters,
                      onLoadMore: () => viewModel.getCharactersMore(),
                      loadMore: viewModel.loadMore,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchInputWidget(
    BuildContext context, {
    required CharactersViewmodel viewmodel,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: TextFormField(
        textInputAction: TextInputAction.search,
        onFieldSubmitted: (value) {
          viewmodel.getCharactersByName(value);
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          hintText: 'Karakterlerde Ara',
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          prefixIcon: Icon(Icons.search),
          suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ),
      ),
    );
  }
}
