import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testnovi/model/category.dart';
import 'package:testnovi/provider/categoryProvider.dart';
import 'package:testnovi/style/theme.dart';

class CustomListView extends StatelessWidget {

  Data categoryData;
  CustomListView(this.categoryData);
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          color: AppTheme.listViewColor,
          height: 350,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Stack(
                  children: [
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        width: _size.width*.6,
                        height: _size.height*.5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                           categoryData.imageBanner,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 70,
                        child:
                            _buildImageTitleText('Check Our\nLatest Arrival')),
                    Positioned(
                        bottom: 30,
                        child: _buildImageSubTitleText(
                            'Being update with the latest\nproduct from us')),
                  ],
                ),
              );
            },
            itemCount: 4,
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                width: 100,
                child: Column(
                  children: [
                    Image.asset(categoryData.subCategory[index].subcatImage),
                    Text(categoryData.subCategory[index].subcatName)
                  ],
                ),
              );
            },
            itemCount: categoryData.subCategory.length
          ),
        )
      ],
    );
  }
}

_buildImageTitleText(String text) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

_buildImageSubTitleText(String text) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
    ),
  );
}
