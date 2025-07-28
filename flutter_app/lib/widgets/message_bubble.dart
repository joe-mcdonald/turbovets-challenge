import 'package:flutter/material.dart';
// import 'package:flutter_app/chat_screen.dart';

class MessageBubble extends StatefulWidget {
  final String text;
  final bool isUser;
  final DateTime? timestamp;

  const MessageBubble({
    super.key,
    required this.text,
    required this.isUser,
    this.timestamp,
  });

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  double _dragOffset = 0.0;
  bool _isDragging = false;

  // Format time for display
  String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Start dragging
      onPanStart: (details) {
        setState(() {
          _isDragging = true;
          _dragOffset = 0.0;
        });
      },
      onPanUpdate: (details) {
        setState(() {
          if (details.delta.dx < 0) {
            _dragOffset += details.delta.dx;
            _dragOffset = _dragOffset.clamp(-60.0, 0.0); // Limit drag to left
          }
        });
      },
      onPanEnd: (details) {
        setState(() {
          _isDragging = false;
          _dragOffset = 0.0; // Reset offset after drag ends
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: Stack(
          children: [
            if (widget.timestamp != null) // Show timestamp if available
              Positioned(
                right: 20,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Text(
                    _formatTime(widget.timestamp!),
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                ),
              ),
            Transform.translate(
              // Apply drag offset
              offset: Offset(_dragOffset, 0),
              // Wrap message in a container to get the correct alignment
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                width:
                    !widget.isUser ? MediaQuery.of(context).size.width : null,
                child: Align(
                  alignment:
                      widget.isUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 8.0,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 14.0,
                    ),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    decoration: BoxDecoration(
                      color:
                          widget.isUser
                              ? Colors.blueAccent
                              : Theme.of(context).cardTheme.color,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(12),
                        topRight: const Radius.circular(12),
                        // Adjust bottom corners based on sender
                        bottomLeft: Radius.circular(widget.isUser ? 12 : 0),
                        bottomRight: Radius.circular(widget.isUser ? 0 : 12),
                      ),
                    ),
                    child: Text(
                      widget.text,
                      style: TextStyle(
                        color:
                            widget.isUser
                                ? Colors.white
                                : Theme.of(context).textTheme.bodyLarge?.color,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
