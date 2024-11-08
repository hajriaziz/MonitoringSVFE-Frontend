import '../../../core/app_export.dart';
import 'alertslist_item_model.dart';

// ignore_for_file: must_be_immutable
class NotificationModel {
  List<AlertslistItemModel> alertslistItemList = [
    AlertslistItemModel(
        muteIcon: ImageConstant.imgVector,
        alertText: "Alerte !",
        anomalyText:
            "Une anomalie de performance a été détectée. Vérifiez les détails pour plus d'informations",
        timeText: "17:00 - Juillet 29"),
    AlertslistItemModel(),
    AlertslistItemModel()
  ];
}
