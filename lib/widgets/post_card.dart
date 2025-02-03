import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../models/attachment_models.dart';
import '../models/post.dart';
import '../providers/post_provider.dart';
import 'engagement_metrics.dart';

class PostCard extends ConsumerWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpanded = ref.watch(isExpandedProvider(post.id));

    return Flex(direction: Axis.vertical,
      children: [
        Gap(2),
        Card(
          
          child: Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(8),
              _buildHeader(),
              const SizedBox(height: 8.0),
              _buildContent(context, ref, isExpanded),
              if (post.attachments.isNotEmpty) ...[
                const SizedBox(height: 8.0),
                _buildAttachments(context),
              ],
              
              _buildEngagementMetrics(),
              Gap(8)
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Flex(direction: Axis.horizontal,
      children: [
        Gap(10),
        CircleAvatar(
          backgroundImage: NetworkImage(post.author.avatarUrl ?? ''),
        ),
        Gap(10),
        Expanded(
          child: Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.author.displayName ?? post.author.username,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '@${post.author.username}',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        Text(
          formatTimestamp(post.createdAt),
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        Gap(10),
      ],
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref,bool isExpanded) {
    return Flex(  direction: Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(post.content,overflow: TextOverflow.fade,),
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              post.content,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        if (post.hashtags.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Wrap(
              spacing: 4.0,
              children: post.hashtags
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
          ),
        if (!isExpanded && post.content.length > 250)
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton(
              onPressed: () {
                ref.read(isExpandedProvider(post.id).notifier).toggle();
              },
              child: const Text('Show More'),
            ),
          ),
      ],
    );
  }

Widget _buildAttachments(BuildContext context) {
  return Column(
    children: post.attachments.map((attachment) {
      switch (attachment.type) {
        case 'image':
          return _buildImageAttachment(context, attachment as AttachmentImage);
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


Widget _buildImageAttachment(BuildContext context, AttachmentImage attachment) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: GestureDetector(
      onTap: () {
        showDialog(
          context: context, // Use the passed context
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
                    onPressed: () => Navigator.pop(context),
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
          // Handle video tap
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
                    formatDuration(attachment.duration!),
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
          // Handle link tap
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
          // Handle book tap
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
          // Handle location tap
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
      likes: post.likes,
      dislikes: post.dislikes,
      commentsCount: post.commentsCount,
      sharesCount: post.sharesCount,
      repostsCount: post.repostsCount,
      quotesCount: post.quotesCount,
    );
  }




}
