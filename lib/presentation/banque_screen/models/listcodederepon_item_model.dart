/// This class is used in the [listcodederepon_item_widget] screen.

// ignore_for_file: must_be_immutable
class ListcodedereponItemModel {
  ListcodedereponItemModel(
      {this.codeDeReponse,
      this.additionalText,
      this.nombreT,
      this.additionaltextg,
      this.id}) {
    codeDeReponse = codeDeReponse ?? "Code de réponse le plus fréquent";
    additionalText = additionalText ?? "915";
    nombreT = nombreT ?? "Nombre T :";
    additionaltextg = additionaltextg ?? "554";
    id = id ?? "";
  }

  String? codeDeReponse;

  String? additionalText;

  String? nombreT;

  String? additionaltextg;

  String? id;
}
