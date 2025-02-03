import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../models/user_preview.dart';
import '../providers/people_provider.dart';
import 'follow_button.dart';



class PeopleSection extends ConsumerWidget {
  const PeopleSection({super.key});
  @override
  Widget build(BuildContext context, ref) {
    final people = ref.watch(peopleProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'People You May Know',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(4),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: people.length,
            itemBuilder: (context, index) {
              final user = people[index];

              return _UserTile(user: user);
            },
          ),
        ),
      ],
    );
  }
}

class _UserTile extends ConsumerWidget {
  final UserPreview user;

  const _UserTile({
    required this.user,
  });

  @override
  Widget build(BuildContext context, ref) {
    return Card(
      elevation: 0,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: Flex(
              direction: Axis.vertical,
              children: [
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Gap(4),
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(user.avatarUrl),
                    ),
                    Gap(2),
                    Expanded(
                      child: Flex(
                        direction: Axis.vertical,
                        children: [
                          Text(
                            user.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                overflow: TextOverflow.ellipsis),
                          ),
                          Text(
                            '@${user.username}',
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                    ),
                    FollowButton(
                      isFollowing: user.isFollowing,
                      onPressed: () {
                        ref
                            .read(peopleProvider.notifier)
                            .toggleFollow(user.username);
                      },
                    ),
                  ],
                ),
                Gap(2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    user.bio,
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.start,
                  ),
                ),
                Gap(4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
