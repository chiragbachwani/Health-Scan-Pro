import '../../../const/const.dart';

class PostCard extends StatefulWidget {
  final String username;
  final String timeAgo;
  final String postText;
  final String? imageUrl;
  final int likes;
  var icon;
  List likedby;
  var ontap;
  var ontapchat;

  PostCard(
      {required this.username,
      required this.timeAgo,
      required this.postText,
      required this.ontapchat,
      this.imageUrl,
      required this.icon,
      required this.likedby,
      required this.likes,
      required this.ontap});

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  // Replace with actual like count

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.username,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Icon(Icons.more_horiz), // Option for more actions
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              widget.timeAgo,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 8.0),
            Text(
              widget.postText,
            ),
            10.heightBox,
            if (widget.imageUrl != null)
              Center(
                child: SizedBox(
                  height: 200.0, // Adjust the height as needed
                  child: Image.network(
                    widget.imageUrl!,
                    fit: BoxFit.cover,
                  ),
                ).box.roundedLg.make(),
              ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: widget.ontap,
                      child: widget.icon,
                    ),
                    SizedBox(width: 4.0),
                    Text('${widget.likes}'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.chat_bubble_outline), // Option for comments
                    SizedBox(width: 4.0),
                    Text('15'), // Replace with actual comment count
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: widget.ontapchat,
                ), // Option for direct message
              ],
            ),
          ],
        ),
      ),
    );
  }
}
