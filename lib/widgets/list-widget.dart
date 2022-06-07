import 'package:flutter/cupertino.dart';
import 'package:test_mobile/models/numberDto.dart';

import '../connections/database-connection.dart';

class ListWidget extends StatefulWidget {
  const ListWidget({Key? key}) : super(key: key);

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Previous Numbers",
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20
        )),
        FutureBuilder<List<NumberDto>>(
            future: DatabaseHelper.instance.getNumbers(),
            builder: (BuildContext context,
                AsyncSnapshot<List<NumberDto>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: Text('Loading...'));
              }
              return snapshot.data!.isEmpty
                  ? const Center(child: Text('No Numbers'))
                  : Padding(
                    padding: const EdgeInsets.fromLTRB(185, 10, 0, 0),
                    child: ListView(
                shrinkWrap: true,
                children: snapshot.data!.map((numbers) {
                    return Text(
                      numbers.number
                    );
                }).toList(),
              ),
                  );
            }),
      ],
    );
  }
}
