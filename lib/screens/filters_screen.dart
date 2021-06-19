import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarion = false;
  var _lactoseFree = false;
  var _vegan = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _vegetarion = widget.currentFilters['vegetarion'];
    _vegan = widget.currentFilters['vegan'];
    _lactoseFree = widget.currentFilters['lactose'];
    super.initState();
  }

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final selectedFilters = {
                  'gluten': _glutenFree,
                  'vegan': _vegan,
                  'lactose': _lactoseFree,
                  'vegetarion': _vegetarion,
                };
                widget.saveFilters(selectedFilters);
              }),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your Meals here!!',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildSwitchListTile(
                  'Gluten-Free', 'Only include Gluten-Free meals', _glutenFree,
                  (newvalue) {
                setState(() {
                  _glutenFree = newvalue;
                });
              }),
              _buildSwitchListTile('Lactose-Free',
                  'Only include Lactose-Free meals', _lactoseFree, (newvalue) {
                setState(() {
                  _lactoseFree = newvalue;
                });
              }),
              _buildSwitchListTile(
                  'Vegetarion', 'Only include Vegetarion meals', _vegetarion,
                  (newvalue) {
                setState(() {
                  _vegetarion = newvalue;
                });
              }),
              _buildSwitchListTile('Vegan', 'Only include Vegan meals', _vegan,
                  (newvalue) {
                setState(() {
                  _vegan = newvalue;
                });
              })
            ],
          ))
        ],
      ),
    );
  }
}
