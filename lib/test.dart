import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testnovi/style/theme.dart';

void main() {
  runApp(MyApp());
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

class _MyTabBarState extends State<MyTabBar>
    with SingleTickerProviderStateMixin {
  Future _future;
  int tabLength=0;
  var jsonData;
  TabController _tabController;
  bool offStage = false;
  int currentIndex;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);

    _tabController.addListener(_handleTabSelection);
  }
  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {


    }
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
//  @override
//  void initState() {
//
//   parseJson();
//    //_future = loadJson();
//    _tabController = TabController(length: 4, vsync: this);
//    super.initState();
//  }
  Future<String> loadAsset() async{
    return await rootBundle.loadString('assets/data.json');
  }
  Future parseJson() async{
    String data = await loadAsset();
    // print(data);
    jsonData = jsonDecode(data);
    tabLength = jsonData.length;

    return jsonData;
  }
List<Widget> widgets = [
  Center(child: Text('ONE'),),
  Center(child: Text('TWO'),),
  Center(child: Text('THREE'),),
  Center(child: Text('FOUR'),),
];
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'one'),
    Tab(text: 'two'),
    Tab(text: 'three'),
    Tab(text: 'four'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getAppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: TabBar(

              onTap: (tabIndex) {

                setState(() {
                  offStage = !offStage;
                  currentIndex = _tabController.index;
                });
                print('current index'+_tabController.index.toString());
                print('tab index'+tabIndex.toString());
              },
              controller: _tabController,
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
              tabs: <Widget>[
                Column(
                  children: [
                    Text('category'),
                    Offstage(
                        offstage: currentIndex==_tabController.index,
                        child: Text('...'))
                  ],
                ),
                Column(
                  children: [
                    Text('category'),
                    Offstage(
                        offstage: currentIndex==_tabController.index,
                        child: Text('...'))
                  ],
                ),
                Column(
                  children: [
                    Text('category'),
                    Offstage(
                        offstage: currentIndex==_tabController.index,
                        child: Text('...'))
                  ],
                ),
                Column(
                  children: [
                    Text('category'),
                    _tabController.index==currentIndex?Text('...'):Text('')
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                bannerListView(),
                Center(
                  child: Text(
                    'page two',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                ),
                Center(
                  child: Text(
                    'HEIBGETRANKE',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                ),
                Center(
                  child: Text(
                    'MILCHPPODUKE',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bannerListView() {
    return FutureBuilder(
      //  future: _future,
      future: parseJson(),
      builder: (context, snapshot) {
//        var mydata = json.decode(snapshot.data.toString());
//        jsonData = json.decode(snapshot.data.toString());

//        print('data is' + jsonData.toString());

        return ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Offstage(
              offstage: offStage,
              child: Container(
                  height: 100,
                  width: 100,
                  child: Image(
                    image: NetworkImage(
                        'https://i.picsum.photos/id/994/300/300.jpg?hmac=GDm1Mpq1ylmjwx5Dv9u-l1nNEAKFDBQyanBzp7Nl4yg'),
                  )),
            );
          },
          itemCount: snapshot.data == null ? 0 : snapshot.data.length,
        );
      },
    );
  }

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
