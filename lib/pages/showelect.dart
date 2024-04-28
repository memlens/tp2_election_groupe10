import 'package:flutter/material.dart';
import 'addelected.dart';
import 'candidates.dart';

class ShowElectPage extends StatefulWidget {
  const ShowElectPage({super.key});

  @override
  _ShowElectPageState createState() => _ShowElectPageState();
}

class _ShowElectPageState extends State<ShowElectPage> {
  int _selectedIndex = 0;
  final List<Candidate> _candidates = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addCandidate(Candidate candidate) {
    setState(() {
      _candidates.add(candidate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello Samiat'),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[300],
        child: Column(
          children: [
            // Horizontal navigation bar
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildNavigationButton('Presidential'),
                  _buildNavigationButton('Governship'),
                  _buildNavigationButton('LGDA'),
                ],
              ),
            ),
            // Candidates
            Expanded(
              child: ListView.builder(
                itemCount: _candidates.length,
                itemBuilder: (context, index) {
                  final candidate = _candidates[index];
                  return Container(
                    color: Colors.white,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: candidate.image != null
                            ? FileImage(candidate.image!)
                            : null,
                      ),
                      title: Text('${candidate.name} ${candidate.surname}'),
                      subtitle: Text(candidate.party),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddElectPage(
                addCandidate: (candidate) => _addCandidate(candidate),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Candidates: ${_candidates.length}'),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButton(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {},
        child: Text(title),
      ),
    );
  }
}
