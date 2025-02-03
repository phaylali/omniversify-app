import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../providers/trending_topics_provider.dart';

class TrendingTopicsCard extends ConsumerWidget {
  const TrendingTopicsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trendingTopics = ref.watch(trendingTopicsProvider);
    ref.read(trendingTopicsProvider.notifier).fetchTrendingTopics();
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Flex(
          direction: Axis.vertical,
          children: [
            const Gap(8),
            const Center(
              child: Text(
                'Trending Topics',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Gap(16),
            Flexible(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  direction: Axis.horizontal,
                  children: trendingTopics.map((topic) {
                    return Chip(
                      label: Text(topic),
                      onDeleted: () {
                        ref
                            .read(trendingTopicsProvider.notifier)
                            .removeTopic(topic);
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
