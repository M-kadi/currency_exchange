class CurrencyExchange {
  String base;
  // String rates;
  String date;
  List<Currency> ratesList;

  CurrencyExchange({
    this.base,
    // this.rates,
    this.date,
    this.ratesList
  });

  factory CurrencyExchange.fromJson(Map<String, dynamic> parsedJson){

    // Convert InternalLinkedHashMap to String value
    // String rates_str = "";
    List<Currency> ratesList = new List();

    Map<String, dynamic> rates = parsedJson['rates'];
    rates.forEach((k,v) => ratesList.add(new Currency(k, v)));

    return CurrencyExchange(
        base: parsedJson['base'],
        // rates : rates_str,
        date : parsedJson ['date'],
        ratesList : ratesList
    );
  }
}

class Currency {
  String currencyName;
  double currencyRate;

  Currency(this.currencyName, this.currencyRate);
}

