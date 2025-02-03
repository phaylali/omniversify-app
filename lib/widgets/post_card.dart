import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/models.dart';
import '../models/attachment_models.dart';
import 'engagement_metrics.dart';


class PostCard extends StatefulWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late double _contentHeight = 0; // Initialize with a default value
  bool _isExpanded = false;
  final double _maxCollapsedHeight = 100.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _measureContentHeight();
    });
  }

  void _measureContentHeight() {
    setState(() {
      _contentHeight = context.size?.height ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 8.0),
            _buildContent(),
            if (widget.post.attachments.isNotEmpty) ...[
              const SizedBox(height: 8.0),
              _buildAttachments(),
            ],
            const SizedBox(height: 8.0),
            _buildEngagementMetrics(),
            const SizedBox(height: 8.0),
            //_buildAuraMeter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(widget.post.author.avatarUrl ?? ''),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.post.author.displayName ?? widget.post.author.username,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '@${widget.post.author.username}',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        Text(
          _formatTimestamp(widget.post.createdAt),
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_contentHeight > _maxCollapsedHeight && !_isExpanded)
          Stack(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: _maxCollapsedHeight,
                ),
                child: Text(
                  widget.post.content,
                  overflow: TextOverflow.fade,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _isExpanded = true;
                    });
                  },
                  child: const Text('Show More'),
                ),
              ),
            ],
          )
        else
          Text(widget.post.content),
        if (widget.post.hashtags.isNotEmpty)
          Wrap(
            spacing: 4.0,
            children: widget.post.hashtags
                .map((tag) => GestureDetector(
                      onTap: () {
                        // Handle hashtag tap
                      },
                      child: Text(
                        '#$tag',
                        style: const TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ))
                .toList(),
          ),
      ],
    );
  }

  Widget _buildAttachments() {
    return Column(
      children: widget.post.attachments.map((attachment) {
        switch (attachment.type) {
          case 'image':
            return _buildImageAttachment(attachment as AttachmentImage);
          case 'video':
            return _buildVideoAttachment(attachment as AttachmentVideo);
          case 'link':
            return _buildLinkAttachment(attachment as AttachmentLink);
          case 'book':
            return _buildBookAttachment(attachment as AttachmentBook);
          case 'location':
            return _buildLocationAttachment(attachment as AttachmentLocation);
          default:
            return const SizedBox.shrink();
        }
      }).toList(),
    );
  }

  Widget _buildImageAttachment(AttachmentImage attachment) {
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
                  Container(
                    color: Colors.black,
                    child: InteractiveViewer(
                      child: Image.network(
                        attachment.url,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                attachment.url,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              if (attachment.caption != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    attachment.caption!,
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoAttachment(AttachmentVideo attachment) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: GestureDetector(
        onTap: () {
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                attachment.thumbnailUrl ?? attachment.url,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const Positioned.fill(
              child: Center(
                child: Icon(
                  Icons.play_circle_outline,
                  color: Colors.white,
                  size: 64,
                ),
              ),
            ),
            if (attachment.duration != null)
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 70),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    _formatDuration(attachment.duration!),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLinkAttachment(AttachmentLink attachment) {
    return Card(
      child: InkWell(
        onTap: () {
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(Icons.link),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  attachment.url,
                  style: const TextStyle(color: Colors.blue),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookAttachment(AttachmentBook attachment) {
    return Card(
      child: InkWell(
        onTap: () {
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              if (attachment.coverUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    attachment.coverUrl!,
                    width: 60,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      attachment.url.split('/').last,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'by ${attachment.author}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    if (attachment.description != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        attachment.description!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationAttachment(AttachmentLocation attachment) {
    return Card(
      child: InkWell(
        onTap: () {
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(Icons.location_on),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      attachment.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    if (attachment.address != null)
                      Text(
                        attachment.address!,
                        style: TextStyle(color: Colors.grey[600]),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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

  // Widget _buildAuraMeter() {
  //   return const AuraMeter();
  // }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds}s';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = duration.inHours > 0 ? '${duration.inHours}:' : '';
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours$minutes:$seconds';
  }
}
