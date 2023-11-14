import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthscanpro/views/home_screen/search_screen.dart';
import 'package:healthscanpro/views/new%20post/add_new_post.dart';

import '../../const/const.dart';
import '../../const/lists.dart';
import '../../controller/home_controller.dart';
import '../../services/firestore_sevices.dart';
import '../../widgets_common/home_buttons.dart';
import 'components/featured_button.dart';
import 'components/postcard.dart';

class Post {
  final String postId;
  final String userId;
  final String text;
  final String imageUrl;
  final String likes;
  final String commentId;
  final DateTime datetime;

  Post({
    required this.postId,
    required this.userId,
    required this.datetime,
    required this.likes,
    required this.text,
    required this.imageUrl,
    required this.commentId,
  });
}

Future<List<Post>> fetchPosts() async {
  QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('Posts').get();

  List<Post> posts = [];

  querySnapshot.docs.forEach((doc) {
    posts.add(Post(
      datetime: (doc.data()['dateTime'] as Timestamp).toDate(),
      postId: doc.data()['post_id'] ?? '',
      userId: doc.data()['user_id'] ?? '',
      text: doc.data()['text'] ?? '',
      likes: doc.data()['Likes'].toString(),
      commentId: doc.data()['CommentId'] ?? '',
      imageUrl: doc.data()['image_url'] ?? '',
    ));
  });

  return posts;
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<Homecontroller>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get..to(() => AddPostScreen());
          ;
        },
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
      body: FutureBuilder(
        future: fetchPosts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Loading indicator while fetching data
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Post> posts = snapshot.data ?? [];
            print(posts[0].postId);
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (BuildContext context, int index) {
                var data = posts[index];
                return PostCard(
                  likes: 40,
                  isliked: true,
                  username: 'JohnDoe',
                  timeAgo: data.datetime.toString(),
                  postText: data.text,
                  imageUrl: data.imageUrl, // Replace with actual image URL
                );
              },
            );
          }
        },
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
