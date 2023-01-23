import 'package:flutter/material.dart';
import 'package:pa_market_client/logic/farms.dart';
import 'package:pa_market_client/pages/view_farm.dart';

class MySearchDelegate extends SearchDelegate{
  int indexValue = 0;
  final List _list = Farms.getSearchFarms();

  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear)
    )
  ];

  @override
  Widget? buildLeading(BuildContext context) =>IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back)
  );

  @override
  Widget buildResults(BuildContext context) => _list.isNotEmpty ? ListTile(
    leading: Image.network(_list[indexValue].image),
    title: Text(_list[indexValue].name),
    subtitle: Text('[ ${_list[indexValue].produce} ]'),
    onTap: () {
      //go the view coupon page
      Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewFarm(farm: _list[indexValue])));
    },
  ) : ListTile(title: Center(child: Text('Could not find $query')),) ;

  @override
  Widget buildSuggestions(BuildContext context) {
    List suggestions = _list.where((item) {
      final itemNameComparison = item.name.toLowerCase();
      final input = query.toLowerCase();
      return itemNameComparison.contains(input);
    }).toList();

    return ListView.builder(
      itemBuilder: (context, index) {
        if (suggestions.isEmpty){
          return Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              Text('Data not currently available please wait')
            ],
          ),);
        }else{
          return ListTile(
            leading: Image.network(suggestions[index].image),
            title: Text(suggestions[index].name),
            subtitle: Text('[ ${_list[indexValue].produce} ]'),
            onTap: () {
              query = suggestions[index].name;
              indexValue = index;
              showResults(context);
            },
          );
        }
      },
      itemCount: suggestions.length,
    );
  }

}