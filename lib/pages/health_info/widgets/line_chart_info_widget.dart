import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testprojectforhealth/core/models/health_data.dart';

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({
    super.key,
    required this.data,
  });

  final List<Dynamic> data;

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    const Color(0xff27A474),
    const Color(0xff27A474)
  ];

  late Dynamic maxY;
  int maxYValueDouble = 0;

  @override
  void initState() {
    maxY =
        widget.data.reduce((a, b) => (a.value ?? 0) > (b.value ?? 0) ? a : b);
    maxYValueDouble = maxY.value!.toInt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(18),
            ),
            border: Border.all(color: Colors.white, width: 1),
            color: Colors.white,
          ),
          child: AspectRatio(
            aspectRatio: 1.70,
            child: LineChart(
              mainData(widget.data),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
      color: const Color(0xff040404).withOpacity(0.4),
    );
    Widget text;
    if (value.toInt() == 1) {
      text = Text(
        DateFormat("dd MMM yyyy").format(widget.data.first.date!),
        style: style,
      );
    } else if (value.toInt() == widget.data.indexOf(maxY)) {
      text = Text(
        DateFormat("dd MMM yyyy").format(maxY.date!),
        style: style,
      );
    } else {
      text = const SizedBox.shrink();
    }

    return SideTitleWidget(
      axisSide: AxisSide.bottom,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '1';
        break;
      case 3:
        text = '3';
        break;
      case 5:
        text = '5';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData(List<Dynamic> data) {
    return LineChartData(
      backgroundColor: const Color(0xff69B137).withOpacity(0.1),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: false,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.greenAccent,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.greenAccent,
            strokeWidth: 1,
          );
        },
      ),
      clipData: const FlClipData.all(),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(
          color: Colors.white,
        ),
      ),
      minX: 0,
      maxX: data.length.toDouble() - 1,
      minY: 0,
      maxY: (maxY.value! + 2.0),
      lineBarsData: [
        LineChartBarData(
          spots: data.map((e) {
            final spot =
                FlSpot(widget.data.indexOf(e).toDouble(), e.value!.toDouble());
            return spot;
          }).toList(),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 4,
          isStrokeCapRound: false,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                const Color(0xff69B137).withOpacity(0.15),
                const Color(0xff69B137).withOpacity(0.15)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
