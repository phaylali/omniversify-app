import 'package:flutter/material.dart';

import '../models/attachment_models.dart';

class AttachmentButton extends StatelessWidget {
  final Attachment attachment;

  const AttachmentButton({
    super.key,
    required this.attachment,
  });


  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;
    String label;

    // Customize appearance based on attachment type
    switch (attachment.type) {
      case 'image':
        icon = Icons.image;
        color = Colors.blue;
        label = 'Image';
        break;
      case 'video':
        icon = Icons.videocam;
        color = Colors.red;
        label = 'Video';
        break;
      case 'book':
        icon = Icons.videocam;
        color = Colors.red;
        label = 'Book';
        break;
      case 'link':
        icon = Icons.link;
        color = Colors.green;
        label = 'Link';
        break;
      case 'gif':
        icon = Icons.gif;
        color = Colors.green;
        label = 'Gif';
        break;
      case 'poll':
        icon = Icons.poll;
        color = Colors.green;
        label = 'Poll';
        break;
      case 'series':
        icon = Icons.tv;
        color = Colors.green;
        label = 'Series';
        break;
      case 'movie':
        icon = Icons.movie;
        color = Colors.green;
        label = 'Movie';
        break;
      case 'location':
        icon = Icons.location_city;
        color = Colors.green;
        label = 'Location';
        break;
      case 'music':
        icon = Icons.music_note;
        color = Colors.green;
        label = 'Music';
        break;
      case 'audio':
        icon = Icons.audio_file;
        color = Colors.green;
        label = 'Audio';
        break;
      case 'game':
        icon = Icons.gamepad;
        color = Colors.green;
        label = 'Game';
        break;
      case 'activity':
        icon = Icons.local_activity;
        color = Colors.green;
        label = 'Activity';
        break;
      // Add more cases for other attachment types
      default:
        icon = Icons.file_open;
        color = Colors.grey;
        label = 'File';
    }

    return ElevatedButton.icon(
      onPressed: () async {
        await attachment.handleAction(context);
      },
      icon: Icon(icon, color: Colors.white),
      label: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
