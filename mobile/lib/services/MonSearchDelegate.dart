import 'package:flutter/material.dart';
import 'package:mobile/services/FetchUserData.dart';
class MonSearchDelegate extends SearchDelegate{
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: ()  {
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );

  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('Results for: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Suggestions for: $query'),
    );
  }
}
