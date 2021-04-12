import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

/*
* StatelessWidget -> Immutable, properties can't change. All values are final.
* StatefulWidget -> State that might change during the lifetime of the widget. */
void main() {
  runApp(App());
}

/*region First Step*/
class FirstApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random();

    return MaterialApp(
      title: "Welcome to Flutter",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Welcome to the Jungle"),
        ),
        body: Center(
          // child: Text(wordPair.asPascalCase),
          child: RandomWords(),
        ),
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();

    return Text(wordPair.asPascalCase);
  }
}
/*endregion*/

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Startup Name Generator",
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: RandomWordsList(),
    );
  }
}

class RandomWordsList extends StatefulWidget {
  @override
  _RandomWordsListState createState() => _RandomWordsListState();
}

class _RandomWordsListState extends State<RandomWordsList> {
  final _suggestion = <WordPair>[];
  final _favorited = <WordPair>{};
  final _biggerFont = TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Startup Name Generator"), actions: [
        IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
      ]),
      body: _buildSuggestions(),
    );
  }

  Widget _buildRow(WordPair wordPair) {
    final alreadyFavorited = _favorited.contains(wordPair);

    return ListTile(
      title: Text(
        wordPair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadyFavorited ? Icons.favorite : Icons.favorite_border,
        color: alreadyFavorited ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          // Triggers a call to the build() to update UI
          if (alreadyFavorited) {
            _favorited.remove(wordPair);
          } else {
            _favorited.add(wordPair);
          }
        });
      },
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemBuilder: (context, indexValue) {
        if (indexValue.isOdd) return Divider();

        final index = indexValue ~/ 2;
        print("Index Value $index");
        print("Index $index");
        if (index >= _suggestion.length) {
          print("Generate 10");
          _suggestion.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestion[index]);
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final tiles = _favorited.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}
