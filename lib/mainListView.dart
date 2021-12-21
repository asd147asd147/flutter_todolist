import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; 

class MainListView extends StatefulWidget {
    @override
    _MainListViewState createState() => _MainListViewState();
}

class Item {
    Item({
        required this.expandedValue,
        required this.headerValue,
        this.isExpanded = false,
    });

    String expandedValue;
    String headerValue;
    bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
    return List<Item>.generate(numberOfItems, (int index) {
        return Item(
                headerValue: 'Panel $index',
                expandedValue: 'This is item number $index',
        );
    });
}

class _MainListViewState extends State<MainListView> {
    final List<Item> _data = generateItems(8);

    Widget _buildPanel() {
        return ExpansionPanelList(
                expansionCallback: (int index, bool isExpanded) {
                    setState((){
                        _data[index].isExpanded = !isExpanded;
                    });
                },
                children: _data.map<ExpansionPanel>((Item item) {
                    return ExpansionPanel(
                            headerBuilder: (BuildContext context, bool isExpanded) {
                                return ListTile(
                                        title: Text(item.headerValue),
                                );
                            },
                            body: Dismissible(
                                          background: Container(color : Colors.red,),
                                          direction: DismissDirection.startToEnd,
                                          onDismissed: (direction){
                                              if(direction == DismissDirection.startToEnd){
                                                  setState(() {
                                                      _data.removeWhere((Item currentItem) => item == currentItem);
                                                  });
                                              }
                                          },
                                          child: ListTile(
                                                         title: Text(item.expandedValue),
                                                         subtitle: const Text('To delete this panel'),
                                                 ),
                                          key: Key(UniqueKey().toString()),
                                  ),
                    isExpanded: item.isExpanded,
                    );
                }).toList(),
                );
    }

    @override
    Widget build(BuildContext context) {
        return SingleChildScrollView(
                child: Container(
                        child: _buildPanel(),
                ),
        );
    }
}
