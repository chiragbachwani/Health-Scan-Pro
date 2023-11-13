import '../../../const/const.dart';

class PostCard extends StatefulWidget {
  final String username;
  final String timeAgo;
  final String postText;
  final String? imageUrl;
  int likes;
  bool isliked;

  PostCard({
    required this.username,
    required this.timeAgo,
    required this.postText,
    this.imageUrl,
    required this.likes,
    required this.isliked,
  });

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
                      onTap: () {
                        setState(() {
                          widget.isliked = !widget.isliked;
                          widget.likes += widget.isliked ? 1 : -1;
                        });
                      },
                      child: Icon(
                        widget.isliked ? Icons.favorite : Icons.favorite_border,
                        color: widget.isliked ? Colors.red : null,
                      ),
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
                Icon(Icons.send), // Option for direct message
              ],
            ),
          ],
        ),
      ),
    );
  }
}
