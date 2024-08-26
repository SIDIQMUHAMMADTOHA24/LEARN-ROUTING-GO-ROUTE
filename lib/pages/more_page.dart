import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:routing/models/data_model.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        child: Container(
          height: 200,
          color: Colors.amber,
        ),
      ),
      appBar: AppBar(
        title: const Text('Home'),
        leading: const SizedBox(),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
            // Scaffold.of(context).openDrawer();
            // context.go('/home/detail-event');
          },
          child: const Text('Go to Detail Event'),
        ),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: const Center(child: Text('Search Page')),
    );
  }
}

class PersonPage extends StatelessWidget {
  PersonPage({super.key});

  final List<DataModel> dataModel = [
    DataModel(id: 1, name: 'Toha'),
    DataModel(id: 2, name: 'Siti'),
    DataModel(id: 3, name: 'Anjay'),
    DataModel(id: 4, name: 'RIZKI'),
    DataModel(id: 5, name: 'roni'),
    DataModel(id: 6, name: 'Tono')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Person')),
      body: ListView.builder(
        itemCount: dataModel.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              context.go(
                '/home/more/$index',
                extra: dataModel[index],
              );
            },
            title: Text(dataModel[index].name),
          );
        },
      ),
    );
  }
}

//MORE PAGE
class DetailEventPage extends StatelessWidget {
  const DetailEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                context.go('/home');
              },
              icon: const Icon(Icons.arrow_back)),
          title: const Text('Person')),
      body: const Center(child: Text('Person Page')),
    );
  }
}

class MorePage extends StatelessWidget {
  const MorePage({super.key, required this.dataModel});

  final DataModel dataModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('More ${dataModel.id}'),
        leading: IconButton(
            onPressed: () {
              context.go('/person');
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Center(child: Text('More ${dataModel.name}')),
    );
  }
}
