import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

/// Main reusable audio player widget
/// You can place this widget anywhere in your app and just pass a different audio URL.
class AudioPlayerWidget extends StatefulWidget {
  final String audioUrl; // URL of the audio file to be played

  const AudioPlayerWidget({
    Key? key,
    required this.audioUrl,
  }) : super(key: key);

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioPlayer _player; // JustAudio player instance

  /// This stream combines current position, buffered position, and duration
  /// It is used to show real-time updates on the seek bar
  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _player.positionStream,
        _player.bufferedPositionStream,
        _player.durationStream,
        (position, buffered, duration) => PositionData(
          position,
          buffered,
          duration ?? Duration.zero,
        ),
      );

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _init(); // Load audio file when widget is initialized
  }

  Future<void> _init() async {
    try {
      // Load audio from the provided URL
      await _player.setUrl(widget.audioUrl);
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  @override
  void dispose() {
    _player.dispose(); // Always dispose the player when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 80,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, 6),
            )
          ],
        ),
        // Main row layout with play/pause and seek bar
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Play/Pause/Replay buttons based on state
            StreamBuilder<PlayerState>(
              stream: _player.playerStateStream,
              builder: (context, snapshot) {
                final playerState = snapshot.data;
                final playing = playerState?.playing;
                final processingState = playerState?.processingState;

                // Show loading spinner
                if (processingState == ProcessingState.loading ||
                    processingState == ProcessingState.buffering) {
                  return const SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  );
                } else if (playing != true) {
                  // Show play button
                  return IconButton(
                    icon: const Icon(Icons.play_arrow),
                    iconSize: 32,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: _player.play,
                  );
                } else if (processingState != ProcessingState.completed) {
                  // Show pause button
                  return IconButton(
                    icon: const Icon(Icons.pause),
                    iconSize: 32,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: _player.pause,
                  );
                } else {
                  // Show replay button
                  return IconButton(
                    icon: const Icon(Icons.replay),
                    iconSize: 32,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: () => _player.seek(Duration.zero),
                  );
                }
              },
            ),

            const SizedBox(width: 12), // space between button and seek bar

            // The seek bar area
            Expanded(
              child: StreamBuilder<PositionData>(
                stream: _positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;

                  // Padding added to align vertically with the icon
                  return Padding(
                    padding: const EdgeInsets.only(top: 13),
                    child: SeekBar(
                      duration: positionData?.duration ?? Duration.zero,
                      position: positionData?.position ?? Duration.zero,
                      bufferedPosition:
                          positionData?.bufferedPosition ?? Duration.zero,
                      onChanged: _player.seek,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// This class holds current position, buffered position, and duration of audio
class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}

/// Seek bar widget used in the audio player
/// Displays progress, buffered progress and total duration
class SeekBar extends StatelessWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration> onChanged;

  const SeekBar({
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Stack to show both buffered and current slider
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 4,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 10),
          ),
          child: Stack(
            children: [
              // Buffered position (behind)
              Slider(
                min: 0,
                max: duration.inMilliseconds.toDouble(),
                value: bufferedPosition.inMilliseconds
                    .clamp(0, duration.inMilliseconds)
                    .toDouble(),
                onChanged: (_) {}, // no interaction needed
                activeColor: Colors.grey.shade400,
                inactiveColor: Colors.grey.shade300,
              ),
              // Playback position (on top)
              Slider(
                min: 0,
                max: duration.inMilliseconds.toDouble(),
                value: position.inMilliseconds
                    .clamp(0, duration.inMilliseconds)
                    .toDouble(),
                onChanged: (value) {
                  onChanged(Duration(milliseconds: value.round()));
                },
                activeColor: Colors.teal,
                inactiveColor: Colors.grey.shade300,
              ),
            ],
          ),
        ),
        // Time indicators under slider
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_formatDuration(position), style: TextStyle(fontSize: 12)),
              Text(_formatDuration(duration), style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }

  /// Converts Duration to mm:ss string
  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }
}
