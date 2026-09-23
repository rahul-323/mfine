import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/constants.dart';
import '../core/interaction_feedback.dart';
import '../widgets/drawer_item.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  void _go(BuildContext context, String path) {
    Navigator.of(context).pop();
    context.push(path);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.centerLeft,
      child: Material(
        color: Colors.white,
        child: SizedBox(
          width: width > 650 ? 430 : width * .86,
          height: double.infinity,
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(22, 22, 14, 22),
                  decoration: const BoxDecoration(
                    color: Color(0xFF08A1BA),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(26),
                        bottomRight: Radius.circular(26)),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                          radius: 38,
                          backgroundColor: Color(0xFFEAF9FA),
                          child: Icon(Icons.person,
                              size: 44, color: AppConstants.tealDark)),
                      const SizedBox(width: 15),
                      const Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text('Disha S...',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 21,
                                    fontWeight: FontWeight.w900)),
                            SizedBox(height: 5),
                            Text('Health profile',
                                style: TextStyle(color: Colors.white70)),
                          ])),
                      IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: IconButton.styleFrom(
                              backgroundColor: Colors.white),
                          icon: const Icon(Icons.close_rounded)),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 18),
                    children: [
                      DrawerItem(
                          icon: Icons.medical_services_outlined,
                          title: 'Consult Now',
                          onTap: () => _go(context, '/consult')),
                      DrawerItem(
                          icon: Icons.favorite_border,
                          title: 'My Online Consultations',
                          onTap: () => _go(context, '/records')),
                      DrawerItem(
                          icon: Icons.person_search_outlined,
                          title: 'My Appointments',
                          onTap: () => _go(context, '/records')),
                      DrawerItem(
                          icon: Icons.calendar_month_outlined,
                          title: 'Book Appointment',
                          onTap: () => _go(context, '/consult')),
                      DrawerItem(
                          icon: Icons.verified_outlined,
                          title: 'My Self-Checks',
                          onTap: () => _go(context, '/self-check')),
                      DrawerItem(
                          icon: Icons.shopping_bag_outlined,
                          title: 'My Orders',
                          onTap: () => _go(context, '/records')),
                      DrawerItem(
                          icon: Icons.medical_services_outlined,
                          title: 'Book Health Packages',
                          onTap: () => _go(context, '/lab')),
                      DrawerItem(
                          icon: Icons.biotech_outlined,
                          title: 'Order Lab Test',
                          onTap: () => _go(context, '/lab')),
                      DrawerItem(
                          icon: Icons.medication_outlined,
                          title: 'Order Medicines',
                          onTap: () {
                            Navigator.of(context).pop();
                            showComingSoonDialog(context, 'Medicines');
                          }),
                      DrawerItem(
                          icon: Icons.spa_outlined,
                          title: 'Buy Skin Care Essentials',
                          onTap: () {
                            Navigator.of(context).pop();
                            showComingSoonDialog(
                                context, 'Skin care essentials');
                          }),
                      const Divider(height: 14),
                      DrawerItem(
                          icon: Icons.person_outline,
                          title: 'Profile',
                          onTap: () => _go(context, '/profile')),
                      DrawerItem(
                          icon: Icons.group_add_outlined,
                          title: 'Add Family Member',
                          onTap: () => _go(context, '/profile')),
                      DrawerItem(
                          icon: Icons.share_outlined,
                          title: 'Share This App',
                          onTap: () {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Share action is UI-only.')));
                          }),
                      const Divider(height: 14),
                      DrawerItem(
                          icon: Icons.folder_copy_outlined,
                          title: 'Records',
                          onTap: () => _go(context, '/records')),
                      DrawerItem(
                          icon: Icons.info_outline,
                          title: 'About mfine',
                          onTap: () => _go(context, '/about')),
                      DrawerItem(
                          icon: Icons.settings_outlined,
                          title: 'Settings',
                          onTap: () => _go(context, '/settings')),
                      DrawerItem(
                          icon: Icons.receipt_long_outlined,
                          title: 'Invoices',
                          onTap: () => _go(context, '/invoices')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
