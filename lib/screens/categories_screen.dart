import 'package:flutter/material.dart';
import 'package:flutter_api/api/controllers/categories_api_controller.dart';
import 'package:flutter_api/models/category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Category> _categories = <Category>[];
  late Future<List<Category>> _future;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = CategoriesApiController().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categories')),
      body: FutureBuilder<List<Category>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            _categories = snapshot.data!;
            return ListView.builder(
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.category),
                  title: Text(_categories[index].title),
                  subtitle: Text(_categories[index].productsCount.toString()),
                );
              },
            );
          } else {
            return Column(
              children: [
                Icon(Icons.warning, size: 80),
                Text(
                  'No Data',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
