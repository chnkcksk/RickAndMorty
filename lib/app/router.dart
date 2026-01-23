import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty_2/models/characters_model.dart';
import 'package:rickandmorty_2/models/locations_model.dart';
import 'package:rickandmorty_2/views/app_view.dart';
import 'package:rickandmorty_2/views/screens/characters_view/characters_viewmodel.dart';
import 'package:rickandmorty_2/views/screens/favourites_view/favourites_viewmodel.dart';
import 'package:rickandmorty_2/views/screens/residents_view/residents_view.dart';
import 'package:rickandmorty_2/views/screens/residents_view/residents_viewmodel.dart';

import '../views/screens/character_detail_view/character_detail.dart';
import '../views/screens/character_detail_view/character_detail_viewmodel.dart';
import '../views/screens/characters_view/characters_view.dart';
import '../views/screens/favourites_view/favourites_view.dart';
import '../views/screens/locations_view/locations_view.dart';
import '../views/screens/locations_view/locations_viewmodel.dart';
import '../views/screens/sections_view/sections_view.dart';
import '../views/screens/login_view/login_view.dart';
import '../views/screens/login_view/login_viewmodel.dart';
import '../views/screens/register_view/register_view.dart';
import '../views/screens/register_view/register_viewmodel.dart';
import '../views/screens/otp_view/otp_view.dart';
import '../views/screens/otp_view/otp_viewmodel.dart';

final _routerKey = GlobalKey<NavigatorState>();

class AppRoutes {
  // Auth routes
  static const String login = '/login';
  static const String register = '/register';
  static const String otp = '/otp';

  // Main app routes
  static const String characters = '/';
  static const String favourites = '/favourites';
  static const String locations = '/locations';
  static const String sections = '/sections';

  static const String profileRoute = 'characterProfile';
  static const String characterProfile = '/characterProfile';

  static const String residentsRoute = 'residents';
  static const String residents = '/locations/residents';
}

final router = GoRouter(
  navigatorKey: _routerKey,
  initialLocation: AppRoutes.login,
  routes: [
    // Auth routes (without bottom nav bar)
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => ChangeNotifierProvider(
        create: (context) => LoginViewmodel(),
        child: const LoginView(),
      ),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => ChangeNotifierProvider(
        create: (context) => RegisterViewmodel(),
        child: const RegisterView(),
      ),
    ),
    GoRoute(
      path: AppRoutes.otp,
      builder: (context, state) => ChangeNotifierProvider(
        create: (context) => OtpViewmodel(),
        child: const OtpView(),
      ),
    ),
    // Main app routes (with bottom nav bar)
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppView(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.characters,
              builder: (context, state) => ChangeNotifierProvider(
                create: (context) => CharactersViewmodel(),
                child: const CharactersView(),
              ),
              routes: [
                GoRoute(
                  path: AppRoutes.profileRoute,
                  builder: (context, state) => ChangeNotifierProvider(
                    create: (context) => CharacterDetailViewmodel(),
                    child: CharacterDetailView(
                      characterModel: state.extra as CharacterModel,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.favourites,
              builder: (context, state) => ChangeNotifierProvider(
                create: (context) => FavouritesViewmodel(),
                child: const FavouritesView(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.locations,
              builder: (context, state) => ChangeNotifierProvider(
                create: (context) => LocationsViewmodel(),
                child: const LocationsView(),
              ),
              routes: [
                GoRoute(
                  path: AppRoutes.residentsRoute,
                  builder: (context, state) => ChangeNotifierProvider(
                    create: (context) => ResidentsViewModel(),
                    child: ResidentsView(
                      selectedLocation: state.extra as LocationModel,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.sections,
              builder: (context, state) => const SectionsView(),
            ),
          ],
        ),
      ],
    ),
  ],
);
