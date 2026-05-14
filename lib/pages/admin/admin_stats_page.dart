import 'package:flutter/material.dart';

import '../../models/game_model.dart';
import '../../services/game_service.dart';
import '../../theme/app_theme.dart';

class AdminStatsPage extends StatefulWidget {
  const AdminStatsPage({super.key});

  @override
  State<AdminStatsPage> createState() => _AdminStatsPageState();
}

class _AdminStatsPageState extends State<AdminStatsPage> {
  final gameService = GameService();

  List<GameModel> games = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadGames();
  }

  Future<void> loadGames() async {
    final data = await gameService.getGames();

    setState(() {
      games = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final approvedCount = games.where((g) => g.status == 'approved').length;
    final pendingCount = games.where((g) => g.status == 'pending').length;
    final rejectedCount = games.where((g) => g.status == 'rejected').length;

    return Scaffold(
      backgroundColor: colors.bg,
      appBar: AppBar(title: const Text('Thống kê')),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: colors.accent))
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: colors.card,
                        border: Border.all(color: colors.border),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tổng quan',
                            style: TextStyle(
                              color: colors.text,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: _MiniStat('Đã duyệt', '$approvedCount'),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _MiniStat('Chờ duyệt', '$pendingCount'),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _MiniStat(
                                  'Tổng game',
                                  '${games.length}',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    _ChartCard(
                      title: 'Biểu đồ trạng thái game',
                      children: [
                        _BarRow(
                          'Đã duyệt',
                          approvedCount,
                          games.length,
                          Colors.green,
                        ),
                        _BarRow(
                          'Chờ duyệt',
                          pendingCount,
                          games.length,
                          Colors.orange,
                        ),
                        _BarRow(
                          'Từ chối',
                          rejectedCount,
                          games.length,
                          Colors.red,
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    _ChartCard(
                      title: 'Lượt chơi trong tuần',
                      children: const [_FakeColumnChart()],
                    ),

                    const SizedBox(height: 24),

                    Text(
                      'Thống kê chi tiết',
                      style: TextStyle(
                        color: colors.text,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 16),

                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 1.2,
                      children: [
                        const _DetailBox('Người dùng', '12', Icons.people),
                        _DetailBox(
                          'Trò chơi',
                          '${games.length}',
                          Icons.sports_esports,
                        ),
                        const _DetailBox('Doanh thu', '0đ', Icons.payments),
                        const _DetailBox(
                          'Tăng trưởng',
                          '0%',
                          Icons.trending_up,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class _ChartCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _ChartCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: colors.text,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}

class _BarRow extends StatelessWidget {
  final String label;
  final int value;
  final int total;
  final Color color;

  const _BarRow(this.label, this.value, this.total, this.color);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final percent = total == 0 ? 0.0 : value / total;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          SizedBox(
            width: 72,
            child: Text(
              label,
              style: TextStyle(color: colors.textSoft, fontSize: 12),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: percent,
                minHeight: 12,
                backgroundColor: colors.bgSoft,
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '$value',
            style: TextStyle(color: colors.text, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _FakeColumnChart extends StatelessWidget {
  const _FakeColumnChart();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final data = [
      {'day': 'T2', 'value': 70.0},
      {'day': 'T3', 'value': 95.0},
      {'day': 'T4', 'value': 55.0},
      {'day': 'T5', 'value': 120.0},
      {'day': 'T6', 'value': 80.0},
      {'day': 'T7', 'value': 140.0},
      {'day': 'CN', 'value': 100.0},
    ];

    return SizedBox(
      height: 170,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: data.map((item) {
          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: item['value'] as double,
                  width: 22,
                  decoration: BoxDecoration(
                    color: colors.accent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item['day'] as String,
                  style: TextStyle(color: colors.textSoft, fontSize: 12),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String title;
  final String value;

  const _MiniStat(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      height: 70,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colors.bgSoft,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: colors.textSoft, fontSize: 11)),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              color: colors.text,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailBox extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _DetailBox(this.title, this.value, this.icon);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.card,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: colors.accent),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              color: colors.text,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(title, style: TextStyle(color: colors.textSoft, fontSize: 13)),
        ],
      ),
    );
  }
}
