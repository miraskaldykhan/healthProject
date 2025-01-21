class HealthData {
  HealthData({
    required this.dynamics,
    required this.alerts,
  });

  final List<Dynamic> dynamics;
  final List<Alert> alerts;

  HealthData copyWith({
    List<Dynamic>? dynamics,
    List<Alert>? alerts,
  }) {
    return HealthData(
      dynamics: dynamics ?? this.dynamics,
      alerts: alerts ?? this.alerts,
    );
  }

  factory HealthData.fromJson(Map<String, dynamic> json){
    return HealthData(
      dynamics: json["dynamics"] == null ? [] : List<Dynamic>.from(json["dynamics"]!.map((x) => Dynamic.fromJson(x))),
      alerts: json["alerts"] == null ? [] : List<Alert>.from(json["alerts"]!.map((x) => Alert.fromJson(x))),
    );
  }

  @override
  String toString(){
    return "$dynamics, $alerts, ";
  }
}

class Alert {
  Alert({
    required this.message,
    required this.resubmitLink,
  });

  final String? message;
  final bool? resubmitLink;

  Alert copyWith({
    String? message,
    bool? resubmitLink,
  }) {
    return Alert(
      message: message ?? this.message,
      resubmitLink: resubmitLink ?? this.resubmitLink,
    );
  }

  factory Alert.fromJson(Map<String, dynamic> json){
    return Alert(
      message: json["message"],
      resubmitLink: json["resubmitLink"],
    );
  }

  @override
  String toString(){
    return "$message, $resubmitLink, ";
  }
}

class Dynamic {
  Dynamic({
    required this.date,
    required this.lab,
    required this.value,
  });

  final DateTime? date;
  final String? lab;
  final double? value;

  Dynamic copyWith({
    DateTime? date,
    String? lab,
    double? value,
  }) {
    return Dynamic(
      date: date ?? this.date,
      lab: lab ?? this.lab,
      value: value ?? this.value,
    );
  }

  factory Dynamic.fromJson(Map<String, dynamic> json){
    return Dynamic(
      date: DateTime.tryParse(json["date"] ?? ""),
      lab: json["lab"],
      value: json["value"],
    );
  }

  @override
  String toString(){
    return "$date, $lab, $value, ";
  }
}
