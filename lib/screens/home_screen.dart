import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Go Router Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            const Text(
              'Welcome to Go Router Demo!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            
            const Text(
              'Navigation Examples:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            
            // Navigate using context.go()
            ElevatedButton.icon(
              onPressed: () => context.go('/profile'),
              icon: const Icon(Icons.person),
              label: const Text('Go to Profile (context.go)'),
            ),
            const SizedBox(height: 12),
            
            // Navigate using context.push()
            ElevatedButton.icon(
              onPressed: () => context.push('/settings'),
              icon: const Icon(Icons.settings),
              label: const Text('Push Settings (context.push)'),
            ),
            const SizedBox(height: 12),
            
            // Navigate with parameters
            ElevatedButton.icon(
              onPressed: () => context.push('/details/123?title=Sample Item'),
              icon: const Icon(Icons.info),
              label: const Text('Details with Parameters'),
            ),
            const SizedBox(height: 12),
            
            // Navigate using named route
            ElevatedButton.icon(
              onPressed: () => context.pushNamed(
                'details',
                pathParameters: {'id': '12345'},
                queryParameters: {'title': 'Fauzan putra sanjaya'},
              ),
              icon: const Icon(Icons.route),
              label: const Text('Details with Named Route'),
            ),
            const SizedBox(height: 12),
            
            // Deep Link Demo
            ElevatedButton.icon(
              onPressed: () => context.push('/deep-link-demo'),
              icon: const Icon(Icons.link),
              label: const Text('Deep Link Tutorial'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 32),
            
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Navigation Methods:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('• context.go() - Replaces current route'),
                    Text('• context.push() - Adds route to stack'),
                    Text('• context.pushNamed() - Push with name'),
                    Text('• context.pop() - Go back'),
                  ],
                ),
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
} 