import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:network_1/characters.dart';

// https://rickandmortyapi.com/api/character

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manual Serialization',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<CharactersList?>? charactersList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    charactersList = getCharactersList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manual Serialization'),
        centerTitle: true,
      ),
      body: FutureBuilder<CharactersList?>(
        future: charactersList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('${snapshot.data?.results?[index]?.name}'),
                      subtitle:
                          Text('${snapshot.data?.results?[index]?.status}'),
                      leading: Image.network(
                        '${snapshot.data?.results?[index]?.image}',
                      ),
                      isThreeLine: true,
                    ),
                  );
                },
                itemCount: snapshot.data?.results?.length);
          } else if (snapshot.hasError) {
            return Text('Error');
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

// Future<http.Response> getData() async {
//   var url = Uri.parse('https://rickandmortyapi.com/api/character');
//   return await http.get(url);
// }

// void loadData() {
//   getData().then((response) {
//     if (response.statusCode == 200) {
//       print(response.body);
//     } else {
//       print(response.statusCode);
//     }
//   }).catchError((error) {
//     debugPrint(error.toString());
//   });
// }
