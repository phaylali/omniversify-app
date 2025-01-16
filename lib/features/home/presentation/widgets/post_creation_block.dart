import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../shared/widgets/responsive_card_wrapper.dart';

class PostCreationBlock extends ConsumerStatefulWidget {
  const PostCreationBlock({Key? key}) : super(key: key);

  @override
  ConsumerState<PostCreationBlock> createState() => _PostCreationBlockState();
}

class _PostCreationBlockState extends ConsumerState<PostCreationBlock> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isExpanded = false;
  final ScrollController _scrollController = ScrollController();
  double _dragStartX = 0;
  double _scrollStartPosition = 0;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    _textController.addListener(_onTextChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _textController.removeListener(_onTextChange);
    _focusNode.dispose();
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus && _textController.text.isEmpty) {
      setState(() => _isExpanded = false);
    }
  }

  void _onTextChange() {
    if (_textController.text.isNotEmpty && !_isExpanded) {
      setState(() => _isExpanded = true);
    }
  }

  Widget _buildAttachmentButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Tooltip(
      message: label,
      child: IconButton(
        onPressed: onTap,
        icon: Icon(icon, size: 20),
        style: IconButton.styleFrom(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          padding: const EdgeInsets.all(12),
        ),
      ),
    );
  }

  Widget _buildPostButton({
    required BuildContext context,
    required String label,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Tooltip(
        message: label,
        child: IconButton(
          onPressed: _textController.text.isEmpty ? null : () {
            // Handle post creation
            _textController.clear();
            setState(() => _isExpanded = false);
          },
          icon: const Icon(Icons.send, size: 20),
          style: IconButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(12),
            disabledBackgroundColor: Theme.of(context).disabledColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizer = ref.read(localizationProvider.notifier);
    final screenHeight = MediaQuery.of(context).size.height;

    return ResponsiveCardWrapper(
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 80,
                  maxHeight: screenHeight * 0.5,
                ),
                child: TextField(
                  controller: _textController,
                  focusNode: _focusNode,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: localizer.translate(context, 'whats_on_your_mind'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: _isExpanded ? null : 0,
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onPanStart: (details) {
                              _dragStartX = details.localPosition.dx;
                              _scrollStartPosition = _scrollController.offset;
                            },
                            onPanUpdate: (details) {
                              final dx = details.localPosition.dx - _dragStartX;
                              final newOffset = _scrollStartPosition - dx;
                              _scrollController.jumpTo(
                                newOffset.clamp(
                                  0,
                                  _scrollController.position.maxScrollExtent,
                                ),
                              );
                            },
                            child: SizedBox(
                              height: 48,
                              child: ListView(
                                controller: _scrollController,
                                scrollDirection: Axis.horizontal,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  _buildAttachmentButton(
                                    context: context,
                                    icon: Icons.image,
                                    label: localizer.translate(context, 'image'),
                                    onTap: () {
                                      // Handle image attachment
                                    },
                                  ),
                                  const SizedBox(width: 2),
                                  _buildAttachmentButton(
                                    context: context,
                                    icon: Icons.videocam,
                                    label: localizer.translate(context, 'video'),
                                    onTap: () {
                                      // Handle video attachment
                                    },
                                  ),
                                  const SizedBox(width: 2),
                                  _buildAttachmentButton(
                                    context: context,
                                    icon: Icons.book,
                                    label: localizer.translate(context, 'book'),
                                    onTap: () {
                                      // Handle book attachment
                                    },
                                  ),
                                  const SizedBox(width: 2),
                                  _buildAttachmentButton(
                                    context: context,
                                    icon: Icons.link,
                                    label: localizer.translate(context, 'link'),
                                    onTap: () {
                                      // Handle link attachment
                                    },
                                  ),
                                  const SizedBox(width: 2),
                                  _buildAttachmentButton(
                                    context: context,
                                    icon: Icons.gif,
                                    label: localizer.translate(context, 'gif'),
                                    onTap: () {
                                      // Handle GIF attachment
                                    },
                                  ),
                                  const SizedBox(width: 2),
                                  _buildAttachmentButton(
                                    context: context,
                                    icon: Icons.poll,
                                    label: localizer.translate(context, 'poll'),
                                    onTap: () {
                                      // Handle poll creation
                                    },
                                  ),
                                  const SizedBox(width: 2),
                                  _buildAttachmentButton(
                                    context: context,
                                    icon: Icons.tv,
                                    label: localizer.translate(context, 'series'),
                                    onTap: () {
                                      // Handle series attachment
                                    },
                                  ),
                                  const SizedBox(width: 2),
                                  _buildAttachmentButton(
                                    context: context,
                                    icon: Icons.movie,
                                    label: localizer.translate(context, 'movie'),
                                    onTap: () {
                                      // Handle movie attachment
                                    },
                                  ),
                                  const SizedBox(width: 2),
                                  _buildAttachmentButton(
                                    context: context,
                                    icon: Icons.location_on,
                                    label: localizer.translate(context, 'location'),
                                    onTap: () {
                                      // Handle location attachment
                                    },
                                  ),
                                  const SizedBox(width: 2),
                                  _buildAttachmentButton(
                                    context: context,
                                    icon: Icons.music_note,
                                    label: localizer.translate(context, 'music'),
                                    onTap: () {
                                      // Handle music attachment
                                    },
                                  ),
                                  const SizedBox(width: 2),
                                  _buildAttachmentButton(
                                    context: context,
                                    icon: Icons.mic,
                                    label: localizer.translate(context, 'audio'),
                                    onTap: () {
                                      // Handle audio attachment
                                    },
                                  ),
                                  const SizedBox(width: 2),
                                  _buildAttachmentButton(
                                    context: context,
                                    icon: Icons.sports_esports,
                                    label: localizer.translate(context, 'game'),
                                    onTap: () {
                                      // Handle game attachment
                                    },
                                  ),
                                  const SizedBox(width: 2),
                                  _buildAttachmentButton(
                                    context: context,
                                    icon: Icons.local_activity,
                                    label: localizer.translate(context, 'activity'),
                                    onTap: () {
                                      // Handle activity attachment
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        _buildPostButton(
                          context: context,
                          label: localizer.translate(context, 'post'),
                        ),
                      ],
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
}
