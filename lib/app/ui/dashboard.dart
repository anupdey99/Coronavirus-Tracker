import 'dart:ffi';
import 'dart:io';

import 'package:coronavirus_tracker/app/model/covid_data.dart';
import 'package:coronavirus_tracker/app/repositories/data_repository.dart';
import 'package:coronavirus_tracker/app/services/api.dart';
import 'package:coronavirus_tracker/app/ui/info_card.dart';
import 'package:coronavirus_tracker/app/ui/last_update.dart';
import 'package:coronavirus_tracker/app/ui/show_alert_dialog.dart';
import 'package:coronavirus_tracker/app/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  CovidData? _covidData;

  @override
  void initState() {
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    _covidData = dataRepository.getAllEndpointCachedData();
    print(_covidData?.toString());
    _updateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormatter(
        lastUpdated: _covidData != null
            ? _covidData?.values[Endpoint.cases]?.date ?? ''
            : null);

    return Scaffold(
      appBar: AppBar(
        title: Text('Coronavirus Tracker'),
      ),
      body: RefreshIndicator(
        onRefresh: _updateData,
        child: ListView(
          children: <Widget>[
            LastUpdate(
              text: formatter.lastUpdatedStatusText(),
            ),
            for (var endpoint in Endpoint.values)
              InfoCard(
                  endpoint: endpoint,
                  value:
                      _covidData != null ? _covidData?.values[endpoint] : null)
          ],
        ),
      ),
    );
  }

  Future<Null> _updateData() async {
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    try {
      final CovidData data = await dataRepository.getAllEndpointData();
      setState(() {
        _covidData = data;
      });
    } on SocketException catch (e) {
      print(e);
      showAlertDialog(
          context: context,
          title: 'Connection Error',
          content: 'Could not retrieve data. Please try again later.',
          actionText: 'OK');
    } catch (e) {
      showAlertDialog(
          context: context,
          title: 'Unknown Error',
          content: 'Please contact support or try again later.',
          actionText: 'OK');
    }
  }
}
