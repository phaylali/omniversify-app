import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AttachmentType {
  images,
  videos,
  books,
  links,
  gifs,
  polls,
  series,
  movies,
  locations,
  music,
  audio,
  games,
  activities, 
}

class TabCategory {
  final String name;
final String? attachmentType;
  TabCategory(this.name, {this.attachmentType});
}

final tabsProvider = Provider<List<TabCategory>>((ref) {
  return [
    TabCategory('Feed'),
    TabCategory('Images', attachmentType: 'image'),
    TabCategory('Videos', attachmentType: 'video'),
    TabCategory('Books', attachmentType: 'book'),
    TabCategory('Links', attachmentType: 'link'),
    TabCategory('GIFs', attachmentType: 'gif'),
    TabCategory('Polls', attachmentType: 'poll'),
    TabCategory('Series', attachmentType: 'series'),
    TabCategory('Movies', attachmentType: 'movie'),
    TabCategory('Locations', attachmentType: 'location'),
    TabCategory('Music', attachmentType: 'music'),
    TabCategory('Audio', attachmentType: 'audio'),
    TabCategory('Games', attachmentType: 'game'),
    TabCategory('Activities', attachmentType: 'activity'),
  ];
});

final selectedTabProvider = StateProvider<int>((ref) => 0);

