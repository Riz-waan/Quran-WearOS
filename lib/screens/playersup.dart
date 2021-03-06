import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class Lol extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(39, 39, 39, 1),
      body: Center(
        child: new GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AudioServiceWidget(
                  child: PlayerSup(),
                ),
              ),
            );
          },
          child: new Text("my Title"),
        ),
      ),
    );
  }
}

class PlayerSup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(39, 39, 39, 1),
      body: Center(
        child: StreamBuilder<ScreenState>(
          stream: _screenStateStream,
          builder: (context, snapshot) {
            final screenState = snapshot.data;
            final queue = screenState?.queue;
            final mediaItem = screenState?.mediaItem;
            final state = screenState?.playbackState;
            final screenSize = MediaQuery.of(context).size;
            final screenHeight = screenSize.height;
            final screenWidth = screenSize.width;
            final processingState =
                state?.processingState ?? AudioProcessingState.none;
            final playing = state?.playing ?? false;
            AudioService.start(
              backgroundTaskEntrypoint: _audioPlayerTaskEntrypoint,
              androidNotificationChannelName: 'Al Quran',
              // Enable this if you want the Android service to exit the foreground state on pause.
              //androidStopForegroundOnPause: true,
              androidNotificationColor: 0xFF2196f3,
              androidNotificationIcon: 'mipmap/ic_launcher',
              androidEnableQueue: true,
            );
            return Stack(
              children: [
                if (processingState == AudioProcessingState.none)
                  ...[]
                else ...[
                  if (mediaItem?.title != null)
                    Align(
                      alignment: Alignment(0, -0.7),
                      child: Text(
                        mediaItem?.title,
                        style: TextStyle(
                          fontFamily: 'OpenSansMain',
                          color: Colors.white,
                          fontSize: screenWidth / 13,
                        ),
                      ),
                    ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          splashColor: Color.fromRGBO(0, 0, 0, 0.4),
                          highlightColor: Color.fromRGBO(0, 0, 0, 0.2),
                          onTap: () {
                            mediaItem != queue.first
                                ? AudioService.skipToPrevious()
                                : print("First");
                          },
                          child: Container(
                            width: screenWidth / 3,
                            height: screenHeight / 3.61,
                            child: Icon(
                              Icons.skip_previous,
                              color: Colors.white,
                              size: screenHeight / 8,
                            ),
                          ),
                        ),
                        if (playing)
                          pauseButton(screenWidth, screenHeight)
                        else
                          playButton(screenWidth, screenHeight),
                        InkWell(
                          splashColor: Color.fromRGBO(0, 0, 0, 0.4),
                          highlightColor: Color.fromRGBO(0, 0, 0, 0.2),
                          onTap: () {
                            mediaItem != queue.last
                                ? AudioService.skipToNext()
                                : print("Last");
                          },
                          child: Container(
                            width: screenWidth / 3,
                            height: screenHeight / 3.61,
                            child: Icon(
                              Icons.skip_next,
                              color: Colors.white,
                              size: screenHeight / 8,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, 0.7),
                    child: Row(
                      children: <Widget>[
                        InkWell(
                          splashColor: Color.fromRGBO(0, 0, 0, 0.4),
                          highlightColor: Color.fromRGBO(0, 0, 0, 0.2),
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: screenWidth / 2,
                            height: screenHeight / 8,
                            child: Align(
                              alignment: Alignment(0.5, 0),
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Color.fromRGBO(159, 159, 159, 1),
                                  fontSize: screenWidth / 15.6,
                                  fontFamily: 'OpenSansMain',
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          splashColor: Color.fromRGBO(0, 0, 0, 0.4),
                          highlightColor: Color.fromRGBO(0, 0, 0, 0.2),
                          onTap: () {
                            print("Play");
                          },
                          child: Container(
                            width: screenWidth / 2,
                            height: screenHeight / 8,
                            child: Align(
                              alignment: Alignment(-0.3, 0),
                              child: Text(
                                'Save',
                                style: TextStyle(
                                  color: Color.fromRGBO(101, 255, 142, 1),
                                  fontSize: screenWidth / 13,
                                  fontFamily: 'OpenSansMain',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }

  /// Encapsulate all the different data we're interested in into a single
  /// stream so we don't have to nest StreamBuilders.
  Stream<ScreenState> get _screenStateStream =>
      Rx.combineLatest3<List<MediaItem>, MediaItem, PlaybackState, ScreenState>(
          AudioService.queueStream,
          AudioService.currentMediaItemStream,
          AudioService.playbackStateStream,
          (queue, mediaItem, playbackState) =>
              ScreenState(queue, mediaItem, playbackState));

  RaisedButton startButton(String label, VoidCallback onPressed) =>
      RaisedButton(
        child: Text(label),
        onPressed: onPressed,
      );

  InkWell playButton(var screenWidth, var screenHeight) => InkWell(
        splashColor: Color.fromRGBO(0, 0, 0, 0.4),
        highlightColor: Color.fromRGBO(0, 0, 0, 0.2),
        onTap: () {
          AudioService.play();
        },
        child: Container(
          width: screenWidth / 3,
          height: screenHeight / 3.61,
          child: Icon(
            Icons.play_arrow,
            color: Colors.white,
            size: screenHeight / 8,
          ),
        ),
      );

  InkWell pauseButton(var screenWidth, var screenHeight) => InkWell(
        splashColor: Color.fromRGBO(0, 0, 0, 0.4),
        highlightColor: Color.fromRGBO(0, 0, 0, 0.2),
        onTap: () {
          AudioService.pause();
        },
        child: Container(
          width: screenWidth / 3,
          height: screenHeight / 3.61,
          child: Icon(
            Icons.pause,
            color: Colors.white,
            size: screenHeight / 8,
          ),
        ),
      );

  IconButton stopButton() => IconButton(
        icon: Icon(Icons.stop),
        iconSize: 64.0,
        onPressed: AudioService.stop,
      );
}

class ScreenState {
  final List<MediaItem> queue;
  final MediaItem mediaItem;
  final PlaybackState playbackState;

  ScreenState(this.queue, this.mediaItem, this.playbackState);
}

// NOTE: Your entrypoint MUST be a top-level function.
void _audioPlayerTaskEntrypoint() async {
  AudioServiceBackground.run(() => AudioPlayerTask());
}

/// This task defines logic for playing a list of podcast episodes.
class AudioPlayerTask extends BackgroundAudioTask {
  final _mediaLibrary = MediaLibrary();
  AudioPlayer _player = new AudioPlayer();
  AudioProcessingState _skipState;

  StreamSubscription<PlaybackEvent> _eventSubscription;

  List<MediaItem> get queue => _mediaLibrary.items;
  int get index => _player.currentIndex;
  MediaItem get mediaItem => index == null ? null : queue[index];

  @override
  Future<void> onStart(Map<String, dynamic> params) async {
    // We configure the audio session for speech since we're playing a podcast.
    // You can also put this in your app's initialisation if your app doesn't
    // switch between two types of audio as this example does.
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    // Broadcast media item changes.
    _player.currentIndexStream.listen((index) {
      if (index != null) AudioServiceBackground.setMediaItem(queue[index]);
    });
    // Propagate all events from the audio player to AudioService clients.
    _eventSubscription = _player.playbackEventStream.listen((event) {
      _broadcastState();
    });
    // Special processing for state transitions.
    _player.processingStateStream.listen((state) {
      switch (state) {
        case ProcessingState.completed:
          // In this example, the service stops when reaching the end.
          onStop();
          break;
        case ProcessingState.ready:
          // If we just came from skipping between tracks, clear the skip
          // state now that we're ready to play.
          _skipState = null;
          break;
        default:
          break;
      }
    });

    // Load and broadcast the queue
    AudioServiceBackground.setQueue(queue);
    try {
      await _player.load(ConcatenatingAudioSource(
        children:
            queue.map((item) => AudioSource.uri(Uri.parse(item.id))).toList(),
      ));
      // In this example, we automatically start playing on start.
      onPlay();
    } catch (e) {
      print("Error: $e");
      onStop();
    }
  }

  @override
  Future<void> onSkipToQueueItem(String mediaId) async {
    // Then default implementations of onSkipToNext and onSkipToPrevious will
    // delegate to this method.
    final newIndex = queue.indexWhere((item) => item.id == mediaId);
    if (newIndex == -1) return;
    // During a skip, the player may enter the buffering state. We could just
    // propagate that state directly to AudioService clients but AudioService
    // has some more specific states we could use for skipping to next and
    // previous. This variable holds the preferred state to send instead of
    // buffering during a skip, and it is cleared as soon as the player exits
    // buffering (see the listener in onStart).
    _skipState = newIndex > index
        ? AudioProcessingState.skippingToNext
        : AudioProcessingState.skippingToPrevious;
    // This jumps to the beginning of the queue item at newIndex.
    _player.seek(Duration.zero, index: newIndex);
  }

  @override
  Future<void> onPlay() => _player.play();

  @override
  Future<void> onPause() => _player.pause();

  @override
  Future<void> onSeekTo(Duration position) => _player.seek(position);

  @override
  Future<void> onFastForward() => _seekRelative(fastForwardInterval);

  @override
  Future<void> onRewind() => _seekRelative(-rewindInterval);

  @override
  Future<void> onStop() async {
    await _player.pause();
    await _player.dispose();
    _eventSubscription.cancel();
    // It is important to wait for this state to be broadcast before we shut
    // down the task. If we don't, the background task will be destroyed before
    // the message gets sent to the UI.
    await _broadcastState();
    // Shut down this task
    await super.onStop();
  }

  /// Jumps away from the current position by [offset].
  Future<void> _seekRelative(Duration offset) async {
    var newPosition = _player.position + offset;
    // Make sure we don't jump out of bounds.
    if (newPosition < Duration.zero) newPosition = Duration.zero;
    if (newPosition > mediaItem.duration) newPosition = mediaItem.duration;
    // Perform the jump via a seek.
    await _player.seek(newPosition);
  }

  /// Begins or stops a continuous seek in [direction]. After it begins it will
  /// continue seeking forward or backward by 10 seconds within the audio, at
  /// intervals of 1 second in app time.

  /// Broadcasts the current state to all clients.
  Future<void> _broadcastState() async {
    await AudioServiceBackground.setState(
      controls: [
        MediaControl.skipToPrevious,
        if (_player.playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.skipToNext,
      ],
      systemActions: [
        MediaAction.seekTo,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      ],
      processingState: _getProcessingState(),
      playing: _player.playing,
      position: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
    );
  }

  /// Maps just_audio's processing state into into audio_service's playing
  /// state. If we are in the middle of a skip, we use [_skipState] instead.
  AudioProcessingState _getProcessingState() {
    if (_skipState != null) return _skipState;
    switch (_player.processingState) {
      case ProcessingState.none:
        return AudioProcessingState.stopped;
      case ProcessingState.loading:
        return AudioProcessingState.connecting;
      case ProcessingState.buffering:
        return AudioProcessingState.buffering;
      case ProcessingState.ready:
        return AudioProcessingState.ready;
      case ProcessingState.completed:
        return AudioProcessingState.completed;
      default:
        throw Exception("Invalid state: ${_player.processingState}");
    }
  }
}

/// Provides access to a library of media items. In your app, this could come
/// from a database or web service.
class MediaLibrary {
  final _items = <MediaItem>[
    MediaItem(
      id: "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3",
      title: "A Salute To Head-Scratching Science",
      album: "The Noble Quran",
    ),
    MediaItem(
      id: "https://s3.amazonaws.com/scifri-segments/scifri201711241.mp3",
      album: "The Noble Quran",
      title: "From Cat Rheology To Operatic Incompetence",
    ),
  ];

  List<MediaItem> get items => _items;
}
