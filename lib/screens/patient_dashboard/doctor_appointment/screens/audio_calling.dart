// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:mental_health/screens/patient_dashboard/doctor_appointment/components/agora.config.dart' as config;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// JoinChannelAudio Example
class JoinChannelAudio extends StatefulWidget {
  const JoinChannelAudio({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<JoinChannelAudio> {
  // late final RtcEngine _engine;
  // String channelId = config.channelId;
  bool isJoined = false,
      openMicrophone = true,
      enableSpeakerphone = true,
      playEffect = false;
  bool _enableInEarMonitoring = false;
  double _recordingVolume = 0, _playbackVolume = 0, _inEarMonitoringVolume = 0;
  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    // _controller = TextEditingController(text: channelId);
    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    // _engine.destroy();
  }

  _initEngine() async {
    // _engine = await RtcEngine.createWithContext(RtcEngineContext(config.appId));
    // _addListeners();

    // await _engine.enableAudio();
    // await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    // await _engine.setClientRole(ClientRole.Broadcaster);
  }

  // _addListeners() {
  //   // _engine.setEventHandler(RtcEngineEventHandler(
  //   //   joinChannelSuccess: (channel, uid, elapsed) {
  //   //     log('joinChannelSuccess $channel $uid $elapsed');
  //       setState(() {
  //         isJoined = true;
  //       });
  //     },
      // leaveChannel: (stats) async {
      //   log('leaveChannel ${stats.toJson()}');
      //   setState(() {
      //     isJoined = false;
      //   });
      // },
    // ));
  // }

  _joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await Permission.microphone.request();
    }

    // await _engine
        // .joinChannel(config.token, config.channelId, null, config.uid)
        // .catchError((onError) {
    // });
  // }

  // _leaveChannel() async {
  //   await _engine.leaveChannel();
  }

  _switchMicrophone() {
    // _engine.enableLocalAudio(!openMicrophone).then((value) {
      setState(() {
        openMicrophone = !openMicrophone;
      });
    // }).catchError((err) {
    //   log('enableLocalAudio $err');
    // });
  }

  // _switchSpeakerphone() {
  //   _engine.setEnableSpeakerphone(!enableSpeakerphone).then((value) {
  //     setState(() {
  //       enableSpeakerphone = !enableSpeakerphone;
  //     });
  //   }).catchError((err) {
  //     log('setEnableSpeakerphone $err');
  //   });
  // }

  // _switchEffect() async {
  //   if (playEffect) {
  //     _engine.stopEffect(1).then((value) {
  //       setState(() {
  //         playEffect = false;
  //       });
  //     }).catchError((err) {
  //       log('stopEffect $err');
  //     });
  //   } else {
  //     // _engine
  //         // .playEffect(
  //         //     1,
  //         //     await (_engine.getAssetAbsolutePath("assets/Sound_Horizon.mp3")
  //         //         as FutureOr<String>),
  //         //     -1,
  //         //     1,
  //         //     1,
  //         //     100,
  //         //     true)
  //         // .then((value) {
  //       // setState(() {
  //       //   playEffect = true;
  //       // });
  //     // }).catchError((err) {
  //     //   log('playEffect $err');
  //     // });
  //   }
  // }

  // _onChangeInEarMonitoringVolume(double value) {
  //   setState(() {
  //     _inEarMonitoringVolume = value;
  //   });
  //   _engine.setInEarMonitoringVolume(value.toInt());
  // }

  _toggleInEarMonitoring(value) {
    setState(() {
      _enableInEarMonitoring = value;
    });
    // _engine.enableInEarMonitoring(value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Column(
            children: [
              TextField(
                controller: _controller,
                decoration: const InputDecoration(hintText: 'Channel ID'),
                onChanged: (text) {
                  // setState(() {
                  //   channelId = text;
                  // });
                },
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed:
                            // isJoined
                            // _leaveChannel
                                 _joinChannel,
                        child: Text('${isJoined ? 'Leave' : 'Join'} channel'),
                        style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple[400],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  // children: [
                  //   ElevatedButton(
                  //     onPressed: _switchMicrophone,
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: Colors.cyan,
                  //     ),
                  //     child: Text('Microphone ${openMicrophone ? 'on' : 'off'}'),
                  //   ),
                  //   // ElevatedButton(
                  //   //   onPressed:
                  //     // _switchSpeakerphone,
                  //     // style: ElevatedButton.styleFrom(
                  //     //   backgroundColor: Colors.cyan,
                  //     // ),
                  //     // child:
                  //     //     Text(enableSpeakerphone ? 'Speakerphone' : 'Earpiece'),
                  //   // ),
                  //   ElevatedButton(
                  //     onPressed: _switchEffect,
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: Colors.cyan,
                  //     ),
                  //     child: Text('${playEffect ? 'Stop' : 'Play'} effect'),
                  //   ),
                  //   Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       const Text('RecordingVolume:'),
                  //       SliderTheme(
                  //         data: SliderTheme.of(context).copyWith(
                  //           activeTrackColor: Colors.cyan,
                  //           inactiveTrackColor: Colors.cyan,
                  //           trackHeight: 4.0,
                  //           thumbColor: Colors.cyan,
                  //           thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
                  //           overlayColor: Colors.cyan.withAlpha(32),
                  //           overlayShape: const RoundSliderOverlayShape(overlayRadius: 14.0),
                  //         ),
                  //         child: Slider(
                  //           value: _recordingVolume,
                  //           min: 0,
                  //           max: 400,
                  //           divisions: 5,
                  //           label: 'RecordingVolume',
                  //           onChanged: (double value) {
                  //             setState(() {
                  //               _recordingVolume = value;
                  //             });
                  //             _engine.adjustRecordingSignalVolume(value.toInt());
                  //           },
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  //   Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       const Text('PlaybackVolume:'),
                  //       SliderTheme(
                  //         data: SliderTheme.of(context).copyWith(
                  //           activeTrackColor: Colors.cyan,
                  //           inactiveTrackColor: Colors.cyan,
                  //           trackHeight: 4.0,
                  //           thumbColor: Colors.cyan,
                  //           thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
                  //           overlayColor: Colors.cyan.withAlpha(32),
                  //           overlayShape: const RoundSliderOverlayShape(overlayRadius: 14.0),
                  //         ),
                  //         child: Slider(
                  //           value: _playbackVolume,
                  //           min: 0,
                  //           max: 400,
                  //           divisions: 5,
                  //           label: 'PlaybackVolume',
                  //           onChanged: (double value) {
                  //             setState(() {
                  //               _playbackVolume = value;
                  //             });
                  //             _engine.adjustPlaybackSignalVolume(value.toInt());
                  //           },
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  //   Column(
                  //     mainAxisSize: MainAxisSize.min,
                  //     crossAxisAlignment: CrossAxisAlignment.end,
                  //     children: [
                  //       Row(mainAxisSize: MainAxisSize.min, children: [
                  //         const Text('InEar Monitoring Volume:'),
                  //         Switch(
                  //           value: _enableInEarMonitoring,
                  //           onChanged: _toggleInEarMonitoring,
                  //           activeTrackColor: Colors.grey[350],
                  //           activeColor: Colors.white,
                  //         )
                  //       ]),
                  //       if (_enableInEarMonitoring)
                  //         SizedBox(
                  //             width: 300,
                  //             child: SliderTheme(
                  //               data: SliderTheme.of(context).copyWith(
                  //                 activeTrackColor: Colors.deepPurple,
                  //                 inactiveTrackColor: Colors.deepPurple,
                  //                 trackHeight: 4.0,
                  //                 thumbColor: Colors.cyan,
                  //                 thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
                  //                 overlayColor: Colors.cyan.withAlpha(32),
                  //                 overlayShape: const RoundSliderOverlayShape(overlayRadius: 14.0),
                  //               ),
                  //               child: Slider(
                  //                 value: _inEarMonitoringVolume,
                  //                 min: 0,
                  //                 max: 100,
                  //                 divisions: 5,
                  //                 label: 'InEar Monitoring Volume',
                  //                 onChanged: _onChangeInEarMonitoringVolume,
                  //               ),
                  //             ))
                  //     ],
                  //   ),
                  // ],
                ),
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              ))
        ],
      ),
    );
  }
}
