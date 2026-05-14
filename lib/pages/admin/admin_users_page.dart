import 'package:flutter/material.dart';

import '../../services/admin_status_service.dart';
import '../../theme/app_theme.dart';

class AdminUsersPage extends StatefulWidget {
  const AdminUsersPage({super.key});

  @override
  State<AdminUsersPage> createState() => _AdminUsersPageState();
}

class _AdminUsersPageState extends State<AdminUsersPage> {
  final adminStatusService = AdminStatusService();

  bool isLoading = true;

  String searchText = '';
  String selectedFilter = 'Tất cả';

  List<Map<String, String>> users = [
    {
      'name': 'Admin',
      'username': 'admin',
      'date': '14/05/2026',
      'status': 'Quản trị viên',
    },
    {
      'name': 'Người dùng 1',
      'username': 'user1',
      'date': '13/05/2026',
      'status': 'Người mới',
    },
    {
      'name': 'Người dùng 2',
      'username': 'user2',
      'date': '12/05/2026',
      'status': 'VIP',
    },
  ];

  @override
  void initState() {
    super.initState();
    loadUserStatus();
  }

  Future<void> loadUserStatus() async {
    for (int i = 0; i < users.length; i++) {
      final username = users[i]['username']!;

      final savedStatus = await adminStatusService.getUserStatus(username);

      if (savedStatus != null) {
        users[i] = {...users[i], 'status': savedStatus};
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  List<Map<String, String>> get filteredUsers {
    return users.where((user) {
      final keyword = searchText.toLowerCase();

      final matchSearch =
          user['name']!.toLowerCase().contains(keyword) ||
          user['username']!.toLowerCase().contains(keyword);

      bool matchFilter = true;

      switch (selectedFilter) {
        case 'VIP':
          matchFilter = user['status'] == 'VIP';
          break;

        case 'Người mới':
          matchFilter = user['status'] == 'Người mới';
          break;

        case 'Đã chặn':
          matchFilter = user['status'] == 'Đã chặn';
          break;
      }

      return matchSearch && matchFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    if (isLoading) {
      return Scaffold(
        backgroundColor: colors.bg,
        body: Center(child: CircularProgressIndicator(color: colors.accent)),
      );
    }

    return Scaffold(
      backgroundColor: colors.bg,
      appBar: AppBar(title: const Text('Người dùng')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                style: TextStyle(color: colors.text),
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm người dùng',
                  hintStyle: TextStyle(color: colors.textSoft),
                  prefixIcon: Icon(Icons.search, color: colors.textSoft),
                  filled: true,
                  fillColor: colors.card,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(color: colors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(color: colors.accent),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _FilterButton(
                      text: 'Tất cả',
                      isSelected: selectedFilter == 'Tất cả',
                      onTap: () {
                        setState(() {
                          selectedFilter = 'Tất cả';
                        });
                      },
                    ),

                    const SizedBox(width: 8),

                    _FilterButton(
                      text: 'VIP',
                      isSelected: selectedFilter == 'VIP',
                      onTap: () {
                        setState(() {
                          selectedFilter = 'VIP';
                        });
                      },
                    ),

                    const SizedBox(width: 8),

                    _FilterButton(
                      text: 'Người mới',
                      isSelected: selectedFilter == 'Người mới',
                      onTap: () {
                        setState(() {
                          selectedFilter = 'Người mới';
                        });
                      },
                    ),

                    const SizedBox(width: 8),

                    _FilterButton(
                      text: 'Đã chặn',
                      isSelected: selectedFilter == 'Đã chặn',
                      onTap: () {
                        setState(() {
                          selectedFilter = 'Đã chặn';
                        });
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'Tổng người dùng: ${filteredUsers.length}',
                style: TextStyle(
                  color: colors.text,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 16),

              Expanded(
                child: filteredUsers.isEmpty
                    ? Center(
                        child: Text(
                          'Không tìm thấy người dùng',
                          style: TextStyle(color: colors.textSoft),
                        ),
                      )
                    : ListView.separated(
                        itemCount: filteredUsers.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 14),
                        itemBuilder: (context, index) {
                          final user = filteredUsers[index];

                          return Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: colors.card,
                              border: Border.all(color: colors.border),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 28,
                                  backgroundColor: colors.accent.withOpacity(
                                    0.18,
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    color: colors.accent,
                                    size: 28,
                                  ),
                                ),

                                const SizedBox(width: 16),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user['name']!,
                                        style: TextStyle(
                                          color: colors.text,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),

                                      const SizedBox(height: 4),

                                      Text(
                                        '@${user['username']}',
                                        style: TextStyle(
                                          color: colors.textSoft,
                                          fontSize: 13,
                                        ),
                                      ),

                                      const SizedBox(height: 8),

                                      Text(
                                        'Ngày tham gia: ${user['date']}',
                                        style: TextStyle(
                                          color: colors.textSoft,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: colors.bgSoft,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: colors.border,
                                        ),
                                      ),
                                      child: Text(
                                        user['status']!,
                                        style: TextStyle(
                                          color: colors.accent,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),

                                    PopupMenuButton<String>(
                                      color: colors.card,
                                      icon: Icon(
                                        Icons.more_vert,
                                        color: colors.text,
                                      ),
                                      onSelected: (value) async {
                                        final originalIndex = users.indexWhere(
                                          (u) =>
                                              u['username'] == user['username'],
                                        );

                                        if (originalIndex == -1) return;

                                        setState(() {
                                          users[originalIndex] = {
                                            ...users[originalIndex],
                                            'status': value,
                                          };
                                        });

                                        await adminStatusService.saveUserStatus(
                                          user['username']!,
                                          value,
                                        );
                                      },
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          value: 'Quản trị viên',
                                          child: Text(
                                            'Quản trị viên',
                                            style: TextStyle(
                                              color: colors.text,
                                            ),
                                          ),
                                        ),

                                        PopupMenuItem(
                                          value: 'VIP',
                                          child: Text(
                                            'VIP',
                                            style: TextStyle(
                                              color: colors.text,
                                            ),
                                          ),
                                        ),

                                        PopupMenuItem(
                                          value: 'Người mới',
                                          child: Text(
                                            'Người mới',
                                            style: TextStyle(
                                              color: colors.text,
                                            ),
                                          ),
                                        ),

                                        PopupMenuItem(
                                          value: 'Đã chặn',
                                          child: Text(
                                            'Đã chặn',
                                            style: TextStyle(
                                              color: colors.text,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
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

class _FilterButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: isSelected ? colors.accent : colors.card2,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isSelected ? colors.accent : colors.border),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : colors.text,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
