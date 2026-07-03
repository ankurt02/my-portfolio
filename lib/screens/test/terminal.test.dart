import 'package:flutter/material.dart';

class ResizableCodeTerminal extends StatefulWidget {
  const ResizableCodeTerminal({Key? key, required this.onClose}) : super(key: key);

  final VoidCallback onClose;

  @override
  State<ResizableCodeTerminal> createState() => _ResizableCodeTerminalState();
}

class _ResizableCodeTerminalState extends State<ResizableCodeTerminal> {
  // Theme Colors matching your custom VS Code workspace profile
  final Color vscodeTerminalBg = const Color(0xFF151515); 
  final Color vscodePanelBg = const Color(0xFF1E1E1E);
  final Color vscodeBlue = const Color(0xFF007ACC);
  final Color vscodeTextGray = const Color(0xFFCCCCCC);
  final Color vscodeMutedGray = const Color(0xFF858585);

  // Sizing configurations
  double _terminalHeight = 260.0; 
  double _preCollapseHeight = 260.0; 
  bool _isCollapsed = false;
  
  // Custom height guard bounds - allows dragging near full vertical layout viewport limits
  final double _minHeight = 60.0;
  final double _maxHeight = 750.0;

  final TextEditingController _commandController = TextEditingController();
  final ScrollController _terminalScrollController = ScrollController();
  final FocusNode _terminalFocusNode = FocusNode();

  // Baseline startup console string
  static const String _welcomeBanner = '✓ Compiled successfully. Type \'help\' to see commands.';

  late final List<String> _terminalLogs;

  // --- THE COMMAND DICTIONARY (KEY-VALUE SCALABLE ROUTING ENGINE) ---
  final Map<String, List<String>> _commandDictionary = {
    'help': [
      'Available commands:',
      '  projects    - View my recent projects and tech stack',
      '  experience  - View my work history',
      '  about       - Get to know more about me',
      '  clear       - Clear the terminal console screen',
    ],
    'projects': [
      'Loading projects directory...',
      ' ',
      '📂 ShikamaruAI.dart',
      '   └─ Built with Flutter. An AI assistant app.',
      '📂 CorporateAI.kt',
      '   └─ Native Android AI toolkit in Kotlin.',
      '📂 PriceLens.ipynb',
      '   └─ Python/ML model for price prediction.',
      '📂 EncryptIt.py',
      '   └─ Python script for encryption schemes.',
      ' ',
      'Tip: Check the sidebar to see the actual file structure logs!'
    ],
    'project': [
      'Loading projects directory...',
      ' ',
      '📂 ShikamaruAI.dart',
      '   └─ Built with Flutter. An AI assistant app.',
      '📂 CorporateAI.kt',
      '   └─ Native Android AI toolkit in Kotlin.',
    ],
    'experience': [
      'Fetching professional history directory...',
      ' ',
      '💻 Android Developer',
      '   └─ Native Android and Cross-Platform Architectures.',
      '   └─ Scaled code structure layouts and boosted performance UI frames.',
    ],
    'work': [
      'Fetching professional history directory...',
      ' ',
      '💻 Android Developer',
      '   └─ Native Android and Cross-Platform Architectures.',
    ],
    'about': [
      'Hello, I\'m Ankur Tiwary.',
      'Software Developer based in India.',
      'Specializing in Flutter/Dart, Native Mobile, and AI/ML pipelines.',
    ],
  };

  @override
  void initState() {
    super.initState() ;
    _terminalLogs = [
      'Last login: Fri Jul 03 2026 on ttys000',
      'binay@macbook-air portfolio-ide % npm start',
      _welcomeBanner,
    ];
  }

  void _handleCommandSubmit(String input) {
    if (input.trim().isEmpty) return;

    setState(() {
      // Always capture and print the command prompt entry line first
      _terminalLogs.add('binay@macbook-air portfolio-ide % $input'); 
      String command = input.trim().toLowerCase(); 

      if (command == 'clear') {
        _terminalLogs.clear(); 
        _terminalLogs.add(_welcomeBanner); 
      } 
      else if (_commandDictionary.containsKey(command)) {
        _terminalLogs.addAll(_commandDictionary[command]!); 
      } 
      else {
        _terminalLogs.add('zsh: command not found: $command'); 
        _terminalLogs.add('Type \'help\' to see available commands.'); 
      }
    });

    _commandController.clear(); 
    
    // Maintain snap focus layout behavior down to the absolute bottom log item
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_terminalScrollController.hasClients) {
        _terminalScrollController.animateTo(
          _terminalScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
      _terminalFocusNode.requestFocus(); 
    });
  }

  void _toggleCollapse() {
    setState(() {
      if (_isCollapsed) {
        _terminalHeight = _preCollapseHeight; 
      } else {
        _preCollapseHeight = _terminalHeight; 
        _terminalHeight = 0; 
      }
      _isCollapsed = !_isCollapsed; 
    });
  }

  void _handleDrag(DragUpdateDetails details) {
    setState(() {
      _terminalHeight -= details.primaryDelta!; 
      
      if (_terminalHeight < _minHeight) {
        _terminalHeight = 0; 
        _isCollapsed = true; 
      } else if (_terminalHeight > _maxHeight) {
        _terminalHeight = _maxHeight; 
      } else {
        _isCollapsed = false; 
      }
    });
  }

  @override
  void dispose() {
    _commandController.dispose();
    _terminalScrollController.dispose();
    _terminalFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // --- RESIZABLE & COLLAPSIBLE VS CODE BAR HEADER PANEL ---
        GestureDetector(
          onVerticalDragUpdate: _handleDrag, 
          child: MouseRegion(
            cursor: SystemMouseCursors.resizeUpDown, 
            child: Container(
              height: 35, 
              color: vscodePanelBg, 
              padding: const EdgeInsets.symmetric(horizontal: 16.0), 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                children: [
                  Row(
                    children: [
                      _buildTab('Terminal', isActive: true), 
                      _buildTab('Output', isActive: false), 
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          _isCollapsed ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, 
                          size: 18, 
                          color: vscodeTextGray, 
                        ),
                        onPressed: _toggleCollapse, 
                        padding: EdgeInsets.zero, 
                        constraints: const BoxConstraints(), 
                      ),
                      const SizedBox(width: 12), 
                      GestureDetector(
                        onTap: widget.onClose,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Icon(Icons.close, size: 16, color: vscodeMutedGray),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        // --- CONSOLE LINES LOGGER VIEWPORT HOUSING PANEL ---
        Container(
          height: _terminalHeight, 
          width: double.infinity, 
          color: vscodeTerminalBg, 
          child: _isCollapsed
              ? const SizedBox.shrink() 
              : GestureDetector(
                  onTap: () => _terminalFocusNode.requestFocus(),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, 
                      children: [
                        // Console history engine
                        Expanded(
                          child: ListView.builder(
                            controller: _terminalScrollController, 
                            itemCount: _terminalLogs.length, 
                            itemBuilder: (context, index) => Text(
                              _terminalLogs[index],
                              style: const TextStyle(
                                color: Colors.white, 
                                fontFamily: 'Courier', 
                                fontSize: 13,
                                height: 1.3,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Prompts input line sits directly beneath logs securely
                        Row(
                          children: [
                            const Text(
                              'binay@macbook-air portfolio-ide % ', 
                              style: TextStyle(color: Color(0xFF4AF626), fontFamily: 'Courier', fontSize: 13),
                            ),
                            Expanded(
                              child: TextField(
                                controller: _commandController, 
                                focusNode: _terminalFocusNode, 
                                onSubmitted: _handleCommandSubmit, 
                                style: const TextStyle(color: Colors.white, fontFamily: 'Courier', fontSize: 13), 
                                cursorColor: vscodeBlue,
                                decoration: const InputDecoration(
                                  border: InputBorder.none, 
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildTab(String label, {required bool isActive}) {
    return Container(
      margin: const EdgeInsets.only(right: 16.0), 
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: isActive ? Border(bottom: BorderSide(color: vscodeBlue, width: 2)) : null, 
      ),
      child: Text(
        label, 
        style: TextStyle(
          color: isActive ? Colors.white : vscodeMutedGray, 
          fontSize: 12.5,
        ),
      ),
    );
  }
}