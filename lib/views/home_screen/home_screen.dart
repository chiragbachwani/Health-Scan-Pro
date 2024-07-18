import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthscanpro/controller/chats_controller.dart';
import 'package:healthscanpro/views/chat_screen/chat_screen.dart';
import 'package:healthscanpro/views/chat_screen/messaging_screen.dart';
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
  final int likes;
  final List likedby;
  final String imageUrl;
  final String commentId;
  final DateTime datetime;

  Post({
    required this.postId,
    required this.userId,
    required this.likes,
    required this.likedby,
    required this.datetime,
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
      likedby: doc.data()['likedby'] ?? [],
      datetime: (doc.data()['dateTime'] as Timestamp).toDate(),
      postId: doc.data()['post_id'] ?? '',
      userId: doc.data()['user_id'] ?? '',
      text: doc.data()['text'] ?? '',
      likes: doc.data()['Likes'],
      commentId: doc.data()['CommentId'] ?? '',
      imageUrl: doc.data()['image_url'] ?? '',
    ));
  });

  return posts;
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // var chatscontroller = Get.put(ChatsController());
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<Homecontroller>();

    // toggleLike({
    //   data , uid}) {
    //     if()
    //   }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Health Scan Pro",
          style: TextStyle(color: Colors.black54),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.chat),
          )
        ],
      ),
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
            // print(posts[0].postId);
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (BuildContext context, int index) {
                var data = posts[index];

                Future<void> toggleLike(data, String currentUserId) async {
                  final DocumentReference postRef = FirebaseFirestore.instance
                      .collection('Posts')
                      .doc(data.postId);

                  if (data.likedby != null &&
                      data.likedby.contains(currentUserId)) {
                    // User already liked the post, so unlike it
                    await postRef.update({
                      'Likes': FieldValue.increment(-1),
                      'likedby': FieldValue.arrayRemove([currentUserId]),
                    });
                  } else {
                    // User hasn't liked the post, so like it
                    await postRef.update({
                      'Likes': FieldValue.increment(1),
                      'likedby': FieldValue.arrayUnion([currentUserId]),
                    });
                  }
                }

                return StreamBuilder(
                  stream: FirestoreServices.getUser(data.userId),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: "No Posts Yet"
                            .text
                            .color(darkFontGrey)
                            .semiBold
                            .make(),
                      );
                    } else {
                      var Userdata = snapshot.data!.docs[0];

                      // Check if 'name' is not null, otherwise provide a default value
                      String username = Userdata['name'] ?? 'Unknown User';

                      return PostCard(
                        icon: (data.likedby.contains(currentuser!.uid)
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.favorite_border_outlined,
                              )),
                        likedby: data.likedby,
                        ontapchat: () async {
                          if (data.userId == currentuser!.uid) {
                            Get.to(() => MessagingScreen());
                          } else {
                            // chatscontroller.getChatId();
                            // Get.to(() => ChatScreen());
                          }
                        },
                        likes: data.likes,
                        ontap: () async {
                          await toggleLike(data, currentuser!.uid)
                              .then((value) {
                            setState(() {});
                          });
                        },
                        username: username,
                        timeAgo: data.datetime.toString(),
                        postText: data.text,
                        imageUrl: data.imageUrl,
                      );
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
