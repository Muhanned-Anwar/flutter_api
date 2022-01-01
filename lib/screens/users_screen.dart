import 'package:flutter/material.dart';
import 'package:flutter_api/api/controllers/student_api_controller.dart';
import 'package:flutter_api/api/controllers/users_api_controller.dart';
import 'package:flutter_api/models/user.dart';
import 'package:flutter_api/utils/helpers.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> with Helpers {
  List<User> _users = <User>[];
  late Future<List<User>> _future;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = UsersApiController().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        actions: [
          IconButton(onPressed: () async => await logout(), icon: Icon(Icons.logout)),
          IconButton(onPressed: () async => Navigator.pushNamed(context, '/images_screen'), icon: Icon(Icons.image)),
        ],
      ),
      body: FutureBuilder<List<User>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            _users = snapshot.data!;
            return ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                      '${_users[index].firstName} ${_users[index].lastName}'),
                  subtitle: Text(_users[index].email),
                  trailing: Icon(Icons.arrow_forward_ios),
                );
              },
            );
          } else {
            return Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> logout() async {
    bool status = await StudentApiController().logout();
    if (status) {
      Navigator.pushReplacementNamed(context, '/login_screen');
    } else {
      showSnackBar(
          context: context, message: 'Logout failed, try again', error: true);
    }
  }
}
