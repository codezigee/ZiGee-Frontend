import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zigee_app/app/mock/mock_room_data.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/size_tokens.dart';
import 'package:zigee_app/app/theme/spacing_tokens.dart';
import 'package:zigee_app/app/theme/typography_styles.dart';
import 'package:zigee_app/common/widgets/custom_dialog.dart';
import 'package:zigee_app/common/widgets/custom_snackbar.dart';
import 'package:zigee_app/common/widgets/custom_text_button.dart';
import 'package:zigee_app/models/room.dart';

class AvailableRoomListScreen extends StatefulWidget {
  final DateTime selectedDate;
  final TimeOfDay selectedStartTime;
  final int selectedDurationMinutes;

  const AvailableRoomListScreen({
    super.key,
    required this.selectedDate,
    required this.selectedStartTime,
    required this.selectedDurationMinutes,
  });

  @override
  State<AvailableRoomListScreen> createState() =>
      _AvailableRoomListScreenState();
}

class _AvailableRoomListScreenState extends State<AvailableRoomListScreen> {
  Room? _selectedRoom;

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  TimeOfDay _calculateEndTime(TimeOfDay startTime, int durationMinutes) {
    final startMinutes = startTime.hour * 60 + startTime.minute;
    final endMinutes = startMinutes + durationMinutes;
    final endHour = (endMinutes ~/ 60) % 24;
    final endMinute = endMinutes % 60;
    return TimeOfDay(hour: endHour, minute: endMinute);
  }

  @override
  Widget build(BuildContext context) {
    final endTime = _calculateEndTime(
      widget.selectedStartTime,
      widget.selectedDurationMinutes,
    );
    final formattedDate =
        '${widget.selectedDate.year}년 ${widget.selectedDate.month}월 ${widget.selectedDate.day}일';
    final timeRange =
        '${_formatTime(widget.selectedStartTime)} - ${_formatTime(endTime)}';

    return Scaffold(
      appBar: CupertinoNavigationBar(
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: const Icon(Icons.arrow_back_ios_new),
        ),
        middle: const Text('회의실 선택', style: TypographyStyles.titleLarge),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(SpacingTokens.lg),
              margin: const EdgeInsets.only(
                top: SpacingTokens.lg,
                left: SpacingTokens.lg,
                right: SpacingTokens.lg,
              ),
              decoration: BoxDecoration(
                color: ColorTokens.white,
                border: Border.all(
                  color: ColorTokens.borderSecondary,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(SizingTokens.radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '예약 조건',
                    style: TypographyStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: SpacingTokens.sm),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: ColorTokens.gray600,
                      ),
                      const SizedBox(width: SpacingTokens.xs),
                      Text(formattedDate, style: TypographyStyles.bodyMedium),
                    ],
                  ),
                  const SizedBox(height: SpacingTokens.xs),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 16,
                        color: ColorTokens.gray600,
                      ),
                      const SizedBox(width: SpacingTokens.xs),
                      Text(timeRange, style: TypographyStyles.bodyMedium),
                      const SizedBox(width: SpacingTokens.sm),
                      Text(
                        '(${widget.selectedDurationMinutes}분)',
                        style: TypographyStyles.bodySmall.copyWith(
                          color: ColorTokens.gray600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child:
                  MockRoomData.rooms.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                        padding: const EdgeInsets.all(SpacingTokens.lg),
                        physics: const ClampingScrollPhysics(),
                        itemCount: MockRoomData.rooms.length,
                        itemBuilder: (context, index) {
                          final room = MockRoomData.rooms[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: SpacingTokens.sm,
                            ),
                            child: _buildRoomCard(context, room),
                          );
                        },
                      ),
              // _buildEmptyState(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: SpacingTokens.sm,
                children: [
                  const Icon(
                    Icons.search_off,
                    size: SizingTokens.iconHuge,
                    color: ColorTokens.gray400,
                  ),
                  Text(
                    '선택한 시간에 예약 가능한\n회의실이 없습니다.',
                    textAlign: TextAlign.center,
                    style: TypographyStyles.bodyMedium.copyWith(
                      color: ColorTokens.gray600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(flex: 2, child: _buildRandomRoomList()),
        ],
      ),
    );
  }

  Widget _buildRandomRoomList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SpacingTokens.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: SpacingTokens.sm,
        children: [
          Text(
            '대신 비슷한 시간대의\n회의실을 추천해드릴게요.',
            textAlign: TextAlign.start,
            style: TypographyStyles.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Flexible(
            child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              itemCount: MockRoomData.rooms.length,
              itemBuilder: (context, index) {
                final room = MockRoomData.rooms[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: SpacingTokens.sm,
                  ),
                  child: _buildRoomCard(context, room),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomCard(BuildContext context, Room room) {
    return Container(
      decoration: BoxDecoration(
        color: ColorTokens.white,
        borderRadius: BorderRadius.circular(SizingTokens.radiusMd),
        border: Border.all(
          color:
              _selectedRoom == room
                  ? ColorTokens.borderFocus
                  : ColorTokens.borderPrimary,
        ),
      ),
      child: InkWell(
        onTap: () {
          if (_selectedRoom != room) {
            setState(() {
              _selectedRoom = room;
            });
          } else {
            setState(() {
              _selectedRoom = null;
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(SpacingTokens.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          room.name,
                          style: TypographyStyles.titleMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: SpacingTokens.xs),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 14,
                              color: ColorTokens.gray600,
                            ),
                            const SizedBox(width: SpacingTokens.xs),
                            Text(
                              room.location,
                              style: TypographyStyles.bodySmall.copyWith(
                                color: ColorTokens.gray600,
                              ),
                            ),
                            const SizedBox(width: SpacingTokens.sm),
                            const Icon(
                              Icons.people,
                              size: 14,
                              color: ColorTokens.gray600,
                            ),
                            const SizedBox(width: SpacingTokens.xs),
                            Text(
                              '${room.capacity}명',
                              style: TypographyStyles.bodySmall.copyWith(
                                color: ColorTokens.gray600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: SpacingTokens.sm,
                      vertical: SpacingTokens.xs,
                    ),
                    decoration: BoxDecoration(
                      color: ColorTokens.statusSuccess.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      '예약 가능',
                      style: TypographyStyles.bodySmall.copyWith(
                        color: ColorTokens.statusSuccess,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
