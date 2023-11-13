import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthscanpro/views/home_screen/search_screen.dart';

import '../../const/const.dart';
import '../../const/lists.dart';
import '../../controller/home_controller.dart';
import '../../services/firestore_sevices.dart';
import '../../widgets_common/home_buttons.dart';
import 'components/featured_button.dart';
import 'components/postcard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<Homecontroller>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.cyan,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.cyan[100],
      body: ListView(
        children: [
          PostCard(
            username: 'JohnDoe',
            timeAgo: '2 hours ago',
            postText: 'Just finished a great workout at the gym! 💪 #Fitness',
            imageUrl:
                'https://images.indianexpress.com/2023/04/fitness-future.jpg',
            likes: 55,
            isliked: false, // Replace with actual image URL
          ),
          PostCard(
            username: 'HealthyEater',
            timeAgo: '1 day ago',
            postText:
                'Enjoying a delicious and nutritious salad for lunch. #HealthyEating',
            imageUrl: 'https://blog.flock.com/hubfs/028.jpg',
            likes: 90,
            isliked: true, // Replace with actual image URL
          ),
          // Add more PostCards as needed
        ],
      ),
    );
    // return Container(
    //   padding: const EdgeInsets.all(12),
    //   color: skyblue,
    //   width: context.screenWidth,
    //   height: context.screenHeight,
    //   child: SafeArea(
    //       child: Column(
    //     children: [
    //       Container(
    //         alignment: Alignment.center,
    //         height: 60,
    //         color: skyblue,
    //         child: TextFormField(
    //           controller: controller.searchController,
    //           cursorColor: turquoiseColor,
    //           decoration: InputDecoration(
    //               contentPadding: const EdgeInsets.symmetric(
    //                   vertical: 1.0, horizontal: 20.0),
    //               border: OutlineInputBorder(
    //                 borderSide: BorderSide.none,
    //                 borderRadius: BorderRadius.circular(25),
    //               ),
    //               suffixIcon: Image.asset("assets/images/search.gif",
    //                       width: 10, height: 20)
    //                   .onTap(() {
    //                     if (controller
    //                         .searchController.text.isNotEmptyAndNotNull) {
    //                       Get.to(() => SearchScreen(
    //                           title: controller.searchController.text));
    //                     }
    //                   })
    //                   .box
    //                   .roundedFull
    //                   .make(),
    //               filled: true,
    //               fillColor: whiteColor,
    //               hintText: search,
    //               hintStyle: const TextStyle(color: Vx.gray500)),
    //         ),
    //       ),
    // 10.heightBox,
    // Expanded(
    //   child: SingleChildScrollView(
    //     physics: const BouncingScrollPhysics(),
    //     child: ListView(
    //       children: [
    //         PostCard(
    //           username: 'JohnDoe',
    //           timeAgo: '2 hours ago',
    //           postText:
    //               'Just finished a great workout at the gym! 💪 #Fitness',
    //           imageUrl:
    //               'https://blog.flock.com/hubfs/028.jpg', // Replace with actual image URL
    //         ),
    //         PostCard(
    //           username: 'HealthyEater',
    //           timeAgo: '1 day ago',
    //           postText:
    //               'Enjoying a delicious and nutritious salad for lunch. #HealthyEating',
    //           imageUrl:
    //               'https://blog.flock.com/hubfs/028.jpg', // Replace with actual image URL
    //         ),
    //         // Add more PostCards as needed
    //       ],
    //     ),
    //   ),
    // )
    //     ],
    //   )),
    // );
  }
}
