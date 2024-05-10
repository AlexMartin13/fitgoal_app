import 'package:fitgoal_app/widgets/appbar.dart';
import 'package:flutter/material.dart';

class PlayersTableScreen extends StatefulWidget {
  const PlayersTableScreen({super.key});

  @override
  State<PlayersTableScreen> createState() => _PlayersTableScreenState();
}

class _PlayersTableScreenState extends State<PlayersTableScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reducedAppBar(context, 'home'),
      backgroundColor: const Color.fromRGBO(1, 49, 45, 1),
      body: _buildTable(),
    );
  }

  Widget _buildTable(){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: DataTable(
          decoration: BoxDecoration(
            color: Colors.red
          ),
          columns: const [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Email')),
            DataColumn(label: Text('Date')),
          ],
          rows: const [
            DataRow(cells: [
              DataCell(Text('Name')),
              DataCell(Text('Email')),
              DataCell(Text('Date')),
            ],
        )]
            ),
      ));
  }
}
