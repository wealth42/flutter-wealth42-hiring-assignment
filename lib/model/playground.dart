class Playground {
  Playground({
    required this.plan,
    required this.mirt,
    required this.assumptions,
    required this.cards,
  });
  int plan;
  var mirt;
  var assumptions;
  var cards;

  factory Playground.fromJson(dynamic json) {
    //assert(json is Map);
    return Playground(
      plan: json["data"]["plan"],
      mirt: json["data"]["mirt"],
      assumptions: json["data"]["assumptions"],
      cards: json["data"]["cards"],
    );
  }
  // Map<String, dynamic> toJson() => {
  //       "plan": plan,
  //       "mirt": mirt,
  //       "assumptions": assumptions,
  //       "cards": (cards as List)
  //           .map(
  //             (i) => CardsModel.fromJson(i),
  //           )
  //           .toList(),
  //     };
}

class CardsModel {
  CardsModel({
    required this.id,
    required this.type,
    required this.name,
    required this.icon_background,
    required this.icon_url,
    required this.recurrence_type,
    required this.recurrence_unit,
    required this.on_loan,
    required this.start_date,
    required this.end_date,
    required this.amount,
    required this.inflation,
    required this.down_payment_pct,
    required this.loan_interest_rate_pct,
    required this.loan_tenor_years,
    required this.plan,
  });

  String id;
  String type;
  String name;
  String icon_background;
  String icon_url;
  String recurrence_type;
  String recurrence_unit;
  bool on_loan;
  String start_date;
  String end_date;
  String amount;
  String inflation;
  String down_payment_pct;
  String loan_interest_rate_pct;
  String loan_tenor_years;
  String plan;

  factory CardsModel.fromJson(Map<String, dynamic> json) => CardsModel(
        id: json["id"].toString(),
        type: json["type"],
        name: json["name"],
        icon_background: json["icon_background"],
        icon_url: json["icon_url"],
        recurrence_type: json["recurrence_type"],
        recurrence_unit: json["recurrence_unit"],
        on_loan: json["on_loan"],
        start_date: json["start_date"],
        end_date: json["end_date"],
        amount: json["amount"].toString(),
        inflation: json["inflation"],
        down_payment_pct: json["down_payment_pct"],
        loan_interest_rate_pct: json["loan_interest_rate_pct"],
        loan_tenor_years: json["loan_tenor_years"].toString(),
        plan: json["plan"].toString(),
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "icon_background": icon_background,
        "icon_url": icon_url,
        "recurrence_type": recurrence_type,
        "recurrence_unit": recurrence_unit,
        "on_loan": on_loan,
        "start_date": start_date,
        "end_date": end_date,
        "amount": amount,
        "inflation": inflation,
        "down_payment_pct": down_payment_pct,
        "loan_interest_rate_pct": loan_interest_rate_pct,
        "loan_tenor_years": loan_tenor_years,
        "plan": plan,
      };
}
