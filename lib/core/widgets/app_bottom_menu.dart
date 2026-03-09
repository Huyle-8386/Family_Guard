import 'package:flutter/material.dart';
import 'package:family_guard/core/constants/app_routes.dart';

enum AppNavTab { home, tracking, notifications, settings }

class AppBottomMenu extends StatelessWidget {
	const AppBottomMenu({super.key, required this.current});

	final AppNavTab current;

	@override
	Widget build(BuildContext context) {
		return Container(
			margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
			padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
			decoration: BoxDecoration(
				color: const Color(0xFFFFFFFF),
				borderRadius: BorderRadius.circular(24),
			),
			child: Row(
				children: [
					Expanded(
						child: _MenuItem(
							icon: Icons.dashboard_outlined,
							activeIcon: Icons.dashboard,
							active: current == AppNavTab.home,
							onTap: () => _goTo(context, AppNavTab.home),
						),
					),
					Expanded(
						child: _MenuItem(
							icon: Icons.map_outlined,
							activeIcon: Icons.map,
							active: current == AppNavTab.tracking,
							onTap: () => _goTo(context, AppNavTab.tracking),
						),
					),
					Expanded(
						child: _MenuItem(
							icon: Icons.notifications_none_rounded,
							activeIcon: Icons.notifications_rounded,
							active: current == AppNavTab.notifications,
							onTap: () => _goTo(context, AppNavTab.notifications),
						),
					),
					Expanded(
						child: _MenuItem(
							icon: Icons.person_outline_rounded,
							activeIcon: Icons.person_rounded,
							active: current == AppNavTab.settings,
							onTap: () => _goTo(context, AppNavTab.settings),
						),
					),
				],
			),
		);
	}

	void _goTo(BuildContext context, AppNavTab tab) {
		if (tab == current) return;

		final String routeName;
		switch (tab) {
			case AppNavTab.home:
				routeName = AppRoutes.home;
				break;
			case AppNavTab.tracking:
				routeName = AppRoutes.tracking;
				break;
			case AppNavTab.notifications:
				routeName = AppRoutes.notifications;
				break;
			case AppNavTab.settings:
				routeName = AppRoutes.settings;
				break;
		}

		Navigator.pushNamed(context, routeName);
	}
}

class _MenuItem extends StatelessWidget {
	const _MenuItem({
		required this.icon,
		required this.activeIcon,
		required this.active,
		required this.onTap,
	});

	final IconData icon;
	final IconData activeIcon;
	final bool active;
	final VoidCallback onTap;

	@override
	Widget build(BuildContext context) {
		return InkWell(
			borderRadius: BorderRadius.circular(999),
			onTap: onTap,
			child: AnimatedContainer(
				duration: const Duration(milliseconds: 180),
				curve: Curves.easeOut,
				width: 48,
				height: 48,
				decoration: BoxDecoration(
					shape: BoxShape.circle,
					color: active ? const Color(0xFF0FAEB3) : Colors.transparent,
					boxShadow: active
							? const [
									BoxShadow(
										color: Color(0x330FAEB3),
										blurRadius: 10,
										offset: Offset(0, 4),
									),
								]
							: null,
				),
				child: Icon(
					active ? activeIcon : icon,
					color: active ? Colors.white : const Color(0xFF8E96A3),
					size: 21,
				),
			),
		);
	}
}
