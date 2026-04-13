import 'package:flutter/material.dart';

class EditorTab {
  final String id;
  final String title;
  final String route;
  final String iconPath;
  final bool isDirty; // For unsaved changes indicator

  EditorTab({
    required this.id,
    required this.title,
    required this.route,
    required this.iconPath,
    this.isDirty = false,
  });

  EditorTab copyWith({
    String? id,
    String? title,
    String? route,
    String? iconPath,
    bool? isDirty,
  }) {
    return EditorTab(
      id: id ?? this.id,
      title: title ?? this.title,
      route: route ?? this.route,
      iconPath: iconPath ?? this.iconPath,
      isDirty: isDirty ?? this.isDirty,
    );
  }
}

class TabManager extends ChangeNotifier {
  final List<EditorTab> _tabs = [];
  String? _activeTabId;

  List<EditorTab> get tabs => List.unmodifiable(_tabs);
  String? get activeTabId => _activeTabId;

  void openTab({
    required String id,
    required String title,
    required String route,
    required String iconPath,
  }) {
    // Check if tab already exists
    final existingIndex = _tabs.indexWhere((tab) => tab.id == id);
    
    if (existingIndex != -1) {
      // Tab exists, just set it as active
      _activeTabId = id;
    } else {
      // Add new tab
      _tabs.add(EditorTab(
        id: id,
        title: title,
        route: route,
        iconPath: iconPath,
      ));
      _activeTabId = id;
    }
    notifyListeners();
  }

  void closeTab(String id) {
    final index = _tabs.indexWhere((tab) => tab.id == id);
    if (index == -1) return;

    _tabs.removeAt(index);

    // If closing active tab, set new active tab
    if (_activeTabId == id) {
      if (_tabs.isEmpty) {
        _activeTabId = null;
      } else if (index < _tabs.length) {
        _activeTabId = _tabs[index].id;
      } else {
        _activeTabId = _tabs.last.id;
      }
    }
    notifyListeners();
  }

  void setActiveTab(String id) {
    if (_tabs.any((tab) => tab.id == id)) {
      _activeTabId = id;
      notifyListeners();
    }
  }

  void closeAllTabs() {
    _tabs.clear();
    _activeTabId = null;
    notifyListeners();
  }

  EditorTab? getActiveTab() {
    if (_activeTabId == null) return null;
    return _tabs.firstWhere(
      (tab) => tab.id == _activeTabId,
      orElse: () => _tabs.first,
    );
  }

  void clearTabs() {
  _tabs.clear();
  _activeTabId = null;
  notifyListeners();
}
}