import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailsScreen extends StatelessWidget {
  final String id;
  final String title;

  const DetailsScreen({
    super.key,
    required this.id,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Route Parameters:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    Row(
                      children: [
                        const Icon(Icons.tag, color: Colors.blue),
                        const SizedBox(width: 8),
                        const Text(
                          'ID: ',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          id,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    
                    Row(
                      children: [
                        const Icon(Icons.title, color: Colors.green),
                        const SizedBox(width: 8),
                        const Text(
                          'Title: ',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    // Show additional query parameters if any
                    Builder(
                      builder: (context) {
                        final allQueryParams = GoRouterState.of(context).uri.queryParameters;
                        final additionalParams = Map<String, String>.from(allQueryParams);
                        additionalParams.remove('title'); // Remove already shown params
                        
                        if (additionalParams.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            const Divider(),
                            const SizedBox(height: 8),
                            const Text(
                              'Additional Parameters:',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            for (final entry in additionalParams.entries) Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Row(
                                children: [
                                  Icon(Icons.info_outline, size: 16, color: Colors.orange),
                                  SizedBox(width: 8),
                                  Text(
                                    '${entry.key}: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      entry.value,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            const Card(
              color: Colors.orange,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Parameter Explanation:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Path Parameter: /details/:id (captured from URL path)',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      '• Query Parameter: ?title=value (captured from URL query)',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            const Text(
              'Navigation Examples:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            
            ElevatedButton.icon(
              onPressed: () => context.goNamed(
                'details',
                pathParameters: {'id': 'new-${DateTime.now().millisecondsSinceEpoch}'},
                queryParameters: {'title': 'Dynamically Generated Item'},
              ),
              icon: const Icon(Icons.refresh),
              label: const Text('Generate New Details'),
            ),
            const SizedBox(height: 12),
            
            ElevatedButton.icon(
              onPressed: () => context.go('/profile'),
              icon: const Icon(Icons.person),
              label: const Text('Go to Profile'),
            ),
            const SizedBox(height: 12),
            
            ElevatedButton.icon(
              onPressed: () => context.push('/settings'),
              icon: const Icon(Icons.settings),
              label: const Text('Push Settings'),
            ),
            const SizedBox(height: 12),
            
            OutlinedButton.icon(
              onPressed: () => context.go('/'),
              icon: const Icon(Icons.home),
              label: const Text('Back to Home'),
            ),
            
            const SizedBox(height: 32),
            
            Card(
              color: Colors.purple,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Current Route:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      GoRouterState.of(context).uri.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'monospace',
                      ),
                    ),
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