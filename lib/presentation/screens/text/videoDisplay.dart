import 'package:detector/common/constants/size_constants.dart';
import 'package:detector/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  final bool motiation;

  const VideoPlayer({Key? key,required this.motiation}) : super(key: key);
  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;
  List<String> _ids =[];

  final List<String> _music = [
    'VgdAcENXy84',
    '3mMqQXlCtTM',
    'YRS0EScCWY0',
  ];

  final List<String> _motivation = [
    'VgdAcENXy84',
    '3mMqQXlCtTM',
    'YRS0EScCWY0',
  ];

  @override
  void initState() {
    super.initState();
    if(widget.motiation){
      _ids = _motivation;
    }else{
      _ids = _music;
    }
    _ids.shuffle();
    _controller = YoutubePlayerController(
      initialVideoId: _ids.first,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: YoutubePlayerBuilder(
        onExitFullScreen: () {
          SystemChrome.setPreferredOrientations(DeviceOrientation.values);
        },
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
          topActions: <Widget>[
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                _controller.metadata.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
                size: 25.0,
              ),
              onPressed: () {
                
              },
            ),
          ],
          onReady: () {
            _isPlayerReady = true;
          },
          onEnded: (data) {
            _controller
                .load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
            _showSnackBar('Next Video Started!');
          },
        ),
        builder: (context, player) => Scaffold(
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizes.halfSpace),
                child: CustomAppBar(
                  backButton: true,
                  title: widget.motiation? "Motivational Videos":"Relaxations Videos",
                ),
              ),
              SizedBox(
                height: size.height-84.h,
                width: size.width,
                child: ListView(
                  children: [
                    player,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          
                          _space,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.skip_previous),
                                onPressed: _isPlayerReady
                                    ? () => _controller.load(_ids[
                                        (_ids.indexOf(_controller.metadata.videoId) -
                                                1) %
                                            _ids.length])
                                    : null,
                              ),
                              IconButton(
                                icon: Icon(
                                  _controller.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                ),
                                onPressed: _isPlayerReady
                                    ? () {
                                        _controller.value.isPlaying
                                            ? _controller.pause()
                                            : _controller.play();
                                        setState(() {});
                                      }
                                    : null,
                              ),
                              IconButton(
                                icon: Icon(_muted ? Icons.volume_off : Icons.volume_up),
                                onPressed: _isPlayerReady
                                    ? () {
                                        _muted
                                            ? _controller.unMute()
                                            : _controller.mute();
                                        setState(() {
                                          _muted = !_muted;
                                        });
                                      }
                                    : null,
                              ),
                              FullScreenButton(
                                controller: _controller,
                                color: Colors.blueAccent,
                              ),
                              IconButton(
                                icon: const Icon(Icons.skip_next),
                                onPressed: _isPlayerReady
                                    ? () => _controller.load(_ids[
                                        (_ids.indexOf(_controller.metadata.videoId) +
                                                1) %
                                            _ids.length])
                                    : null,
                              ),
                            ],
                          ),
                          _space,
                          Row(
                            children: <Widget>[
                              const Text(
                                "Volume",
                                style: TextStyle(fontWeight: FontWeight.w300),
                              ),
                              Expanded(
                                child: Slider(
                                  inactiveColor: Colors.transparent,
                                  value: _volume,
                                  min: 0.0,
                                  max: 100.0,
                                  divisions: 10,
                                  label: '${(_volume).round()}',
                                  onChanged: _isPlayerReady
                                      ? (value) {
                                          setState(() {
                                            _volume = value;
                                          });
                                          _controller.setVolume(_volume.round());
                                        }
                                      : null,
                                ),
                              ),
                            ],
                          ),
                          _space,
                          // AnimatedContainer(
                          //   duration: const Duration(milliseconds: 800),
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(20.0),
                          //     color: _getStateColor(_playerState),
                          //   ),
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Text(
                          //     _playerState.toString(),
                          //     style: const TextStyle(
                          //       fontWeight: FontWeight.w300,
                          //       color: Colors.white,
                          //     ),
                          //     textAlign: TextAlign.center,
                          //   ),
                          // ),
                        ],
                      ),
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

  Widget _text(String title, String value) {
    return RichText(
      text: TextSpan(
        text: '$title : ',
        style: const TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStateColor(PlayerState state) {
    switch (state) {
      case PlayerState.unknown:
        return Colors.grey[700]!;
      case PlayerState.unStarted:
        return Colors.pink;
      case PlayerState.ended:
        return Colors.red;
      case PlayerState.playing:
        return Colors.blueAccent;
      case PlayerState.paused:
        return Colors.orange;
      case PlayerState.buffering:
        return Colors.yellow;
      case PlayerState.cued:
        return Colors.blue[900]!;
      default:
        return Colors.blue;
    }
  }

  Widget get _space => const SizedBox(height: 10);

  Widget _loadCueButton(String action) {
    return Expanded(
      child: MaterialButton(
        color: Colors.blueAccent,
        onPressed: _isPlayerReady
            ? () {
                if (_idController.text.isNotEmpty) {
                  var id = YoutubePlayer.convertUrlToId(
                        _idController.text,
                      ) ??
                      '';
                  if (action == 'LOAD') _controller.load(id);
                  if (action == 'CUE') _controller.cue(id);
                  FocusScope.of(context).requestFocus(FocusNode());
                } else {
                  _showSnackBar('Source can\'t be empty!');
                }
              }
            : null,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Text(
            action,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}