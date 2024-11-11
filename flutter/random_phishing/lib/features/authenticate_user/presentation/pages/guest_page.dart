// import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:random_phishing/core/utils/const/const.dart';
import 'package:random_phishing/core/utils/router/router.dart';
import 'package:random_phishing/features/authenticate_user/presentation/blocs/authenticate_user_bloc.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomePageState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        ),
        home: MyHomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class HomePageState extends ChangeNotifier {
  void getNext() {
    notifyListeners();
  }

  void toggleFavorites() {
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  late final AuthenticateUserBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<AuthenticateUserBloc>();
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = FavoritePage();
        break;
      default:
        page = FavoritePage();
        break;
      // throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      List<Map<String, StatelessWidget>> listPermissions =
          PermissionNavigationByRole.role[
              AuthenticateUserState.mapAuthenticateRoleToCode[bloc.state.role]];
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                destinations: [
                  for (var i in listPermissions)
                    NavigationRailDestination(
                        icon: i["icon"] ?? Icon(Icons.holiday_village),
                        label: i["label"] ?? Text("HOliday"))
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  if (value == (listPermissions.length - 1)) {
                    context.pop();
                  }
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
                child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              // child: page,
            )),
          ],
        ),
      );
    });
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<HomePageState>();
    // var pair = appState.current;

    IconData icon;
    if (true) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // BigCard(pair: pair),

          SizedBox(
            height: 10,
          ),
          // ↓ Add this.
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  print('like');
                  appState.toggleFavorites();
                },
                icon: Icon(icon),
                label: Text('like'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  print('button pressed!');
                  appState.getNext();
                },
                child: Text('Next'),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appContext = context.watch<HomePageState>();
    // var fav = appContext.favorites;

    return Column(
        // children: [Text('messages'), for (var x in fav) Text(x.asLowerCase)],
        );
  }
}

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var appState = context.watch<HomePageState>();
//     var pair = appState.current;

//     IconData icon;
//     if (appState.favorites.contains(pair)) {
//       icon = Icons.favorite;
//     } else {
//       icon = Icons.favorite_border;
//     }

//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             BigCard(pair: pair),

//             SizedBox(height: 10,),
//             // ↓ Add this.
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     print('like');
//                     appState.toggleFavorites();
//                   },
//                   icon: Icon(icon),
//                   label: Text('like'),
//                 ),
//                 SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: () {
//                     print('button pressed!');
//                     appState.getNext();
//                   },
//                   child: Text('Next'),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    // required this.pair,
  });

  // final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        // child: Text(
        //   pair.asLowerCase,
        //   style: style,
        //   semanticsLabel: "${pair.first} ${pair.second}",
        // ),
      ),
    );
  }
}
