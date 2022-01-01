import 'package:flutter/material.dart';
import 'package:flutter_api/api/api_settings.dart';
import 'package:flutter_api/get/images_getx_controller.dart';
import 'package:flutter_api/utils/helpers.dart';
import 'package:get/get.dart';

class ImagesScreen extends StatefulWidget {
  const ImagesScreen({Key? key}) : super(key: key);

  @override
  _ImagesScreenState createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> with Helpers {
  ImagesGetxController controller = Get.put(ImagesGetxController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Images'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, '/upload_image_screen'),
            icon: Icon(Icons.cloud_upload_outlined),
          ),
        ],
      ),
      body: GetX<ImagesGetxController>(
        builder: (controller) {
          if (controller.images.isNotEmpty) {
            return GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              itemCount: controller.images.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      Image.network(
                        ApiSettings.IMAGES_URL + controller.images[index].image,
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 30,
                          alignment: AlignmentDirectional.centerEnd,
                            color: Colors.white30,
                          child: IconButton(
                            onPressed: () async => await deleteImage(id: controller.images[index].id),
                            icon: Icon(Icons.delete),
                            color: Colors.red.shade800,
                            iconSize: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.warning, size: 80),
                  Text(
                    'No Data',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.grey,
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

  Future<void> deleteImage({required int id}) async {
    bool deleted = await ImagesGetxController.to.delete(context: context, id: id);
    // String message = deleted ? 'Image deleted successfully' : 'Failed to delete image';
    // showSnackBar(context: context, message: message, error: !deleted);
  }
}
