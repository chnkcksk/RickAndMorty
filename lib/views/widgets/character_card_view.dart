import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rickandmorty_2/app/router.dart';
import 'package:rickandmorty_2/models/characters_model.dart';
import 'package:rickandmorty_2/services/preferences_service.dart';
import 'package:rickandmorty_2/views/screens/character_detail_view/character_detail.dart';

import '../../app/locator.dart';

class CharacterCardView extends StatefulWidget {
  final CharacterModel characterModel;
  bool isFavorited;

  CharacterCardView({
    super.key,
    required this.characterModel,
    this.isFavorited = false,
  });

  @override
  State<CharacterCardView> createState() => _CharacterCardViewState();
}

class _CharacterCardViewState extends State<CharacterCardView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRoutes.characterProfile, extra: widget.characterModel);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Row(
                children: [
                  ClipRRect(
                    child: Hero(
                      tag: widget.characterModel.image,
                      child: Image.network(
                        height: 100,
                        widget.characterModel.image,
                      ),
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 17,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.characterModel.name,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Koken",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(widget.characterModel.origin.name),
                        SizedBox(height: 3),
                        Text(
                          "Koken",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          "${widget.characterModel.status} - ${widget.characterModel.type}",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                if (widget.isFavorited == true) {
                  locator<PreferencesService>().removeCharacter(
                    widget.characterModel.id,
                  );
                  widget.isFavorited = false;
                } else {
                  locator<PreferencesService>().saveCharacter(
                    widget.characterModel.id,
                  );
                  widget.isFavorited = true;
                }

                setState(() {});
              },
              icon: Icon(
                widget.isFavorited ? Icons.bookmark : Icons.bookmark_border,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
