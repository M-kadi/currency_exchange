import 'package:flutter/material.dart';
import 'CurrencyExchange.dart';

class MyHomePage extends StatelessWidget {
  final String title;
  final Future<CurrencyExchange> currencyExchange;

  MyHomePage({Key key, this.title, this.currencyExchange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.title)),
      body: Center(
        child: FutureBuilder<CurrencyExchange>(
          future: currencyExchange, builder: (context, snapshot) {

          // Check if internet is Connected
          if (snapshot.hasError || snapshot.data == null) {
            print(snapshot.error.toString());
            return CurrencyExchangePageNoConnection();
          }
          else
            return CurrencyExchangePage(currencyExchange: snapshot.data);
        },
        ),
      ),
    );

  }
}

class CurrencyExchangePage extends StatelessWidget {
  final CurrencyExchange currencyExchange;
  CurrencyExchangePage({Key key, this.currencyExchange});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),

        Text(this.currencyExchange.base,
          style: TextStyle(fontWeight: FontWeight.bold),),
        Spacer(),

        Text(this.currencyExchange.date,
          style: TextStyle(fontWeight: FontWeight.bold),),
        Spacer(),

        ListView.builder(
          shrinkWrap : true,
          itemCount: currencyExchange.ratesList.length,
          itemBuilder: (context, index) {
            return Container(
              // add divider : line
              decoration: BoxDecoration( //                    <-- BoxDecoration
                border: Border(bottom: BorderSide()),
              ),
              child: CurrencyBox(item: currencyExchange.ratesList[index]),
            );
          },
        ),

        // Text(this.currencyExchange.rates),
      ],
    );
  }
}

class CurrencyBox extends StatelessWidget {
  CurrencyBox({Key key, this.item}) : super(key: key);
  final Currency item;

  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(this.item.currencyName,
              style: TextStyle(fontWeight: FontWeight.bold)),
        )),

        Expanded(
            child: Text(this.item.currencyRate.toString()))
      ],
    );
  }
}

// Check if internet is Connected
class CurrencyExchangePageNoConnection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("No Internet",
          style: TextStyle(fontWeight: FontWeight.bold),)
      ],
    );
  }
}
