import 'package:flutter/material.dart';
import '../widgets/kenal_sekitarku_room_button.dart';
import 'game_kenal_sekitarku_screen.dart';

class KenalSekitarkuScreen extends StatelessWidget {
  const KenalSekitarkuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kenal Sekitarku')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            KenalSekitarkuRoomButton(
              title: 'Kamar Tidur',
              icon: Icons.bed,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const GameKenalSekitarkuScreen(
                      roomName: 'Kamar Tidur',
                    ),
                  ),
                );
              },
            ),
            KenalSekitarkuRoomButton(
              title: 'Dapur',
              icon: Icons.restaurant,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const GameKenalSekitarkuScreen(
                      roomName: 'Dapur',
                    ),
                  ),
                );
              },
            ),
            KenalSekitarkuRoomButton(
              title: 'Kamar Mandi',
              icon: Icons.bathtub,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const GameKenalSekitarkuScreen(
                      roomName: 'Kamar Mandi',
                    ),
                  ),
                );
              },
            ),
            KenalSekitarkuRoomButton(
              title: 'Ruang Tamu',
              icon: Icons.weekend,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const GameKenalSekitarkuScreen(
                      roomName: 'Ruang Tamu',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
