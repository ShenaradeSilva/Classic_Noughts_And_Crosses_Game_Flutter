import 'package:flutter/material.dart';
import '../logo/logo.dart';
import 'profile_card_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _nameController = TextEditingController();
  String? _selectedDifficulty;
  bool _showGameSetup = false;
  PlayerProfile? _selectedProfile;

  // Show profile card selection modal with optional "None"
  void _selectProfileCard() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // None option
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedProfile = null;
                });
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: _selectedProfile == null
                          ? Colors.yellow
                          : Colors.transparent,
                      width: 3),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.clear, color: Colors.white, size: 50),
                    SizedBox(height: 8),
                    Text('None', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
            // Profile options
            ...PlayerProfile.values.map((profile) {
              final isSelected = _selectedProfile == profile;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedProfile = profile;
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: isSelected ? Colors.yellow : Colors.transparent,
                        width: 3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        profile == PlayerProfile.male
                            ? 'assets/male.png'
                            : 'assets/female.png',
                        height: 80,
                        width: 80,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        profile.name.toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: _showGameSetup
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  setState(() {
                    _showGameSetup = false;
                    _nameController.clear();
                    _selectedDifficulty = null;
                    _selectedProfile = null;
                  });
                },
              ),
            )
          : null,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Tic Tac Toe Game',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              const TicTacToeLogo(),
              const SizedBox(height: 40),

              if (!_showGameSetup)
                ElevatedButton(
                  onPressed: () => setState(() => _showGameSetup = true),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.purple,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  child: const Text('Get Started', style: TextStyle(fontSize: 16)),
                ),

              if (_showGameSetup) ...[
                ProfileCardField(
                  nameController: _nameController,
                  selectedProfile: _selectedProfile,
                  onProfileSelected: (profile) =>
                      setState(() => _selectedProfile = profile),
                  onTapSelectProfile: _selectProfileCard,
                ),
                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: DropdownButtonFormField<String>(
                    value: _selectedDifficulty,
                    dropdownColor: Colors.purple[700],
                    decoration: InputDecoration(
                      labelText: 'Select Difficulty',
                      labelStyle: const TextStyle(color: Colors.white70),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white70),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'easy', child: Text('Easy')),
                      DropdownMenuItem(value: 'medium', child: Text('Medium')),
                      DropdownMenuItem(value: 'hard', child: Text('Hard')),
                    ],
                    onChanged: (value) => setState(() => _selectedDifficulty = value),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    if (_nameController.text.isEmpty || _selectedDifficulty == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please enter name and select difficulty!',
                          ),
                        ),
                      );
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Player: ${_nameController.text}, Difficulty: $_selectedDifficulty, Profile Card: ${_selectedProfile ?? "None"}',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.purple,
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Start Game',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}