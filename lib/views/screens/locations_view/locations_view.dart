import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty_2/app/router.dart';
import 'package:rickandmorty_2/models/locations_model.dart';
import 'package:rickandmorty_2/views/screens/locations_view/locations_viewmodel.dart';
import 'package:rickandmorty_2/views/widgets/appbar_widget.dart';
import 'package:rickandmorty_2/views/widgets/character_card_listview.dart';

class LocationsView extends StatefulWidget {
  const LocationsView({super.key});

  @override
  State<LocationsView> createState() => _LocationsViewState();
}

class _LocationsViewState extends State<LocationsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LocationsViewmodel>().getLocations();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBarWidget(title: "Konumlar", transparentBackground: true),
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
              SizedBox(height: 84),

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Consumer<LocationsViewmodel>(
                        builder: (context, viewModel, child) {
                          if (viewModel.locationsMainModel == null) {
                            return const CircularProgressIndicator.adaptive();
                          } else {
                            return Expanded(
                              child: ListView.separated(
                                padding: EdgeInsets.zero,
                                itemCount: viewModel
                                    .locationsMainModel!
                                    .locations
                                    .length,
                                itemBuilder: (context, index) {
                                  final LocationModel currentLocation =
                                      viewModel
                                          .locationsMainModel!
                                          .locations[index];
                                  return ListTile(
                                    onTap: () {
                                      context.push(AppRoutes.residents, extra: currentLocation);
                                    },
                                    leading: const Icon(
                                      Icons.location_on,
                                      size: 36,
                                    ),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios,
                                    ),
                                    title: Text(
                                      currentLocation.name,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    subtitle: Text(
                                      '${currentLocation.type} - ${currentLocation.dimension}',
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) => Divider(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  indent: 30,
                                  endIndent: 30,
                                  height: 0,
                                ),
                              ),
                            );
                          }
                        },
                      ),
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
}
