import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:routing/bloc/tools_bloc/tools_bloc.dart';
import 'package:routing/models/data_model.dart';
import 'package:routing/pages/more_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ToolsBloc(),
        ),
      ],
      child: MaterialApp.router(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: _router,
      ),
    );
  }

  // Define the router configuration
  GoRouter get _router => GoRouter(
        initialLocation: '/home',
        debugLogDiagnostics: true,
        routes: [
          ShellRoute(
            builder: (context, state, child) {
              return MainPage(child: child);
            },
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => HomePage(),
              ),
              GoRoute(
                path: '/search',
                builder: (context, state) => const SearchPage(),
              ),
              GoRoute(
                path: '/person',
                builder: (context, state) => PersonPage(),
              ),
            ],
          ),
          GoRoute(
            path: '/home/detail-event',
            builder: (context, state) => const DetailEventPage(),
          ),
          GoRoute(
            path: '/home/more/:index',
            builder: (context, state) {
              final dataModel = state.extra as DataModel;
              return MorePage(dataModel: dataModel);
            },
          ),
        ],
      );
}

class MainPage extends StatefulWidget {
  final Widget child;

  const MainPage({super.key, required this.child});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    //AGAR KETIKA DI REFRESH TIDAK BALIK KE INDEX KE 0
    final location =
        GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString();
    context.read<ToolsBloc>().add(ToolsInitialEvent(location: location));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<ToolsBloc>().state,
        onTap: (value) {
          context.read<ToolsBloc>().add(NextPageEvent(value));
          switch (value) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/search');
              break;
            case 2:
              context.go('/person');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Person',
          ),
        ],
      ),
    );
  }
}
