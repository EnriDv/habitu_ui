import 'package:flutter/material.dart';

import '../../models/contact_peer_view_model.dart';
import '../../tokens/habitu_colors.dart';
import '../core/habitu_button.dart';

class ContactSyncSheet extends StatelessWidget {
  final bool isSyncing;
  final bool isSynced;
  final List<ContactPeerViewModel> foundPeers;
  final Set<String> following;
  final VoidCallback onStartSync;
  final ValueChanged<String> onToggleFollowing;
  final VoidCallback onDone;

  const ContactSyncSheet({
    super.key,
    required this.isSyncing,
    required this.isSynced,
    required this.foundPeers,
    required this.following,
    required this.onStartSync,
    required this.onToggleFollowing,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 20,
        bottom: 24 + MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: HabituColors.surfaceContainerHigh,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: HabituColors.outline.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (!isSynced && !isSyncing) ...[
            const CircleAvatar(
              backgroundColor: HabituColors.primary,
              radius: 28,
              child: Icon(Icons.people_outline, color: HabituColors.onPrimary, size: 30),
            ),
            const SizedBox(height: 16),
            Text(
              'Encuentra a tus amigos',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Sincronizaremos tus contactos de forma segura. Tus números se anonimizan antes de salir del dispositivo.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: HabituColors.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 24),
            HabituButton(
              label: 'Sincronizar y buscar',
              onPressed: onStartSync,
              fullWidth: true,
            ),
          ] else if (isSyncing) ...[
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Column(
                  children: [
                    CircularProgressIndicator(color: HabituColors.primary),
                    SizedBox(height: 20),
                    Text(
                      'Encriptando y buscando coincidencias...',
                      style: TextStyle(fontFamily: 'Inter', color: HabituColors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ),
          ] else ...[
            Text(
              'Amigos encontrados',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              itemCount: foundPeers.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, idx) {
                final peer = foundPeers[idx];
                final isFollowingPeer = following.contains(peer.name);
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: HabituColors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: HabituColors.primary.withOpacity(0.12),
                        child: Text(
                          peer.initials,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: HabituColors.primary,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              peer.name,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Inter'),
                            ),
                            Text(
                              peer.subtitle,
                              style: const TextStyle(
                                fontSize: 11,
                                color: HabituColors.onSurfaceVariant,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ),
                      isFollowingPeer
                          ? HabituButton.outlined(
                              label: 'Siguiendo',
                              onPressed: () => onToggleFollowing(peer.name),
                            )
                          : HabituButton(
                              label: 'Seguir racha',
                              onPressed: () => onToggleFollowing(peer.name),
                            ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            HabituButton.outlined(
              label: 'Listo',
              onPressed: onDone,
              fullWidth: true,
            ),
          ],
        ],
      ),
    );
  }
}
