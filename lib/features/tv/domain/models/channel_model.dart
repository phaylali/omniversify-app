import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class Channel {
  final String? tvgId;
  final String? tvgLogo;
  final String? groupTitle;
  final String name;
  final String link;
  final bool enabled;

  Channel({
    this.tvgId,
    this.tvgLogo,
    this.groupTitle,
    required this.name,
    required this.link,
    this.enabled = true,
  });

  Map<String, dynamic> toJson() {
    return {
      'tvg-id': tvgId,
      'tvg-logo': tvgLogo,
      'group-title': groupTitle,
      'name': name,
      'link': link,
      'enabled': enabled,
    };
  }

  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      tvgId: json['tvg-id'],
      tvgLogo: json['tvg-logo'],
      groupTitle: json['group-title'],
      name: json['name'],
      link: json['link'],
      enabled: json['enabled'] ?? true,
    );
  }

  Channel copyWith({
    String? tvgId,
    String? tvgLogo,
    String? groupTitle,
    String? name,
    String? link,
    bool? enabled,
  }) {
    return Channel(
      tvgId: tvgId ?? this.tvgId,
      tvgLogo: tvgLogo ?? this.tvgLogo,
      groupTitle: groupTitle ?? this.groupTitle,
      name: name ?? this.name,
      link: link ?? this.link,
      enabled: enabled ?? this.enabled,
    );
  }

  factory Channel.fromM3ULine(String extinf, String link) {
    // Parse tvg-id
    final tvgIdMatch = RegExp(r'tvg-id="([^"]*)"').firstMatch(extinf);
    final tvgId = tvgIdMatch?.group(1);

    // Parse tvg-logo
    final tvgLogoMatch = RegExp(r'tvg-logo="([^"]*)"').firstMatch(extinf);
    final tvgLogo = tvgLogoMatch?.group(1);

    // Parse group-title
    final groupTitleMatch = RegExp(r'group-title="([^"]*)"').firstMatch(extinf);
    final groupTitle = groupTitleMatch?.group(1);

    // Parse channel name (everything after the last comma)
    final nameMatch = RegExp(r',[^,]*$').firstMatch(extinf);
    final name = nameMatch != null
        ? nameMatch.group(0)!.substring(1).trim()
        : 'Unknown Channel';

    return Channel(
      tvgId: tvgId,
      tvgLogo: tvgLogo,
      groupTitle: groupTitle,
      name: name,
      link: link.trim(),
      enabled: true, // Default to enabled
    );
  }

  static Future<void> deleteAllChannels() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/channels.json');
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      debugPrint('Error deleting channels file: $e');
      rethrow;
    }
  }
}
