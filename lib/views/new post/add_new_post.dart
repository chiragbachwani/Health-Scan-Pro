import 'dart:io';

import 'package:healthscanpro/controller/post_controller.dart';
import 'package:healthscanpro/views/home_screen/home.dart';
import 'package:healthscanpro/views/home_screen/home_screen.dart';

import '../../const/const.dart';

class AddPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PostController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('New Post'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: context.screenHeight - 80,
          width: context.screenWidth,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: controller.postTextController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Add text here...',
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Obx(
                      () => Visibility(
                        visible: controller.imageUploaded.value,
                        child: Container(
                          height: 250,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          width: context.screenWidth,
                          child:
                              Image.file(File(controller.profileImgPath.value)),
                        ),
                      ),
                    ),
                    HeightBox(16),
                    ElevatedButton(
                      onPressed: () {
                        controller
                            .selectImage(context)
                            .then({controller.imageUploaded.value = true});
                      },
                      child: Text('Upload Image(Optional)'),
                    ),
                    SizedBox(height: 16.0),
                  ],
                ),
              ),
              Spacer(),
              Obx(
                () => SizedBox(
                    width: context.screenWidth,
                    height: 60,
                    child: !controller.isloading.value
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.cyan,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0))),
                            onPressed: () async {
                              controller.isloading(true);
                              await controller.uplaodProfileImage();
                              await controller.storePostData(
                                  text: controller.postTextController.text,
                                  imageurl: controller.profileImagelink);
                              controller.imageUploaded.value = false;

                              Get.to(() => Home());
                            },
                            child: Text(
                              'Post',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 18),
                            ),
                          )
                        : Center(
                            child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.cyan)))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
