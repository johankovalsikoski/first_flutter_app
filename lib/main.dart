import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

/*
* StatelessWidget -> Immutable, properties can't change. All values are final.
* StatefulWidget -> State that might change during the lifetime of the widget. */
void main() {
  runApp(RandomWordsList());
}

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

class RandomWordsList extends StatefulWidget {
  @override
  _RandomWordsListState createState() => _RandomWordsListState();
}

class _RandomWordsListState extends State<RandomWordsList> {
  final _suggestion = <WordPair>[];
  final _biggerFont = TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text("Startup Name Generator"),
      ),
      body: _buildSuggestions(),
    ));
  }

  Widget _buildRow(WordPair wordPair) {
    return ListTile(
      title: Text(
        wordPair.asPascalCase,
        style: _biggerFont,
      ),
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
}
