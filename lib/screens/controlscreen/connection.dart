import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class Connection extends StatefulWidget {
  //final void Function() startVideo;
  const Connection({
    super.key,
  });

  @override
  State<Connection> createState() => _ConnectionState();
}

class _ConnectionState extends State<Connection> {
  bool _offer = false;
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;
  RTCVideoRenderer _localRenderer = new RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = new RTCVideoRenderer();

  @override
  dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  @override
  void initState() {}

  void startCamera() {
    initRenderers();
    _createPeerConnection().then((pc) {
      _peerConnection = pc;
    });
    super.initState();
  }

  initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  _createPeerConnection() async {
    Map<String, dynamic> configuration = {
      "iceServers": [
        {
          "urls":
              'turn:turn.stepverder.nl:3478', //'stun:stun.l.google.com:19302'  turn:178.62.209.37:3478 circusfamilyprojects.nl
          "username": 'Dominique',
          "credential": 'WS7Yq_jT'
        },
      ]
    };

    final Map<String, dynamic> offerSdpConstraints = {
      "mandatory": {"OfferToReceiveAudio": true, "OfferToReceiveVideo": true}
    };

    _localStream = await _getUserMedia();
    RTCPeerConnection pc =
        await createPeerConnection(configuration, offerSdpConstraints);
    pc.addStream(_localStream!);

    pc.onIceCandidate = (e) {
      if (e.candidate != null) {
        print(jsonEncode({
          'candidate': e.candidate.toString(),
          'sdpMid': e.sdpMid.toString()
        }));
      }
    };

    pc.onAddStream = (stream) {
      log('addStream: ${stream.id}');
      _remoteRenderer.srcObject = stream;
    };
    return pc;
  }

  _getUserMedia() async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': false,
      'video': {'facingMode': 'user'},
    };

    MediaStream stream = await mediaDevices.getUserMedia(mediaConstraints);
    _localRenderer.srcObject = stream;

    mediaDevices.enumerateDevices().then((devices) {
      for (MediaDeviceInfo device in devices) {
        if (device.kind == 'videoinput') {
          log('Camera found: ${device.label}');
        }
      }
    });
  }

  void _createOffer() async {
    RTCSessionDescription description =
        await _peerConnection!.createOffer({'offerToReceiveVideo': 1});
    _peerConnection!.setLocalDescription(description);
  }

  @override
  Widget build(BuildContext context) {
    log("camera");
    return Container(
      color: Colors.green,
      height: 1000,
      width: 100,
      child: RTCVideoView(_localRenderer),
    );
  }
}
