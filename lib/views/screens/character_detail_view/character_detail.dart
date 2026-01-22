import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty_2/models/characters_model.dart';
import 'package:rickandmorty_2/models/episodes_model.dart';
import 'package:rickandmorty_2/views/screens/character_detail_view/character_detail_viewmodel.dart';
import 'package:rickandmorty_2/views/widgets/appbar_widget.dart';

class CharacterDetailView extends StatefulWidget {
  final CharacterModel? characterModel;

  const CharacterDetailView({super.key, this.characterModel});

  @override
  State<CharacterDetailView> createState() => _CharacterDetailViewState();
}

class _CharacterDetailViewState extends State<CharacterDetailView> {
  @override
  void initState() {
    super.initState();
    context.read<CharacterDetailViewmodel>().getEpisodes(
      widget.characterModel!.episode,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBarWidget(title: "Karakter", transparentBackground: true),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg-image.png'),
              alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _characterAvatar(context),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme
                        .of(context)
                        .colorScheme
                        .surface,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 13),
                      Text(
                        widget.characterModel!.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 17),
                      _labelsView(context),
                      SizedBox(height: 38),
                      _episodesText(),
                      SizedBox(height: 15),
                      _episodesListView()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Consumer<CharacterDetailViewmodel> _episodesListView() {
    return Consumer<CharacterDetailViewmodel>(
                      builder: (context, viewModel, child) {
                        return Expanded(
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            //shrinkWrap: true,
                            itemCount: viewModel.episodes.length,
                            itemBuilder: (context, index) {
                              final EpisodeModel currentEpisode =
                              viewModel.episodes[index];
                              return ListTile(
                                leading: const Icon(Icons.face_retouching_natural, size: 36),
                                trailing: const Icon(Icons.arrow_forward_ios),
                                title: Text(currentEpisode.episode,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle:  Text(currentEpisode.name),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                Divider(
                                  color: Theme
                                      .of(context)
                                      .colorScheme
                                      .tertiary,
                                  indent: 30,
                                  endIndent: 30,
                                  height: 0,
                                ),
                          ),
                        );
                      },);
  }

  Container _episodesText() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Text(
        'Bolumler (${widget.characterModel!.episode.length})',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }

  Padding _labelsView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45),
      child: Wrap(
        runSpacing: 14,
        spacing: 7,
        alignment: WrapAlignment.center,
        children: [
          _labelWidget(context, label: widget.characterModel!.status),
          _labelWidget(context, label: widget.characterModel!.origin.name),
          _labelWidget(context, label: widget.characterModel!.gender),
          _labelWidget(context, label: widget.characterModel!.status),
        ],
      ),
    );
  }

  Container _labelWidget(BuildContext context, {required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: Text(
        label,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
      //margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 14),
      decoration: BoxDecoration(
        color: Theme
            .of(context)
            .colorScheme
            .secondary,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Padding _characterAvatar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 90, bottom: 52),
      child: CircleAvatar(
        radius: 100,
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .primary,
        child: CircleAvatar(
          radius: 98,
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .surface,
          child: Hero(
            tag: widget.characterModel!.image,
            child: CircleAvatar(
              backgroundImage: NetworkImage(widget.characterModel!.image),
              radius: 95,
            ),
          ),
        ),
      ),
    );
  }
}
