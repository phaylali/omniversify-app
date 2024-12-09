import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/models/models.dart';
import 'engagement_metrics.dart';
import 'aura_meter.dart';
import '../../../../shared/widgets/responsive_card_wrapper.dart';

class PostCard extends StatefulWidget {
  final Post post;
  final bool isEmbedded;

  const PostCard({
    super.key,
    required this.post,
    this.isEmbedded = false,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  final GlobalKey _contentKey = GlobalKey();
  double _contentHeight = 100.0; // Default height

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _measureContentHeight();
    });
  }

  void _measureContentHeight() {
    final RenderBox? renderBox =
        _contentKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      setState(() {
        _contentHeight = renderBox.size.height;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveCardWrapper(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: widget.isEmbedded ? 4 : 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildHeader()),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, color: Colors.grey),
                  onSelected: (value) {
                    switch (value) {
                      case 'report':
                        // TODO: Implement report functionality
                        break;
                      case 'unfollow':
                        // TODO: Implement unfollow functionality
                        break;
                      case 'block':
                        // TODO: Implement block functionality
                        break;
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'report',
                      child: Text('Report'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'unfollow',
                      child: Text('Unfollow'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'block',
                      child: Text('Block'),
                    ),
                  ],
                ),
              ],
            ),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Column(
                      key: _contentKey,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildContent(),
                        if (widget.post.attachments.isNotEmpty)
                          _buildAttachments(),
                        if (!widget.isEmbedded) _buildEngagementMetrics(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: _contentHeight,
                    child: _buildAuraMeter(),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: widget.post.author.avatarUrl != null
                ? NetworkImage(widget.post.author.avatarUrl!)
                : null,
            child: widget.post.author.avatarUrl == null
                ? Text(widget.post.author.username[0].toUpperCase())
                : null,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.post.author.displayName ?? widget.post.author.username,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '@${widget.post.author.username}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Text(
            _formatTimestamp(widget.post.createdAt),
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 4.0, 8.0, 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.post.content),
          if (widget.post.hashtags.isNotEmpty) ...[
            const SizedBox(height: 4),
            Wrap(
              spacing: 4.0,
              children: widget.post.hashtags
                  .map((tag) => Text(
                        '#$tag',
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAttachments() {
    return Column(
      children: widget.post.attachments.map((attachment) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => Dialog.fullscreen(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Image with black background
                      Container(
                        color: Colors.black,
                        child: InteractiveViewer(
                          child: Image.network(
                            attachment,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      // Close button
                      Positioned(
                        top: 16,
                        right: 16,
                        child: IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () => context.pop(),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                attachment,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildEngagementMetrics() {
    return EngagementMetrics(
      likes: widget.post.likes,
      dislikes: widget.post.dislikes,
      commentsCount: widget.post.commentsCount,
      sharesCount: widget.post.sharesCount,
      repostsCount: widget.post.repostsCount,
      quotesCount: widget.post.quotesCount,
    );
  }

  Widget _buildAuraMeter() {
    return AuraMeter(
      likes: widget.post.likes,
      dislikes: widget.post.dislikes,
      //` height: 60.0, // Add a fixed height
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'now';
    }
  }
}
