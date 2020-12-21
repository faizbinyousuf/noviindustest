import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testnovi/model/category.dart';
import 'package:testnovi/services/api.dart';
import 'package:testnovi/style/theme.dart';
import 'package:testnovi/widgets/bodyWidget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyTabBar(),
    );
  }
}

class MyTabBar extends StatefulWidget {
  @override
  _MyTabBarState createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> with TickerProviderStateMixin {
  List<Data> categoriesData = new List();


  Size _size;

  int currentIndex;


  var newData;

  bool isLoading = true;
  List<Widget> categoryWidget = [];


  @override
  void initState() {
    newData = parseJson();
    super.initState();
  }



  Future parseJson() async {
    String data = await Api.loadAsset();
    categoriesData = dataFromJson(data);

    for (int i = 0; i < categoriesData.length; i++) {
      widgets.add(CustomListView(categoriesData[i]));
      categoryWidget.add(_buildCategory(categoriesData[i].category));
    }

    setState(() {
      isLoading = false;
    });

    return categoriesData;
  }

  _buildCategory(String category) {
    return Text(category);
  }

  List<Widget> widgets = [];

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: categoriesData.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: getAppBar(),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: TabBar(
                      labelColor: Colors.black,
                      isScrollable: true,
                      indicatorColor: Colors.transparent,
                      unselectedLabelColor: AppTheme.tabTextUnselected,
                      unselectedLabelStyle: TextStyle(
                        fontSize: 16,
                        color: AppTheme.tabTextUnselected,
                        fontWeight: FontWeight.w700,
                      ),
                      labelStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      tabs: categoryWidget,
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: widgets,
                    ),
                  ),
                ],
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          child: Container(
            margin: EdgeInsets.only(left: 12.0, right: 12.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      //update the bottom app bar view each time an item is clicked
                      onPressed: () {
                        updateTabSelection(0);
                      },
                      iconSize: 27.0,
                      icon: Icon(
                        Icons.home,
                        color: selectedIndex == 0
                            ? Colors.brown.withOpacity(.7)
                            : Colors.grey.shade400,
                        //darken the icon if it is selected or else give it a different color
                      ),
                    ),
                    Text('Home')
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        updateTabSelection(1);
                      },
                      iconSize: 27.0,
                      icon: Icon(
                        Icons.favorite,
                        color: selectedIndex == 1
                            ? Colors.brown.withOpacity(.7)
                            : Colors.grey.shade400,
                      ),
                    ),
                    Text('Whishlist')
                  ],
                ),
                //to leave space in between the bottom app bar items and below the FAB
                SizedBox(
                  width: 50.0,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        updateTabSelection(2);
                      },
                      iconSize: 27.0,
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: selectedIndex == 2
                            ? Colors.brown.withOpacity(.7)
                            : Colors.grey.shade400,
                      ),
                    ),
                    Text('Invest')
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        updateTabSelection(3);
                      },
                      iconSize: 27.0,
                      icon: Icon(
                        Icons.account_circle,
                        color: selectedIndex == 3
                            ? Colors.brown.withOpacity(.7)
                            : Colors.grey.shade400,
                      ),
                    ),
                    Text("Profile")
                  ],
                ),
              ],
            ),
          ),
          //to add a space between the FAB and BottomAppBar
          shape: CircularNotchedRectangle(),
          //color of the BottomAppBar
          color: Colors.white,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppTheme.floatingActionButtonColor,
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          elevation: 3,
          mini: true,
          onPressed: () {},
        ),
      ),
    );
  }

  void updateTabSelection(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<BottomNavigationBarItem> navBarItems = [
    BottomNavigationBarItem(
      icon: new Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: new Icon(Icons.favorite),
      label: 'Wishlist',
    ),
    BottomNavigationBarItem(
      icon: new Icon(Icons.access_alarm_rounded),
      label: 'Invest',
    ),
    BottomNavigationBarItem(
      icon: new Icon(Icons.account_circle),
      label: 'Profile',
    ),
  ];

  getAppBar() {
    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Icon(
            Icons.shopping_cart_outlined,
            color: Colors.black,
          ),
        )
      ],
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Image.asset(
          'assets/images/logo.png',
          height: 50.0,
          width: 50.0,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}
