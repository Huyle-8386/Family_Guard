import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final members = [
      _Member(
        name: 'Lê Văn Huy (Bố)',
        status: 'Đang đi dạo',
        statusColor: const Color(0xFFEAB308),
        battery: 24,
        batteryColor: const Color(0xFFCA8A04),
        avatarUrl: 'https://i.pravatar.cc/150?img=12',
      ),
      _Member(
        name: 'Như Quỳnh (Mẹ)',
        status: 'Đang ở nhà',
        statusColor: const Color(0xFF04B8BA),
        battery: 85,
        batteryColor: const Color(0xFF00ADB2),
        avatarUrl: 'https://i.pravatar.cc/150?img=47',
      ),
      _Member(
        name: 'Lê Như Kha (Em)',
        status: 'Không rõ',
        statusColor: const Color(0xFFFF5A5A),
        battery: 24,
        batteryColor: const Color(0xFFFF5A5A),
        avatarUrl: 'https://i.pravatar.cc/150?img=64',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false, // bỏ status bar giả phía trên
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildCircleButton(
                    icon: Icons.arrow_back_ios_new,
                    onTap: () => print("Back button tapped"),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildSearchBar(
                      controller: _searchController,
                      onMicTap: () => print('Mic tapped'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  _buildCircleButton(
                    icon: Icons.add,
                    onTap: () => print("Add button tapped"),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              const Text(
                'Danh sách thành viên',
                style: TextStyle(
                  color: Color(0xFF00ACB1),
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  height: 1.1,
                  fontFamily: 'Sarala',
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  itemCount: members.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final member = members[index];
                    return _MemberCard(member: member);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Member {
  const _Member({
    required this.name,
    required this.status,
    required this.statusColor,
    required this.battery,
    required this.batteryColor,
    required this.avatarUrl,
  });

  final String name;
  final String status;
  final Color statusColor;
  final int battery;
  final Color batteryColor;
  final String avatarUrl;
}

class _MemberCard extends StatelessWidget {
  const _MemberCard({required this.member});

  final _Member member;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF87E4DB),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 6,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.network(
                member.avatarUrl,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: const Color(0xFFE0E0E0),
                  child: const Icon(Icons.person, color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.name,
                  style: const TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Public Sans',
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                     Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(999),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x14000000),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _StatusDot(color: member.statusColor),
                      const SizedBox(width: 8),
                      Text(
                        member.status,
                        style: const TextStyle(
                          color: Color(0xFF374151),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Public Sans',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  member.battery >= 30 ? Icons.battery_full : Icons.battery_alert,
                  size: 18,
                  color: member.batteryColor,
                ),
                const SizedBox(width: 4),
                Text(
                  '${member.battery}%',
                  style: const TextStyle(
                    color: Color(0xFF4B5563),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Public Sans',
                  ),
                ),
              ],
            ),
          ),
                ],)
              ],
            ),
          ),
          const SizedBox(width: 12),
          
        ],
      ),
    );
  }
}

class _StatusDot extends StatelessWidget {
  const _StatusDot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

Widget _buildCircleButton({required IconData icon, required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Icon(icon, color: const Color(0xFF00ACB1)),
    ),
  );
}

Widget _buildSearchBar({required TextEditingController controller, required VoidCallback onMicTap}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: const Color(0xFF87E4DB),
      borderRadius: BorderRadius.circular(999),
    ),
    child: Row(
      children: [
        const Icon(Icons.search, size: 22, color: Color(0xFF333333)),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              isDense: true,
              hintText: 'Tìm thành viên',
              hintStyle: TextStyle(
                color: Color(0x993C3C43),
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'SF Pro',
              ),
              border: InputBorder.none,
            ),
            style: const TextStyle(
              color: Color(0xFF333333),
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'SF Pro',
            ),
            textInputAction: TextInputAction.search,
          ),
        ),
        GestureDetector(
          onTap: onMicTap,
          behavior: HitTestBehavior.opaque,
          child: const Icon(Icons.mic, size: 22, color: Color(0xFF333333)),
        ),
      ],
    ),
  );
}