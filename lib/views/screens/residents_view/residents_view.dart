import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty_2/models/locations_model.dart';
import 'package:rickandmorty_2/views/screens/residents_view/residents_viewmodel.dart';
import 'package:rickandmorty_2/views/widgets/appbar_widget.dart';
import 'package:rickandmorty_2/views/widgets/character_card_listview.dart';
import 'package:rickandmorty_2/views/widgets/character_card_view.dart';

import '../../../models/characters_model.dart';

class ResidentsView extends StatefulWidget {
  final LocationModel selectedLocation;

  const ResidentsView({super.key, required this.selectedLocation});

  @override
  State<ResidentsView> createState() => _ResidentsViewState();
}

class _ResidentsViewState extends State<ResidentsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ResidentsViewModel>().getResidentsByUrlList(
        widget.selectedLocation.residents,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: widget.selectedLocation.name),
      body: Padding(
        padding: const EdgeInsets.all(17.0),
        child: Column(
          children: [
            Expanded(
              child: Consumer<ResidentsViewModel>(
                builder: (context, viewModel, child) {
                  if (viewModel.residents == null) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else {
                    return Column(
                      children: [
                        Flexible(
                          child: ListView.builder(
                            itemCount: viewModel.residents!.length,
                            itemBuilder: (context, index) {
                              final CharacterModel selectedCharacter =
                                  viewModel.residents![index];
                              return Column(
                                children: [
                                  CharacterCardView(
                                    characterModel: selectedCharacter,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
