import 'package:flutter/material.dart';
import 'package:v1douvery/features/admin/screens/Full/screens/adminScreens.dart';
import 'package:vertical_tabs/vertical_tabs.dart';

class WebFullAdminNavRail extends StatelessWidget {
  const WebFullAdminNavRail({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: VerticalTabs(
          tabsWidth: 150,
          direction: TextDirection.ltr,
          contentScrollAxis: Axis.vertical,
          changePageDuration: const Duration(milliseconds: 500),
          backgroundColor: Color(0xff0b347b),
          tabsShadowColor: Colors.black54,
          selectedTabBackgroundColor: const Color(0x1100ff00),
          tabBackgroundColor: const Color(0xff0b347b),
          tabs: const <Tab>[
            Tab(child: Center(child: Text('Flutter')), icon: Icon(Icons.phone)),
          ],
          contents: <Widget>[
            AdminWebScreens(),
          ],
        ),
      ),
    );
  }
}

class Navs extends StatefulWidget {
  const Navs({Key? key}) : super(key: key);

  @override
  State<Navs> createState() => _NavsState();
}

class _NavsState extends State<Navs> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          NavigationRail(
            backgroundColor: Color(0xff0b347b),
            minWidth: 150,
            minExtendedWidth: 250,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            leading: Container(
                child: Row(
              children: [
                Container(
                  child: Text('Douvery'),
                )
              ],
            )),
            labelType: NavigationRailLabelType.selected,
            destinations: <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.bookmark_border,
                        color: Colors.white,
                      ),
                      Text(
                        'Third',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                label: Text(''),
              ),
              NavigationRailDestination(
                icon: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.bookmark_border,
                        color: Colors.white,
                      ),
                      Text(
                        'Third',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                label: Text(''),
              ),
            ],
            useIndicator: true,
            indicatorColor: Colors.red,
          ),

          // This is the main content.
          Expanded(
            child: Center(
              child: Text('selectedIndex: $_selectedIndex'),
            ),
          )
        ],
      ),
    );
  }
}
