import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../models/channel_model.dart';

class TvScreen extends StatefulWidget {
  const TvScreen({super.key});

  @override
  State<TvScreen> createState() => _TvScreenState();
}

class _TvScreenState extends State<TvScreen> {
  final Player _mainPlayer = Player();
  late final VideoController _mainController;
  List<Channel> _channels = [];
  int _currentChannelIndex = -1;
  String? _error;
  bool _isInitialized = false;
  double _volume = 100;

  @override
  void initState() {
    super.initState();
    _mainController = VideoController(_mainPlayer);
    _initializePlayer();
    _loadSavedChannels();
  }

  @override
  void dispose() {
    _mainPlayer.dispose();
    super.dispose();
  }

  void _changeChannel(Channel channel) {
    if (!mounted) return;

    setState(() {
      _error = null;
      _isInitialized = false;
    });

    final newIndex = _channels.indexOf(channel);

    // Simple channel change without preloading
    _mainPlayer.pause();
    _mainPlayer.open(Media(channel.link), play: true).then((_) {
      if (mounted) {
        setState(() {
          _isInitialized = true;
          _currentChannelIndex = newIndex;
        });
      }
    }).catchError((error) {
      if (mounted) {
        setState(() {
          _error = error.toString();
          _isInitialized = true;
        });
      }
    });
  }

  Future<void> _loadSavedChannels() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/channels.json');

      if (await file.exists()) {
        final jsonString = await file.readAsString();
        final List<dynamic> jsonList = json.decode(jsonString);
        setState(() {
          _channels = jsonList.map((json) => Channel.fromJson(json)).toList();
          // Only set current channel index if we have channels
          _currentChannelIndex = _channels.isNotEmpty ? 0 : -1;
        });

        // If we have channels, start playing the first one
        if (_channels.isNotEmpty) {
          _changeChannel(_channels[0]);
        }
      } else {
        setState(() {
          _currentChannelIndex = -1;
          _channels = [];
        });
      }
    } catch (e) {
      debugPrint('Error loading channels: $e');
      setState(() {
        _currentChannelIndex = -1;
        _channels = [];
      });
    }
  }

  Future<void> _saveChannels() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/channels.json');

      final jsonList = _channels.map((channel) => channel.toJson()).toList();
      await file.writeAsString(json.encode(jsonList));
    } catch (e) {
      debugPrint('Error saving channels: $e');
    }
  }

  void _addSelectedChannels(List<Channel> selectedChannels) {
    setState(() {
      _channels.addAll(selectedChannels);
      _saveChannels(); // Save whenever channels are added
    });
  }

  void _removeChannel(int index) {
    setState(() {
      _channels.removeAt(index);
      _saveChannels(); // Save whenever a channel is removed
    });
  }

  Future<void> _initializePlayer() async {
    try {
      if (_channels.isNotEmpty && mounted) {
        // Set initial media and volume
        await _mainPlayer.open(Media(_channels[_currentChannelIndex].link));
        await _mainPlayer.setVolume(_volume.toDouble());

        setState(() {
          _isInitialized = true;
          _error = null;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isInitialized = false;
        });
      }
    }
  }

  void _nextChannel() {
    if (_channels.isEmpty) return;

    // Find next enabled channel
    int nextIndex = _currentChannelIndex;
    do {
      nextIndex = (nextIndex + 1) % _channels.length;
    } while (
        !_channels[nextIndex].enabled && nextIndex != _currentChannelIndex);

    if (_channels[nextIndex].enabled) {
      _changeChannel(_channels[nextIndex]);
    }
  }

  void _previousChannel() {
    if (_channels.isEmpty) return;

    // Find previous enabled channel
    int prevIndex = _currentChannelIndex;
    do {
      prevIndex = (prevIndex - 1 + _channels.length) % _channels.length;
    } while (
        !_channels[prevIndex].enabled && prevIndex != _currentChannelIndex);

    if (_channels[prevIndex].enabled) {
      _changeChannel(_channels[prevIndex]);
    }
  }

  Future<void> _parseM3UContent(
      String content,
      List<Channel> foundChannels,
      List<bool> selectedChannels,
      void Function(void Function()) setDialogState) async {
    if (!content.startsWith('#EXTM3U')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid M3U format. Content must start with #EXTM3U'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final lines = content.split('\n');
    foundChannels.clear();
    String? currentExtInf;

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i].trim();

      if (line.startsWith('#EXTINF:-1')) {
        currentExtInf = line;
      } else if (line.endsWith('.m3u8') && currentExtInf != null) {
        try {
          final channel = Channel.fromM3ULine(currentExtInf, line);
          foundChannels.add(channel);
          currentExtInf = null;
        } catch (e) {
          debugPrint('Error parsing channel: $e');
        }
      }
    }

    if (foundChannels.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No valid channels found in the file'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setDialogState(() {
      selectedChannels.clear();
      selectedChannels.addAll(List.filled(foundChannels.length, true));
    });
  }

  Future<void> _pickAndParseM3UFile(
      List<Channel> foundChannels,
      List<bool> selectedChannels,
      void Function(void Function()) setDialogState) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['m3u', 'm3u8'],
      );

      if (result != null) {
        final file = File(result.files.single.path!);
        final content = await file.readAsString();
        await _parseM3UContent(
            content, foundChannels, selectedChannels, setDialogState);
      }
    } catch (e) {
      if (context.mounted) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error reading file: ${e.toString()}'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future<void> _showAddChannelsDialog() async {
    final List<Channel> foundChannels = [];
    final List<bool> selectedChannels = [];

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Add Channels from M3U File'),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.upload_file),
                      label: const Text('Choose M3U File'),
                      onPressed: () => _pickAndParseM3UFile(
                          foundChannels, selectedChannels, setState),
                    ),
                    const SizedBox(height: 16),
                    if (foundChannels.isNotEmpty) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            icon: const Icon(Icons.select_all),
                            label: const Text('Select All'),
                            onPressed: () {
                              setState(() {
                                for (int i = 0;
                                    i < selectedChannels.length;
                                    i++) {
                                  selectedChannels[i] = true;
                                }
                              });
                            },
                          ),
                          const SizedBox(width: 8),
                          TextButton.icon(
                            icon: const Icon(Icons.deselect),
                            label: const Text('Unselect All'),
                            onPressed: () {
                              setState(() {
                                for (int i = 0;
                                    i < selectedChannels.length;
                                    i++) {
                                  selectedChannels[i] = false;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: foundChannels.length,
                          itemBuilder: (context, index) {
                            final channel = foundChannels[index];
                            return ExpansionTile(
                              leading: Checkbox(
                                value: selectedChannels[index],
                                onChanged: (bool? value) {
                                  setState(() {
                                    selectedChannels[index] = value ?? false;
                                  });
                                },
                              ),
                              title: Row(
                                children: [
                                  if (channel.tvgLogo != null)
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Image.network(
                                        channel.tvgLogo!,
                                        width: 24,
                                        height: 24,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(Icons.tv, size: 24),
                                      ),
                                    ),
                                  Expanded(
                                    child: Text(
                                      channel.name,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: channel.groupTitle != null
                                  ? Text(
                                      channel.groupTitle!,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    )
                                  : null,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 8.0,
                                  ),
                                  child: SelectableText(
                                    channel.link,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'monospace',
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                if (foundChannels.isNotEmpty)
                  ElevatedButton(
                    onPressed: () {
                      final newChannels = List.generate(
                        foundChannels.length,
                        (index) => selectedChannels[index]
                            ? foundChannels[index]
                            : null,
                      ).whereType<Channel>().toList();

                      if (mounted) {
                        setState(() {
                          _addSelectedChannels(newChannels);
                        });

                        // Initialize player if this is the first channel added
                        if (_channels.length == newChannels.length) {
                          _initializePlayer();
                        }
                      }
                      Navigator.of(context).pop();
                    },
                    child: const Text('Add Selected Channels'),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _showManageChannelsDialog() async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Manage Channels'),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _channels.length,
                  itemBuilder: (context, index) {
                    final channel = _channels[index];
                    return CheckboxListTile(
                      value: channel.enabled,
                      onChanged: (bool? value) {
                        setState(() {
                          _channels[index] =
                              channel.copyWith(enabled: value ?? true);
                        });
                        _saveChannels(); // Save changes immediately
                      },
                      title: Text(channel.name),
                      subtitle: Text(channel.groupTitle ?? ''),
                      secondary: channel.tvgLogo != null
                          ? Image.network(
                              channel.tvgLogo!,
                              width: 24,
                              height: 24,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.tv, size: 24),
                            )
                          : const Icon(Icons.tv, size: 24),
                    );
                  },
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Close'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              SelectableText(
                'Error: $_error',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _initializePlayer,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_channels.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('TV Player'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.tv_outlined,
                size: 64,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              Text(
                'Welcome to TV Player',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              const Text(
                'Get started by adding your M3U playlist',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.upload_file),
                label: const Text('Upload M3U File'),
                onPressed: _showAddChannelsDialog,
              ),
            ],
          ),
        ),
      );
    }

    if (!_isInitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            if (_channels[_currentChannelIndex].tvgLogo != null)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Image.network(
                  _channels[_currentChannelIndex].tvgLogo!,
                  width: 24,
                  height: 24,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.tv, size: 24),
                ),
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_channels[_currentChannelIndex].name),
                  if (_channels[_currentChannelIndex].groupTitle != null)
                    Text(
                      _channels[_currentChannelIndex].groupTitle!,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.grey),
                    ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.playlist_add),
            onPressed: _showAddChannelsDialog,
            tooltip: 'Add Channels from M3U',
          ),
          IconButton(
            icon: const Icon(Icons.playlist_play),
            onPressed: _showManageChannelsDialog,
            tooltip: 'Manage Channels',
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _removeChannel(_currentChannelIndex);
              if (_channels.isEmpty) {
                _mainPlayer.pause();
                setState(() {
                  _currentChannelIndex = -1;
                });
              } else {
                _changeChannel(_channels[
                    _currentChannelIndex.clamp(0, _channels.length - 1)]);
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Video(
                controller: _mainController,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Volume Slider
                Row(
                  children: [
                    const Icon(Icons.volume_up),
                    Expanded(
                      child: Slider(
                        value: _volume,
                        min: 0,
                        max: 100,
                        onChanged: (value) async {
                          setState(() {
                            _volume = value;
                          });
                          await _mainPlayer.setVolume(_volume.toDouble());
                        },
                      ),
                    ),
                    Text('${_volume.toInt()}%'),
                  ],
                ),
                // Playback Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.skip_previous),
                      onPressed:
                          _currentChannelIndex > 0 ? _previousChannel : null,
                    ),
                    IconButton(
                      icon: const Icon(Icons.play_arrow),
                      onPressed: () => _mainPlayer.play(),
                    ),
                    IconButton(
                      icon: const Icon(Icons.pause),
                      onPressed: () => _mainPlayer.pause(),
                    ),
                    IconButton(
                      icon: const Icon(Icons.skip_next),
                      onPressed: _currentChannelIndex < _channels.length - 1
                          ? _nextChannel
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
