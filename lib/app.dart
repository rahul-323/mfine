import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'core/theme.dart';
import 'core/constants.dart';
import 'core/mfine_loader.dart';
import 'screens/screens.dart';

class MFineApp extends StatelessWidget {
  const MFineApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (_, __) => const SplashScreen()),
        StatefulShellRoute.indexedStack(
          builder: (context, state, shell) => AppShell(navigationShell: shell),
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(path: '/home', builder: (_, __) => const HomeScreen())
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(path: '/lab', builder: (_, __) => const LabTestScreen())
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                    path: '/tools', builder: (_, __) => const FreeToolsScreen())
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                    path: '/consult', builder: (_, __) => const ConsultScreen())
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                    path: '/files',
                    builder: (_, __) => const HealthFilesScreen())
              ],
            ),
          ],
        ),
        GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
        GoRoute(
            path: '/self-check', builder: (_, __) => const SelfCheckScreen()),
        GoRoute(path: '/records', builder: (_, __) => const RecordsScreen()),
        GoRoute(path: '/about', builder: (_, __) => const AboutScreen()),
        GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
        GoRoute(path: '/invoices', builder: (_, __) => const InvoiceScreen()),
        GoRoute(
          path: '/invoice-detail',
          builder: (_, state) {
            final invoice = state.extra! as InvoiceModel;

            return InvoiceDetailScreen(
              invoice: invoice,
            );
          },
        ),
        GoRoute(
            path: '/consult-room',
            builder: (_, state) => ConsultationRoomScreen(
                  isDecemberRecord: state.extra == true,
                )),
      ],
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'MFine UI',
      theme: buildAppTheme(),
      routerConfig: router,
    );
  }
}

class AppShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const AppShell({super.key, required this.navigationShell});

  static const _paths = ['/home', '/lab', '/tools', '/consult', '/files'];

  Future<void> _go(BuildContext context, int index) async {
    await runWithMfineLoader(
      context,
      () async {
        navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        );
      },
      message: 'Loading your health space...',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _chatFab(context),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.only(bottom: 4),
        child: Container(
          height: 82,
          margin: const EdgeInsets.fromLTRB(12, 0, 12, 8),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 22,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(5, (index) {
              final selected = navigationShell.currentIndex == index;
              final isCenterRed = index == 2;
              final itemData = [
                ('Active Zone', 'assets/icons/run.png'),
                ('Lab Tests', 'assets/icons/microscope.png'),
                ('Consult now', 'assets/icons/chat-app.png'),
                ('Medicines', 'assets/icons/pills-bottle.png'),
                ('My Orders', 'assets/icons/parcel.png'),
              ][index];

              return Expanded(
                child: GestureDetector(
                  onTap: () => _go(context, index),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _bottomNavIcon(
                          itemData.$2,
                          selected && isCenterRed
                              ? true
                              : selected && !isCenterRed
                                  ? true
                                  : false,
                          isCenterRed: isCenterRed,
                        ),
                        const SizedBox(height: 4),
                        Flexible(
                          child: Text(
                            itemData.$1,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight:
                                  selected ? FontWeight.w700 : FontWeight.w500,
                              color: selected
                                  ? (isCenterRed
                                      ? const Color(0xFFFF5A5A)
                                      : AppConstants.primary)
                                  : const Color(0xFF7C7C7C),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _bottomNavIcon(
    String assetPath,
    bool selected, {
    bool isCenterRed = false,
  }) {
    return SizedBox(
      width: 20,
      height: 20,
      child: Image.asset(
        assetPath,
        color: selected
            ? (isCenterRed ? const Color(0xFFFF5A5A) : AppConstants.primary)
            : const Color(0xFF7C7C7C),
        package: null,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _chatFab(BuildContext context) {
    return Hero(
      tag: 'chat_fab',
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
                color: Color(0x3300BFA5), blurRadius: 16, spreadRadius: 2),
          ],
        ),
        child: FloatingActionButton(
          heroTag: null,
          backgroundColor: AppConstants.primary,
          foregroundColor: Colors.white,
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Support chat is currenlty down')),
          ),
          child: const Icon(Icons.chat_bubble_rounded),
        ),
      ),
    );
  }

  // Kept here so the shell remains straightforward if route mapping is extended.
  static List<String> get paths => _paths;
}
