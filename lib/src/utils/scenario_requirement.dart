import 'package:iop_sdk/authority.dart';
import 'package:iop_sdk/inspector.dart';
import 'package:iop_sdk/ssi.dart';

class ScenarioRequirement {
  final List<ScenarioRequirementItem> items;

  ScenarioRequirement(this.items);

  bool conditionsMeet() {
    for (final data in items) {
      if (data.statement == null) {
        return false;
      }
    }

    return true;
  }
}

class ScenarioRequirementItem {
  final Prerequisite prerequisite;
  final Process process;
  final Signed<WitnessStatement>? statement;

  ScenarioRequirementItem(
    this.prerequisite,
    this.process,
    this.statement,
  );
}
