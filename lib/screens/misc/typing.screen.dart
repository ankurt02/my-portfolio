import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:collection';
import 'dart:math';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

// --- INSTRUCTIONS ---
// 1. Add these packages to your pubspec.yaml file:
//
// dependencies:
//   flutter:
//     sdk: flutter
//   http: ^1.2.1
//   gap: ^3.0.1
//   google_fonts: ^6.2.1
//
// 2. Run `flutter pub get` in your terminal.
// 3. Replace 'YOUR_APE_KEY_HERE' with your actual Monkeytype ApeKey.

// --- Data Model for the new API Response ---
// We only need the timestamp from each result for the heatmap
class TestResult {
  final int timestamp;

  TestResult({required this.timestamp});

  factory TestResult.fromJson(Map<String, dynamic> json) {
    return TestResult(
      timestamp: json['timestamp'],
    );
  }
}

// --- Service to Fetch Data from Monkeytype API ---
class MonkeytypeService {
  // IMPORTANT: Replace with your actual ApeKey
  static const String _apiKey = 'NjhjY2ZmZGNkY2Q1YzQyNmZlNTRjNmViLmM1aVhIQ2ZWc2F5WURIX3ZsSXNDLWxFYkgzSFl1Mjcy';
  // UPDATED: Using the /results endpoint for pagination
  static const String _baseUrl = 'https://api.monkeytype.com/results';

  // UPDATED: This function now fetches all results using pagination
  Future<List<TestResult>> getTestResults() async {
    if (_apiKey == 'YOUR_APE_KEY_HERE') {
      // Using mock data for UI testing since no API key is provided.
      // throw Exception('Please replace YOUR_APE_KEY_HERE with your actual ApeKey.');
      // Generating random mock data for the last year
      final random = Random();
      final results = <TestResult>[];
      for (int i = 0; i < 365; i++) {
        int testsToday = random.nextInt(15);
        for (int j = 0; j < testsToday; j++) {
           results.add(TestResult(timestamp: DateTime.now().subtract(Duration(days: i)).millisecondsSinceEpoch));
        }
      }
      return results;
    }

    final List<TestResult> allResults = [];
    int offset = 0;
    const int limit = 990;

    while (true) {
      final response = await http.get(
        Uri.parse('$_baseUrl?limit=$limit&offset=$offset'),
        headers: {
          'Authorization': 'ApeKey $_apiKey',
        },
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final List<dynamic> resultsData = body['data'];
        final List<TestResult> fetchedResults =
            resultsData.map((json) => TestResult.fromJson(json)).toList();
        
        allResults.addAll(fetchedResults);

        // If we received fewer results than the limit, it means we've reached the end.
        if (fetchedResults.length < limit) {
          break;
        }

        // Otherwise, prepare to fetch the next page.
        offset += limit;
      } else {
        throw Exception('Failed to load test results: ${response.body}');
      }
    }
    return allResults;
  }
}

// --- Main Screen Widget ---
class HeatmapScreen extends StatefulWidget {
  const HeatmapScreen({super.key});

  @override
  State<HeatmapScreen> createState() => _HeatmapScreenState();
}

class _HeatmapScreenState extends State<HeatmapScreen> {
  Future<List<TestResult>>? futureTestResults;
  final MonkeytypeService monkeytypeService = MonkeytypeService();

  @override
  void initState() {
    super.initState();
    futureTestResults = monkeytypeService.getTestResults();
  }

  Map<DateTime, int> _processActivityData(List<TestResult> results) {
    final Map<DateTime, int> datasets = {};

    for (final result in results) {
      final date = DateTime.fromMillisecondsSinceEpoch(result.timestamp);
      // Normalize the date to ignore time, so we can group by day
      final dayOnly = DateTime(date.year, date.month, date.day);

      // Increment the count for that day
      datasets[dayOnly] = (datasets[dayOnly] ?? 0) + 1;
    }
    return datasets;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TestResult>>(
      future: futureTestResults,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFFE2B714),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Error: ${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.redAccent)),
            ),
          );
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final activityData = _processActivityData(snapshot.data!);
          return LayoutBuilder(
            builder: (context, constraints) {
              const double weekLabelWidth = 40.0;
              const double gapWidth = 6.0;
              const double containerHPadding = 32.0;
              const double cellHMargin = 4.0;
              const int numberOfWeeks = 53;

              final double availableWidth = constraints.maxWidth - containerHPadding - weekLabelWidth - gapWidth;
              
              final double cellSize = (availableWidth / numberOfWeeks) - cellHMargin;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 24.0),
                    child: Text(
                      'monkeytype',
                      style: GoogleFonts.robotoMono(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFE2B714),
                      ),
                    ),
                  ),
                  // UPDATED: Align widget ensures the container is centered correctly.
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2C2E31),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: HeatMap(
                        datasets: activityData,
                        size: cellSize,
                        fontSize: cellSize * 0.6,
                        startDate: DateTime(DateTime.now().year, 1, 1),
                        endDate: DateTime(DateTime.now().year, 12, 31),
                        textColor: const Color(0xFFD1D0C5),
                        defaultColor: const Color(0xFF646669),
                        colorMode: ColorMode.color,
                        showColorTip: true,
                        showText: false,
                        scrollable: false,
                        borderRadius: 5,
                        colorsets: const {
                          1: Color(0xFFE2B714),
                          5: Color.fromARGB(255, 252, 198, 6),
                          10: Color.fromARGB(255, 149, 117, 0),
                          15: Color.fromARGB(255, 64, 50, 1),
                        },
                        onClick: (value) {
                          final count = activityData[value] ?? 0;
                          final dateString =
                              "${value.day}/${value.month}/${value.year}";
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('$count tests on $dateString')));
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 24.0),
                    child: Text(
                      'Thank You',
                      style: GoogleFonts.robotoMono(
                        fontSize: 24,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
        return const Center(child: Text('No data found.'));
      },
    );
  }
}

// --- CUSTOM HEATMAP WIDGET CODE PROVIDED BY USER ---

enum ColorMode {
  opacity,
  color,
}

class HeatMap extends StatefulWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final Map<DateTime, int>? datasets;
  final Color? defaultColor;
  final Color? textColor;
  final double? size;
  final double? fontSize;
  final Map<int, Color> colorsets;
  final ColorMode colorMode;
  final Function(DateTime)? onClick;
  final EdgeInsets? margin;
  final double? borderRadius;
  final Color? borderColor;
  final double? borderWidth;
  final bool? showText;
  final bool? showColorTip;
  final bool scrollable;
  final List<Widget?>? colorTipHelper;
  final int? colorTipCount;
  final double? colorTipSize;

  const HeatMap({
    Key? key,
    required this.colorsets,
    this.colorMode = ColorMode.opacity,
    this.startDate,
    this.endDate,
    this.textColor,
    this.size = 20,
    this.fontSize,
    this.onClick,
    this.margin,
    this.borderRadius,
    this.datasets,
    this.defaultColor,
    this.showText = false,
    this.showColorTip = true,
    this.scrollable = false,
    this.colorTipHelper,
    this.colorTipCount,
    this.colorTipSize,
    this.borderColor,
    this.borderWidth,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HeatMap();
}

class _HeatMap extends State<HeatMap> {
  Widget _scrollableHeatMap(Widget child) {
    return widget.scrollable
        ? SingleChildScrollView(
            reverse: true,
            scrollDirection: Axis.horizontal,
            child: child,
          )
        : child;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _scrollableHeatMap(HeatMapPage(
          endDate: widget.endDate ?? DateTime.now(),
          startDate: widget.startDate ??
              DateUtil.oneYearBefore(widget.endDate ?? DateTime.now()),
          colorMode: widget.colorMode,
          size: widget.size,
          fontSize: widget.fontSize,
          datasets: widget.datasets,
          defaultColor: widget.defaultColor,
          textColor: widget.textColor,
          colorsets: widget.colorsets,
          borderRadius: widget.borderRadius,
          onClick: widget.onClick,
          margin: widget.margin,
          showText: widget.showText,
          borderColor: widget.borderColor,
          borderWidth: widget.borderWidth,
        )),
        if (widget.showColorTip == true)
          HeatMapColorTip(
            colorMode: widget.colorMode,
            colorsets: widget.colorsets,
            leftWidget: widget.colorTipHelper?[0],
            rightWidget: widget.colorTipHelper?[1],
            containerCount: widget.colorTipCount,
            size: widget.colorTipSize,
          ),
      ],
    );
  }
}

class HeatMapContainer extends StatelessWidget {
  final DateTime date;
  final double? size;
  final double? fontSize;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? textColor;
  final EdgeInsets? margin;
  final bool? showText;
  final Function(DateTime dateTime)? onClick;
  final Color? borderColor;
  final double? borderWidth;

  const HeatMapContainer({
    Key? key,
    required this.date,
    this.margin,
    this.size,
    this.fontSize,
    this.borderRadius,
    this.backgroundColor,
    this.selectedColor,
    this.textColor,
    this.onClick,
    this.showText,
    this.borderColor,
    this.borderWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.all(2),
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? HeatMapColor.defaultColor,
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 5)),
            border: borderColor != null
                ? Border.all(
                    color: borderColor!,
                    width: borderWidth ?? 1.0,
                  )
                : null,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOutQuad,
            width: size,
            height: size,
            alignment: Alignment.center,
            child: (showText ?? true)
                ? Text(
                    date.day.toString(),
                    style: TextStyle(
                        color: textColor ?? const Color(0xFF8A8A8A),
                        fontSize: fontSize),
                  )
                : null,
            decoration: BoxDecoration(
              color: selectedColor,
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius ?? 5)),
            ),
          ),
        ),
        onTap: () {
          onClick != null ? onClick!(date) : null;
        },
      ),
    );
  }
}

class HeatMapColumn extends StatelessWidget {
  final List<Widget> dayContainers;
  final List<Widget> emptySpaceTop;
  final List<Widget> emptySpaceBottom;

  HeatMapColumn({
    Key? key,
    required DateTime startDate,
    required DateTime endDate,
    required ColorMode colorMode,
    required int numDays,
    int emptySpacesAtStart = 0,
    double? size,
    double? fontSize,
    Color? defaultColor,
    Map<DateTime, int>? datasets,
    Color? textColor,
    double? borderRadius,
    EdgeInsets? margin,
    Map<int, Color>? colorsets,
    Function(DateTime)? onClick,
    int? maxValue,
    bool? showText,
    Color? borderColor,
    double? borderWidth,
  })  : emptySpaceTop = List.generate(
          emptySpacesAtStart,
          (i) => Container(
              margin: margin ?? const EdgeInsets.all(2),
              width: size ?? 20,
              height: size ?? 20),
        ),
        dayContainers = List.generate(
          numDays,
          (i) => HeatMapContainer(
            date: DateUtil.changeDay(startDate, i),
            backgroundColor: defaultColor,
            size: size,
            fontSize: fontSize,
            textColor: textColor,
            borderRadius: borderRadius,
            margin: margin,
            onClick: onClick,
            showText: showText,
            borderColor: borderColor,
            borderWidth: borderWidth,
            selectedColor:
                datasets?.keys.contains(DateUtil.changeDay(startDate, i)) ??
                        false
                    ? colorMode == ColorMode.opacity
                        ? colorsets?.values.first.withOpacity(
                            (datasets?[DateUtil.changeDay(startDate, i)] ??
                                    1) /
                                (maxValue ?? 1))
                        : DatasetsUtil.getColor(colorsets,
                            datasets?[DateUtil.changeDay(startDate, i)])
                    : null,
          ),
        ),
        emptySpaceBottom = List.generate(
          7 - numDays - emptySpacesAtStart,
          (i) => Container(
              margin: margin ?? const EdgeInsets.all(2),
              width: size ?? 20,
              height: size ?? 20),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[...emptySpaceTop, ...dayContainers, ...emptySpaceBottom],
    );
  }
}

class HeatMapPage extends StatelessWidget {
  final List<int> _firstDayInfos = [];
  final int _dateDifferent;
  final DateTime startDate;
  final DateTime endDate;
  final double? size;
  final double? fontSize;
  final Map<DateTime, int>? datasets;
  final EdgeInsets? margin;
  final Color? defaultColor;
  final Color? textColor;
  final ColorMode colorMode;
  final Map<int, Color>? colorsets;
  final double? borderRadius;
  final int? maxValue;
  final Function(DateTime)? onClick;
  final bool? showText;
  final Color? borderColor;
  final double? borderWidth;

  HeatMapPage({
    Key? key,
    required this.colorMode,
    required this.startDate,
    required this.endDate,
    this.size,
    this.fontSize,
    this.datasets,
    this.defaultColor,
    this.textColor,
    this.colorsets,
    this.borderRadius,
    this.onClick,
    this.margin,
    this.showText,
    this.borderColor,
    this.borderWidth,
  })  : _dateDifferent = endDate.difference(startDate).inDays,
        maxValue = DatasetsUtil.getMaxValue(datasets),
        super(key: key);

  List<Widget> _heatmapColumnList() {
    List<Widget> columns = [];
    _firstDayInfos.clear();

    int daysFromSunday = startDate.weekday % 7;
    DateTime firstWeekStart = DateUtil.changeDay(startDate, -daysFromSunday);

    for (DateTime weekStart = firstWeekStart;
        weekStart.isBefore(endDate) || weekStart.isAtSameMomentAs(endDate);
        weekStart = DateUtil.changeDay(weekStart, 7)) {
      DateTime weekEnd = DateUtil.changeDay(weekStart, 6);

      DateTime columnStart = weekStart.isBefore(startDate) ? startDate : weekStart;
      DateTime columnEnd = weekEnd.isAfter(endDate) ? endDate : weekEnd;

      if (!columnStart.isAfter(columnEnd) && !columnStart.isAfter(endDate)) {
        int numDays = columnEnd.difference(columnStart).inDays + 1;

        int emptySpacesAtStart = columnStart.difference(weekStart).inDays;

        columns.add(HeatMapColumn(
          startDate: columnStart,
          endDate: columnEnd,
          colorMode: colorMode,
          numDays: numDays,
          emptySpacesAtStart: emptySpacesAtStart,
          size: size,
          fontSize: fontSize,
          defaultColor: defaultColor,
          colorsets: colorsets,
          textColor: textColor,
          borderRadius: borderRadius,
          margin: margin,
          maxValue: maxValue,
          onClick: onClick,
          datasets: datasets,
          showText: showText,
          borderColor: borderColor,
          borderWidth: borderWidth,
        ));

        _firstDayInfos.add(columnStart.month);
      }
    }
    return columns;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        HeatMapWeekText(
          margin: margin,
          fontSize: fontSize,
          size: size,
          fontColor: textColor,
        ),
        const Gap(6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeatMapMonthText(
              firstDayInfos: _firstDayInfos,
              margin: margin,
              fontSize: fontSize,
              fontColor: textColor,
              size: size,
            ),
            Row(
              children: <Widget>[..._heatmapColumnList()],
            ),
          ],
        ),
      ],
    );
  }
}

class HeatMapMonthText extends StatelessWidget {
  final List<int>? firstDayInfos;
  final double? size;
  final double? fontSize;
  final Color? fontColor;
  final EdgeInsets? margin;

  const HeatMapMonthText({
    Key? key,
    this.firstDayInfos,
    this.fontSize,
    this.fontColor,
    this.size,
    this.margin,
  }) : super(key: key);

  Map<int, int> _getMonthSpans() {
    Map<int, int> monthSpans = LinkedHashMap<int, int>();
    if (firstDayInfos == null || firstDayInfos!.isEmpty) return monthSpans;

    int currentMonth = firstDayInfos!.first;
    int count = 0;

    for (int month in firstDayInfos!) {
      if (month == currentMonth) {
        count++;
      } else {
        if (count > 0) {
          monthSpans[currentMonth] = count;
        }
        currentMonth = month;
        count = 1;
      }
    }

    if (count > 0) {
      monthSpans[currentMonth] = count;
    }

    return monthSpans;
  }

  @override
  Widget build(BuildContext context) {
    final monthSpans = _getMonthSpans();
    final double cellWidth = (size ?? 22) + (margin?.horizontal ?? 6);

    return Row(
      children: monthSpans.entries.map((entry) {
        final int month = entry.key;
        final int span = entry.value;

        if (month < 1 || month > 12) {
          return const SizedBox.shrink();
        }
        return Container(
          width: cellWidth * span,
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.only(left: 2),
          child: Text(
            DateUtil.SHORT_MONTH_LABEL[month],
            style: GoogleFonts.robotoMono(
                color: fontColor,
                fontSize: fontSize ?? 12,
                fontWeight: FontWeight.w500),
          ),
        );
      }).toList(),
    );
  }
}

class HeatMapWeekText extends StatelessWidget {
  final EdgeInsets? margin;
  final double? fontSize;
  final double? size;
  final Color? fontColor;

  const HeatMapWeekText({
    Key? key,
    this.margin,
    this.fontSize,
    this.size,
    this.fontColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> weekLabels = [
      'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(height: (fontSize ?? 12) + 6),
        for (int i = 0; i < 7; i++)
          Container(
            height: (size ?? 20) + (margin?.vertical ?? 6),
            alignment: Alignment.centerLeft,
            child: Text(
              weekLabels[i],
              style: GoogleFonts.robotoMono(
                fontSize: fontSize ?? 14,
                color: fontColor,
              ),
            ),
          ),
      ],
    );
  }
}

class HeatMapColorTip extends StatelessWidget {
  final int _defaultLength = 7;
  final Map<int, Color>? colorsets;
  final ColorMode colorMode;
  final Widget? leftWidget;
  final Widget? rightWidget;
  final int? containerCount;
  final double? size;

  const HeatMapColorTip({
    Key? key,
    required this.colorMode,
    this.colorsets,
    this.leftWidget,
    this.rightWidget,
    this.containerCount,
    this.size,
  }) : super(key: key);

  List<Widget> _heatmapList() =>
      colorMode == ColorMode.color ? _heatmapListColor() : _heatmapListOpacity();

  List<Widget> _heatmapListColor() {
    List<Widget> children = [];
    SplayTreeMap sortedColorset =
        SplayTreeMap.from(colorsets ?? {}, (a, b) => a > b ? 1 : -1);
    for (int i = 0; i < (containerCount ?? _defaultLength); i++) {
      children.add(_tipContainer(sortedColorset.values.elementAt(
          (sortedColorset.length / (containerCount ?? _defaultLength) * i)
              .floor())));
    }
    return children;
  }

  List<Widget> _heatmapListOpacity() {
    List<Widget> children = [];
    for (int i = 0; i < (containerCount ?? _defaultLength); i++) {
      children.add(_tipContainer(colorsets?.values.first
              .withOpacity(i / (containerCount ?? _defaultLength)) ??
          Colors.white));
    }
    return children;
  }

  Widget _tipContainer(Color color) {
    return Container(
      width: size ?? 10,
      height: size ?? 10,
      margin: const EdgeInsets.all(1.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(2)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          leftWidget ??
              Text(
                'Less',
                style: TextStyle(color: Colors.white.withOpacity(0.7)),
              ),
          const Gap(8),
          ..._heatmapList(),
          const Gap(8),
          rightWidget ??
              Text(
                'More',
                style: TextStyle(color: Colors.white.withOpacity(0.7)),
              ),
        ],
      ),
    );
  }
}

class DateUtil {
  static const List<String> SHORT_MONTH_LABEL = [
    '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  static const List<String> WEEK_LABEL = [
    '', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat',
  ];

  static DateTime oneYearBefore(final DateTime referenceDate) =>
      DateTime(referenceDate.year - 1, referenceDate.month, referenceDate.day);

  static DateTime changeDay(final DateTime referenceDate, final int dayCount) =>
      DateTime(referenceDate.year, referenceDate.month,
          referenceDate.day + dayCount);
}

class DatasetsUtil {
  static int getMaxValue(Map<DateTime, int>? datasets) {
    if (datasets == null || datasets.isEmpty) return 0;
    return datasets.values.reduce(max);
  }

  static Color? getColor(Map<int, Color>? colorsets, int? dataValue) {
    if (colorsets == null || dataValue == null) return null;
    int? result;
    for (var key in colorsets.keys) {
      if (key <= dataValue) {
        result = key;
      }
    }
    return colorsets[result];
  }
}

class HeatMapColor {
  static const Color defaultColor = Color(0xFFF8F9FA);
}

