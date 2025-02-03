import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final trendingTopicsProvider =
    StateNotifierProvider<TrendingTopicsNotifier, List<String>>((ref) {
  return TrendingTopicsNotifier();
});

class TrendingTopicsNotifier extends StateNotifier<List<String>> {
  TrendingTopicsNotifier()
      : super([
          '#Flutter',
          '#Dart',
          '#OpenSource',
          '#WebDev',
          '#MobileApps',
        ]);

  // Method to update the list of trending topics
  void updateTopics(List<String> topics) {
    state = topics;
  }

  // Method to add a new topic
  void addTopic(String topic) {
    state = [...state, topic];
  }

  // Method to remove a topic
  void removeTopic(String topic) {
    state = state.where((t) => t != topic).toList();
  }

  Future<void> fetchTrendingTopics() async {
    try {
      final response = await http
          .get(Uri.parse('https://dummy-json.mock.beeceptor.com/countries'));
      if (response.statusCode == 200) {
        final fixedResponse = response.body
            .replaceAll("'", '"') // Replace single quotes with double quotes
            .replaceAllMapped(RegExp(r'(\w+):'), (match) => '"${match.group(1)}":');
        final List<dynamic> data = jsonDecode(fixedResponse);
        final List<String> topics =
            data.map((country) => country['name'] as String).toList();

        state = topics;
      } else {
        debugPrint('Failed to fetch trending topics: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Failed to fetch trending topics: $e');
    }
  }
}
