import 'package:finmaker/features/common/widgets/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ClientDetailPage extends StatefulWidget {
  const ClientDetailPage({super.key, required this.clientId});

  final String clientId;

  @override
  State<ClientDetailPage> createState() => _ClientDetailPageState();
}

class _ClientDetailPageState extends State<ClientDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideBar(
            actionWidgets: [
              IconButton(
                icon: const Icon(Icons.chevron_left_sharp),
                onPressed: () {
                  // context.go('/clients');
                  Navigator.pop(context);
                },
              )
            ],
          ),
          Expanded(
            child: Center(
              child: Text(widget.clientId),
            ),
          )
        ],
      ),
    );
  }
}
