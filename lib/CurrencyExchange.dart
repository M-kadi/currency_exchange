class CurrencyExchange {
  String base;
  String rates;
  String date;

  CurrencyExchange({
    this.base,
    this.rates,
    this.date
  });

  factory CurrencyExchange.fromJson(Map<String, dynamic> parsedJson){

    // Convert InternalLinkedHashMap to String value
    String rates_str = "";
    Map<String, dynamic> rates = parsedJson['rates'];
    rates.forEach((k,v) => rates_str += k + " : " + v.toString() + "\n");

    return CurrencyExchange(
        base: parsedJson['base'],
        rates : rates_str,
        date : parsedJson ['date']
    );
  }

}

