import 'package:flutter/material.dart';
import 'package:habitu_ui/habitu_ui.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  runApp(const HabituWidgetbookApp());
}

class HabituWidgetbookApp extends StatelessWidget {
  const HabituWidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      addons: [
        MaterialThemeAddon(themes: [
          WidgetbookTheme(name: 'Light', data: HabituTheme.lightTheme),
          WidgetbookTheme(name: 'Dark', data: HabituTheme.darkTheme),
        ]),
        TextScaleAddon(scales: const [1, 1.2, 1.4]),
      ],
      directories: [
        WidgetbookFolder(
          name: 'Core',
          children: [
            WidgetbookComponent(
              name: 'HabituButton',
              useCases: [
                WidgetbookUseCase(
                  name: 'Primary',
                  builder: (context) => const Center(
                    child: HabituButton(label: 'Guardar', onPressed: null),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'Outlined',
                  builder: (context) => const Center(
                    child: HabituButton.outlined(label: 'Cancelar', onPressed: null),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'HabituCard',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => const Padding(
                    padding: EdgeInsets.all(24),
                    child: HabituCard(child: Text('Contenido de ejemplo')),
                  ),
                ),
              ],
            ),
          ],
        ),
        WidgetbookFolder(
          name: 'Foundations',
          children: [
            WidgetbookComponent(
              name: 'Metrics',
              useCases: [
                WidgetbookUseCase(
                  name: 'Hero',
                  builder: (context) => const Padding(
                    padding: EdgeInsets.all(24),
                    child: MetricHeroCard(
                      eyebrow: 'Pulso actual',
                      value: '17 dÃ­as',
                      description: 'Tu mejor racha activa sigue viva. MantÃ©n el ritmo.',
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'Mini',
                  builder: (context) => const Padding(
                    padding: EdgeInsets.all(24),
                    child: MetricMiniCard(
                      label: 'Ãšltimos 7 dÃ­as',
                      value: '12',
                      caption: '86% de cumplimiento',
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Sections',
              useCases: [
                WidgetbookUseCase(
                  name: 'Header',
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(24),
                    child: SectionHeader(
                      title: 'Rutinas',
                      actionLabel: 'Nueva',
                      onAction: () {},
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'Title',
                  builder: (context) => const Padding(
                    padding: EdgeInsets.all(24),
                    child: SectionTitle(
                      title: 'Mapa de consistencia',
                      subtitle: 'Ãšltimos 120 dÃ­as de actividad.',
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Access Mode Switch',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(24),
                    child: AccessModeSwitch(
                      selectedIndex: 0,
                      labels: const ['Iniciar sesiÃ³n', 'Crear cuenta'],
                      onChanged: (_) {},
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        WidgetbookFolder(
          name: 'Habits',
          children: [
            WidgetbookComponent(
              name: 'Habit Card',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(24),
                    child: HabitCard(
                      habit: HabitCardViewModel(
                        title: 'Tomar agua',
                        description: '8 vasos diarios',
                        frequencyLabel: 'Diario',
                        isPublic: true,
                        accentColor: HabituColors.primary,
                        icon: Icons.water_drop_outlined,
                      ),
                      onComplete: () {},
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Sync Status',
              useCases: [
                WidgetbookUseCase(
                  name: 'Pending',
                  builder: (context) => const Padding(
                    padding: EdgeInsets.all(24),
                    child: SyncStatusCard(pendingCount: 3),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'Synced',
                  builder: (context) => const Padding(
                    padding: EdgeInsets.all(24),
                    child: SyncStatusCard(pendingCount: 0),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Completion Confirmation Sheet',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => CompletionConfirmationSheet(
                    habitTitle: 'Leer 20 minutos',
                    onRequestEvidence: (_) async => null,
                    onSubmit: (_) {},
                    onCancel: () {},
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Habit Editor Sheet',
              useCases: [
                WidgetbookUseCase(
                  name: 'Create',
                  builder: (context) => HabitEditorSheet(
                    title: 'Crear hÃ¡bito',
                    initialTitle: 'Meditar',
                    initialDescription: '5 minutos al despertar',
                    initialIcon: '??',
                    initialColorHex: HabituColors.habitColorHexes.first,
                    initialDaysOfWeek: const [1, 2, 3, 4, 5],
                    initialIsPublic: false,
                    initialReminderTime: const TimeOfDay(hour: 8, minute: 0),
                    categories: const [
                      HabitEditorCategoryOption(label: 'Aprendizaje', emoji: '??'),
                      HabitEditorCategoryOption(label: 'Bienestar', emoji: '??'),
                      HabitEditorCategoryOption(label: 'Movimiento', emoji: '??'),
                    ],
                    availableColorHexes: HabituColors.habitColorHexes,
                    onSubmit: (_) async => false,
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Habit Detail Sheet',
              useCases: [
                WidgetbookUseCase(
                  name: 'With History',
                  builder: (context) => HabitDetailSheet(
                    habit: HabitDetailViewModel(
                      title: 'Tomar agua',
                      currentStreak: 6,
                      longestStreak: 14,
                      accentColor: HabituColors.primary,
                      logs: [
                        HabitDetailLogViewModel(
                          completedAt: DateTime(2026, 6, 23, 8, 0),
                          notes: 'Me sentÃ­ con mÃ¡s energÃ­a.',
                          evidencePath: null,
                        ),
                        HabitDetailLogViewModel(
                          completedAt: DateTime(2026, 6, 22, 8, 15),
                          notes: 'Cumplido antes de salir.',
                          evidencePath: null,
                        ),
                      ],
                    ),
                    onEdit: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
        WidgetbookFolder(
          name: 'Social',
          children: [
            WidgetbookComponent(
              name: 'Ranking Card',
              useCases: [
                WidgetbookUseCase(
                  name: 'Top 3',
                  builder: (context) => const Padding(
                    padding: EdgeInsets.all(24),
                    child: RankingCard(
                      entry: RankingCardViewModel(
                        rank: 1,
                        fullName: 'Daniel Castro',
                        habitTitle: 'Leer 20 minutos',
                        currentStreak: 21,
                        longestStreak: 34,
                        avatarUrl: null,
                        accentColor: HabituColors.primary,
                        initials: 'DC',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Friend Card',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(24),
                    child: FriendCard(
                      friend: const FriendCardViewModel(
                        fullName: 'Luciana Mendez',
                        subtitle: 'PsicologÃ­a',
                        avatarUrl: null,
                        initials: 'LM',
                      ),
                      actionLabel: 'Ver rachas',
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Challenge Card',
              useCases: [
                WidgetbookUseCase(
                  name: 'Joinable',
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(24),
                    child: ChallengeCard(
                      challenge: const ChallengeCardViewModel(
                        title: '7 dÃ­as de enfoque',
                        description: 'Completa tu bloque de estudio diario durante una semana.',
                        category: 'estudio',
                        dateRangeLabel: '2026-06-23 â€“ 2026-06-30',
                        participantsLabel: '12/30',
                        isJoined: false,
                        isFull: false,
                      ),
                      onJoin: () {},
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Contact Sync Sheet',
              useCases: [
                WidgetbookUseCase(
                  name: 'Found Peers',
                  builder: (context) => ContactSyncSheet(
                    isSyncing: false,
                    isSynced: true,
                    foundPeers: const [
                      ContactPeerViewModel(
                        name: 'Daniel Castro',
                        subtitle: 'Ing. Sistemas',
                        initials: 'DC',
                      ),
                      ContactPeerViewModel(
                        name: 'Luciana Mendez',
                        subtitle: 'PsicologÃ­a',
                        initials: 'LM',
                      ),
                    ],
                    following: const {'Daniel Castro'},
                    onStartSync: () {},
                    onToggleFollowing: (_) {},
                    onDone: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
      appBuilder: (context, child) {
        return MaterialApp(
          theme: HabituTheme.lightTheme,
          darkTheme: HabituTheme.darkTheme,
          home: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SafeArea(child: child),
          ),
        );
      },
    );
  }
}

