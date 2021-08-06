import 'package:coronavirus_tracker/app/model/card_data.dart';
import 'package:coronavirus_tracker/app/model/case_data.dart';
import 'package:coronavirus_tracker/app/services/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({Key? key, required this.endpoint, required this.value})
      : super(key: key);
  final Endpoint endpoint;
  final CaseData? value;
  static Map<Endpoint, CardData> _cardsData = {
    Endpoint.cases: CardData('Cases', 'assets/count.png', Color(0xFFFFF492)),
    Endpoint.casesSuspected:
        CardData('Suspected cases', 'assets/suspect.png', Color(0xFFEEDA28)),
    Endpoint.casesConfirmed:
        CardData('Confirmed cases', 'assets/fever.png', Color(0xFFE99600)),
    Endpoint.deaths: CardData('Deaths', 'assets/death.png', Color(0xFFE40000)),
    Endpoint.recovered:
        CardData('Recovered', 'assets/patient.png', Color(0xFF70A901)),
  };

  String get formattedValue {
    if (value?.data != null) {
      return NumberFormat('#,###,###,###').format(value?.data);
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final cardData = _cardsData[endpoint]!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cardData.title,
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: cardData.color,
                    ),
              ),
              SizedBox(
                height: 4.0,
              ),
              SizedBox(
                height: 52.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      cardData.assetName,
                      color: cardData.color,
                    ),
                    Text(
                      formattedValue,
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                          color: cardData.color, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
