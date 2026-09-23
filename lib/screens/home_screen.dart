import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../core/constants.dart';
import '../core/interaction_feedback.dart';
import '../widgets/banner_card.dart';
import '../widgets/search_bar.dart';
import '../widgets/section_header.dart';
import '../widgets/service_card.dart';
import 'drawer_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _banner = 0;

  void _openDrawer(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Menu',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 260),
      pageBuilder: (_, __, ___) => const DrawerScreen(),
      transitionBuilder: (_, animation, __, child) => SlideTransition(
        position:
            Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
        ),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.softBackground,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              toolbarHeight: 76,
              leadingWidth: 72,
              leading: IconButton(
                onPressed: () => _openDrawer(context),
                icon: const Icon(Icons.menu_rounded, size: 34),
              ),
              titleSpacing: 0,
              title: Row(
                children: [
                  Container(
                    height: 44,
                    width: 44,
                    decoration: BoxDecoration(
                      color: AppConstants.teal,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.monitor_heart_rounded,
                        color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 8),
                  const Text('mfine',
                      style: TextStyle(
                          color: AppConstants.tealDark,
                          fontSize: 31,
                          fontWeight: FontWeight.w900)),
                ],
              ),
              actions: [
                IconButton(
                    onPressed: () => showComingSoonDialog(context, 'Wallet'),
                    icon: const Icon(Icons.account_balance_wallet_outlined)),
                IconButton(
                    onPressed: () =>
                        showComingSoonDialog(context, 'Notifications'),
                    icon: const Icon(Icons.notifications_none_rounded)),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => context.go('/profile'),
                    child: const CircleAvatar(
                      radius: 16,
                      backgroundColor: AppConstants.teal,
                      child: Icon(
                        Icons.person,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Hi, Disha 👋',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 4),
                    const Text('How can we help you today?',
                        style:
                            TextStyle(color: AppConstants.muted, fontSize: 14)),
                    const SizedBox(height: 16),
                    const MFineSearchBar(),
                    const SizedBox(height: 18),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 180,
                        viewportFraction: 1,
                        enlargeCenterPage: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 4),
                        onPageChanged: (index, _) =>
                            setState(() => _banner = index),
                      ),
                      items: const [
                        BannerCard(
                          title: "Smarter Weight Loss\npowered by GLP-1",
                          subtitle:
                              'Structured. Supervised. Personalised. Only with mfine.',
                          image: 'assets/images/hero_consult.jpg',
                        ),
                        BannerCard(
                          title: "Consult India's\nTop Doctors Online",
                          subtitle: '1st consultation starting at ₹149.',
                        ),
                        BannerCard(
                          title: 'Health checks,\nwithout the waiting room.',
                          subtitle: 'Book reliable lab services near you.',
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: AnimatedSmoothIndicator(
                        activeIndex: _banner,
                        count: 3,
                        effect: const WormEffect(
                            dotHeight: 7,
                            dotWidth: 7,
                            activeDotColor: AppConstants.teal,
                            dotColor: Color(0xFFCCD9DC)),
                      ),
                    ),
                    const SizedBox(height: 18),
                    const SectionHeader(title: 'Quick services'),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1.24,
                      children: [
                        ServiceCard(
                            title: 'Consult Now',
                            subtitle: 'Talk to a doctor',
                            icon: Icons.medical_services_outlined,
                            accent: AppConstants.teal,
                            onTap: () => context.go('/consult')),
                        ServiceCard(
                            title: 'Lab Tests',
                            subtitle: 'At-home samples',
                            icon: Icons.biotech_outlined,
                            accent: const Color(0xFF7B61FF),
                            onTap: () => context.go('/lab')),
                        ServiceCard(
                            title: 'Free Tools',
                            subtitle: 'Check your health',
                            icon: Icons.health_and_safety_outlined,
                            accent: const Color(0xFF00A676),
                            onTap: () => context.go('/tools')),
                        ServiceCard(
                            title: 'Health Files',
                            subtitle: 'Keep reports safe',
                            icon: Icons.folder_copy_outlined,
                            accent: const Color(0xFFFF8A4C),
                            onTap: () => context.go('/files')),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const SectionHeader(
                        title: 'Select Specialty', action: 'View all'),
                    SizedBox(
                      height: 142,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 6,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (_, i) {
                          final item = SpecialtyData.items[i];
                          return SizedBox(
                            width: 124,
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(17),
                                  child: Image.asset(item.asset,
                                      width: 124,
                                      height: 94,
                                      fit: BoxFit.cover),
                                ),
                                const SizedBox(height: 8),
                                Text(item.title,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12.5)),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    _trustStrip(),
                    const SizedBox(height: 18),
                    const SectionHeader(title: 'Offers for you'),
                    _offerCard('20% off on first lab booking', 'Use code MF20',
                        Icons.local_offer_outlined),
                    const SizedBox(height: 12),
                    _offerCard('Free doctor follow-up', 'On selected plans',
                        Icons.verified_outlined),
                    const SizedBox(height: 20),
                    const SectionHeader(title: 'Nearby healthcare'),
                    _nearbyCard(),
                    const SizedBox(height: 105),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _trustStrip() {
    final stats = const [
      ('10L+', 'Trusted\\nUsers', Icons.groups_outlined),
      ('600+', 'NABL & NABH\\nLabs', Icons.biotech_outlined),
      ('AERB', 'Approved', Icons.workspace_premium_outlined),
    ];
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Row(
        children: stats
            .map((e) => Expanded(
                  child: Row(children: [
                    Container(
                      height: 38,
                      width: 38,
                      decoration: BoxDecoration(
                          color: const Color(0xFFE8F8FB),
                          borderRadius: BorderRadius.circular(12)),
                      child: Icon(e.$3, color: AppConstants.tealDark, size: 22),
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                        child: Text('${e.$1}\n${e.$2}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 11.5))),
                  ]),
                ))
            .toList(),
      ),
    );
  }

  Widget _offerCard(String title, String subtitle, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7EF),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFFFE2C4)),
      ),
      child: Row(children: [
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(14)),
          child: Icon(icon, color: AppConstants.coral),
        ),
        const SizedBox(width: 12),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: const TextStyle(color: AppConstants.muted, fontSize: 12)),
        ])),
        const Icon(Icons.chevron_right),
      ]),
    );
  }

  Widget _nearbyCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
              color: Color(0x10000000), blurRadius: 14, offset: Offset(0, 7))
        ],
      ),
      child: Row(children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
              color: const Color(0xFFEAF9FA),
              borderRadius: BorderRadius.circular(15)),
          child: const Icon(Icons.local_hospital_outlined,
              color: AppConstants.tealDark),
        ),
        const SizedBox(width: 12),
        const Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('mfine Healthcare',
              style: TextStyle(fontWeight: FontWeight.w900)),
          SizedBox(height: 4),
          Text('Trusted clinics near your location',
              style: TextStyle(color: AppConstants.muted, fontSize: 12)),
        ])),
        FilledButton(
            onPressed: () => showComingSoonDialog(context, 'Nearby clinics'),
            child: const Text('View')),
      ]),
    );
  }
}
