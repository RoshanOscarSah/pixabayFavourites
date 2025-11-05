import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_widget/connectivity_widget.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/search_page.dart';
import 'presentation/theme/app_theme.dart';
import 'presentation/providers/favorites_provider.dart';
import 'core/injection/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InjectionContainer.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <ChangeNotifierProvider<dynamic>>[
        ChangeNotifierProvider<FavoritesProvider>.value(
          value: InjectionContainer.favoritesProvider,
        ),
      ],
      child: AppTheme.isIOS
          ? CupertinoApp(
              title: 'Pixabay Favorites',
              theme: AppTheme.getCupertinoTheme(),
              home: ConnectivityWidget(
                builder: (BuildContext context, bool isOnline) {
                  return const HomePage();
                },
              ),
              routes: <String, WidgetBuilder>{
                '/search': (_) => ConnectivityWidget(
                  builder: (BuildContext context, bool isOnline) {
                    return SearchPage(
                      searchImagesUseCase:
                          InjectionContainer.searchImagesUseCase,
                    );
                  },
                ),
              },
            )
          : MaterialApp(
              title: 'Pixabay Favorites',
              theme: AppTheme.getMaterialTheme(),
              home: ConnectivityWidget(
                builder: (BuildContext context, bool isOnline) {
                  return const HomePage();
                },
              ),
              routes: <String, WidgetBuilder>{
                '/search': (_) => ConnectivityWidget(
                  builder: (BuildContext context, bool isOnline) {
                    return SearchPage(
                      searchImagesUseCase:
                          InjectionContainer.searchImagesUseCase,
                    );
                  },
                ),
              },
            ),
    );
  }
}
