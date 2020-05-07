import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shibusindia/model/channel.dart';

import 'home/channel_card.dart';

class Telegramsprovider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final channels = Provider.of<List<ChannelsData>>(context);
    return ListView.builder(
      itemCount: channels.length,
      itemBuilder: (context, index) {
        return ChannelCard(channel: channels[index]);
      },
    );
  }
}
