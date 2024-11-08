/// This class is used in the [listtitle_item_widget] screen.

// ignore_for_file: must_be_immutable
class ListtitleItemModelj {
  ListtitleItemModelj(
      {this.title, this.additionalText, this.percentage, this.id}) {
    title = title ?? "Transactions";
    additionalText = additionalText ?? "Autorisées";
    percentage = percentage ?? "78%";
    id = id ?? "";
  }
  String? title;

  String? additionalText;

  String? percentage;

  String? id;
}
