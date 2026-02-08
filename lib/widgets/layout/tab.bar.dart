import 'package:ankur_portfolio/providers/tab.management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class EditorTabBar extends StatelessWidget {
  const EditorTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TabManager>(
      builder: (context, tabManager, child) {
        if (tabManager.tabs.isEmpty) {
          return const SizedBox.shrink();
        }

        return Container(
          height: 35,
          decoration: const BoxDecoration(
            color: Color(0xFF2D2D30),
            border: Border(
              bottom: BorderSide(
                color: Color(0xFF1E1E1E),
                width: 1,
              ),
            ),
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tabManager.tabs.length,
            itemBuilder: (context, index) {
              final tab = tabManager.tabs[index];
              final isActive = tab.id == tabManager.activeTabId;

              return _TabItem(
                tab: tab,
                isActive: isActive,
                onTap: () {
                  tabManager.setActiveTab(tab.id);
                  context.go(tab.route);
                },
                onClose: () {
                  tabManager.closeTab(tab.id);
                  
                  // Navigate to the new active tab or home
                  final newActiveTab = tabManager.getActiveTab();
                  if (newActiveTab != null) {
                    context.go(newActiveTab.route);
                  } else {
                    context.go('/');
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}

class _TabItem extends StatefulWidget {
  final EditorTab tab;
  final bool isActive;
  final VoidCallback onTap;
  final VoidCallback onClose;

  const _TabItem({
    required this.tab,
    required this.isActive,
    required this.onTap,
    required this.onClose,
  });

  @override
  State<_TabItem> createState() => _TabItemState();
}

class _TabItemState extends State<_TabItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          constraints: const BoxConstraints(
            minWidth: 120,
            maxWidth: 200,
          ),
          decoration: BoxDecoration(
            color: widget.isActive
                ? const Color(0xFF1E1E1E)
                : _isHovered
                    ? const Color(0xFF2A2D2E)
                    : const Color(0xFF2D2D30),
            border: Border(
              right: const BorderSide(
                color: Color(0xFF1E1E1E),
                width: 1,
              ),
              top: widget.isActive
                  ? const BorderSide(
                      color: Color(0xFF007ACC),
                      width: 2,
                    )
                  : BorderSide.none,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                // Icon
                SvgPicture.asset(
                  widget.tab.iconPath,
                  height: 16,
                  width: 16,
                ),
                const SizedBox(width: 8),
                
                // Title
                Expanded(
                  child: Text(
                    widget.tab.title,
                    style: TextStyle(
                      fontSize: 13,
                      color: widget.isActive
                          ? Colors.white
                          : Colors.white70,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                
                // Close button
                if (_isHovered || widget.isActive)
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: widget.onClose,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        child: const Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.white70,
                        ),
                      ),
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