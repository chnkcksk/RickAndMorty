import 'package:flutter/material.dart';
import 'package:rickandmorty_2/app/locator.dart';
import 'package:rickandmorty_2/services/preferences_service.dart';

import '../../models/characters_model.dart';
import 'character_card_view.dart';

class CharacterCardListview extends StatefulWidget {
  final List<CharacterModel> characters;
  final VoidCallback onLoadMore; //disariya fonksiyon aktardik
  final bool loadMore; // loading gozuksun mu

  const CharacterCardListview({
    super.key,
    required this.characters,
    required this.onLoadMore,
    this.loadMore = false,
  });

  @override
  State<CharacterCardListview> createState() => _CharacterCardListviewState();
}

class _CharacterCardListviewState extends State<CharacterCardListview> {
  final _scrollController = ScrollController(); //kaydirma kontrolcusu
  bool _isLoading = true;
  List<int> _favoritedList = [];

  @override
  void initState() {
    //ilk acilinca cagirilan fonks.
    _getFavorites();
    _detectScrollBottom();
    super.initState();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    setState(() {});
  }

  void _getFavorites() async {
    _favoritedList = locator<PreferencesService>().getSavedCharacters();
    _setLoading(false);
    setState(() {});
  }

  void _detectScrollBottom() {
    _scrollController.addListener(() {
      //kaydirdikca dinleyecek
      final maxScroll = _scrollController
          .position
          .maxScrollExtent; //en fazla kayilabilen alan
      final currentPosition =
          _scrollController.position.pixels; //su anki pozisyon
      const int delta = 200;

      if (maxScroll - currentPosition <= delta) {
        //en alta 200 pikselden fazla yaklastiysam
        print('alta inildi');
        widget.onLoadMore(); //disariya fonksiyon aktardik burasi calisinca
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_isLoading){
      return const CircularProgressIndicator.adaptive();
    }
    else{
      return Flexible(
        child: ListView.builder(
          itemCount: widget.characters.length,
          controller: _scrollController,
          itemBuilder: (context, index) {
            final characterModel =
            widget.characters[index]; //burada indexini aldik
            final bool isFavorited = _favoritedList.contains(characterModel.id);
            return Column(
              children: [
                CharacterCardView(characterModel: characterModel, isFavorited: isFavorited),

                //loading
                if (widget.loadMore == true &&
                    index == widget.characters.length - 1)
                  const CircularProgressIndicator.adaptive(),
              ],
            );
          },
        ),
      );
    }

  }
}
