import 'categories.dart';
import 'dependencies.dart';
import 'editors.dart';
import 'grand_total.dart';
import 'languages.dart';
import 'machines.dart';
import 'operating_systems.dart';
import 'projects.dart';
import 'range.dart';

class SummaryData {
  List<Categories> categories = List.empty();
  late List<Dependencies> dependencies;
  late List<Editors> editors;
  late GrandTotal grandTotal;
  late List<Languages> languages;
  late List<Machines> machines;
  late List<OperatingSystems> operatingSystems;
  late List<Projects> projects;
  late Range range;

  SummaryData(
      {required this.categories,
      required this.dependencies,
      required this.editors,
      required this.grandTotal,
      required this.languages,
      required this.machines,
      required this.operatingSystems,
      required this.projects,
      required this.range});

  SummaryData.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories.add(Categories.fromJson(v));
      });
    }
    if (json['dependencies'] != null) {
      dependencies = <Dependencies>[];
      json['dependencies'].forEach((v) {
        dependencies.add(Dependencies.fromJson(v));
      });
    }
    if (json['editors'] != null) {
      editors = <Editors>[];
      json['editors'].forEach((v) {
        editors.add(Editors.fromJson(v));
      });
    }
    grandTotal = json['grand_total'] != null
        ? GrandTotal.fromJson(json['grand_total'])
        : GrandTotal(
            digital: "", hours: 0, minutes: 0, text: "", totalSeconds: 0);
    if (json['languages'] != null) {
      languages = <Languages>[];
      json['languages'].forEach((v) {
        languages.add(Languages.fromJson(v));
      });
    }
    if (json['machines'] != null) {
      machines = <Machines>[];
      json['machines'].forEach((v) {
        machines.add(Machines.fromJson(v));
      });
    }
    if (json['operating_systems'] != null) {
      operatingSystems = <OperatingSystems>[];
      json['operating_systems'].forEach((v) {
        operatingSystems.add(OperatingSystems.fromJson(v));
      });
    }
    if (json['projects'] != null) {
      projects = <Projects>[];
      json['projects'].forEach((v) {
        projects.add(Projects.fromJson(v));
      });
    }
    range = json['range'] != null
        ? Range.fromJson(json['range'])
        : Range(date: "", end: "", start: "", text: "", timezone: "");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categories'] = categories.map((v) => v.toJson()).toList();
    data['dependencies'] = dependencies.map((v) => v.toJson()).toList();
    data['editors'] = editors.map((v) => v.toJson()).toList();
    data['grand_total'] = grandTotal.toJson();
    data['languages'] = languages.map((v) => v.toJson()).toList();
    data['machines'] = machines.map((v) => v.toJson()).toList();
    data['operating_systems'] =
        operatingSystems.map((v) => v.toJson()).toList();
    data['projects'] = projects.map((v) => v.toJson()).toList();
    data['range'] = range.toJson();
    return data;
  }
}
