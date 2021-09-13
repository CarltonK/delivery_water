import 'package:algolia/algolia.dart';
import 'package:flutter/material.dart';
import 'package:water_del/models/AlgoliaModel.dart';
import 'package:water_del/provider/Algolia.dart';

class Search extends StatefulWidget {
  const Search({ Key key }) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  AlgoliaAPI algoliaAPI = AlgoliaAPI(); 
  // Algolia algoliaAPI = Application.algolia;
  String _searchText = "";
List<SearchHit> _hitsList = [];
TextEditingController _textFieldController = TextEditingController();

Future<void> _getSearchResult(String query) async {
  var response = await algoliaAPI.search(query);
  var hitsList = (response['hits'] as List).map((json) {
    return SearchHit.fromJson(json);
  }).toList();
  setState(() {
    _hitsList = hitsList;
  });
}
@override
void initState() {
  super.initState();
  _textFieldController.addListener(() {
    if (_searchText != _textFieldController.text) {
      setState(() {
        _searchText = _textFieldController.text;
      });
      _getSearchResult(_searchText);
    }
  });
  _getSearchResult('');
}


@override
Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        title: Text('Algolia & Flutter'),
      ),
      body: Column(
        children: <Widget>[
            Container(
                padding: EdgeInsets.symmetric(horizontal: 1),
                height: 44,
                child: TextField(
                  controller: _textFieldController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter a search term',
                      prefixIcon:
                          Icon(Icons.search, color: Colors.deepPurple),
                      suffixIcon: _searchText.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  _textFieldController.clear();
                                });
                              },
                              icon: Icon(Icons.clear),
                            )
                          : null),
                )),
            Expanded(
                child: _hitsList.isEmpty
                    ? Center(child: Text('No results'))
                    : ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: _hitsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              height: 50,
                              padding: EdgeInsets.all(8),
                              child: Row(children: <Widget>[
                                Container(
                                    width: 50,
                                    child: Image.network(
                                        '${_hitsList[index].image}')),
                                SizedBox(width: 10),
                                Expanded(
                                    child: Text('${_hitsList[index].name}'))
                              ]));
                        }))
          ]));
}

}