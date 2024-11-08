import '../../../core/app_export.dart';

/// This class is used in the [alertslist_item_widget] screen.

// ignore_for_file: must_be_immutable
class AlertslistItemModel {
  AlertslistItemModel(
      {this.muteIcon,
      this.alertText,
      this.anomalyText,
      this.timeText,
      this.id}) {
    muteIcon = muteIcon ?? ImageConstant.imgVector;
    alertText = alertText ?? "Alerte !";
    anomalyText = anomalyText ??
        "Une anomalie de performance a ete detectee. Verifiez les details pour plus d'informations";
    timeText = timeText ?? "17:00 - Juillet 29";
    id = id ?? "";
  }

  String? muteIcon;

  String? alertText;

  String? anomalyText;

  String? timeText;

  String? id;
}
