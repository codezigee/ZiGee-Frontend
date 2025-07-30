import 'package:flutter/material.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/size_tokens.dart';
import 'package:zigee_app/app/theme/spacing_tokens.dart';
import 'package:zigee_app/app/theme/typography_styles.dart';
import 'package:zigee_app/features/booking/widgets/room_card.dart';
import 'package:zigee_app/models/room.dart';

class RoomCardList extends StatefulWidget {
  final List<Room> rooms;
  Room? selectedRoom;

  RoomCardList({super.key, required this.rooms, this.selectedRoom});

  @override
  State<RoomCardList> createState() => _RoomCardListState();
}

class _RoomCardListState extends State<RoomCardList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:
          widget.rooms.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                padding: const EdgeInsets.all(SpacingTokens.lg),
                physics: const ClampingScrollPhysics(),
                itemCount: widget.rooms.length,
                itemBuilder: (context, index) {
                  final room = widget.rooms[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: SpacingTokens.sm,
                    ),
                    child: RoomCard(
                      room: room,
                      isSelected: widget.selectedRoom == room,
                      onTap: () {
                        if (widget.selectedRoom != room) {
                          setState(() {
                            widget.selectedRoom = room;
                          });
                        } else {
                          setState(() {
                            widget.selectedRoom = null;
                          });
                        }
                      },
                    ),
                  );
                },
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
              itemCount: widget.rooms.length,
              itemBuilder: (context, index) {
                final room = widget.rooms[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: SpacingTokens.sm,
                  ),
                  child: RoomCard(
                    room: room,
                    isSelected: widget.selectedRoom == room,
                    onTap: () {
                      if (widget.selectedRoom != room) {
                        setState(() {
                          widget.selectedRoom = room;
                        });
                      } else {
                        setState(() {
                          widget.selectedRoom = null;
                        });
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
