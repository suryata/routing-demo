Rimport 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class DeepLinkDemoScreen extends StatefulWidget {
  const DeepLinkDemoScreen({super.key});

  @override
  State<DeepLinkDemoScreen> createState() => _DeepLinkDemoScreenState();
}

class _DeepLinkDemoScreenState extends State<DeepLinkDemoScreen> {
  final TextEditingController _urlController = TextEditingController();
  String _lastDeepLink = '';

  @override
  void initState() {
    super.initState();
    _urlController.text = 'routing_demo://details/deep123?title=Deep Link Example';
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  void _simulateNotification() {
    // Simulasi notifikasi yang membuka deep link
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.notifications, color: Colors.blue),
            SizedBox(width: 8),
            Text('Notification'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'New Message Received!',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('You have a new message from John. Tap to view details.'),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Deep Link: /details/msg123?title=Message from John',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Dismiss'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.push('/details/msg123?title=Message from John&sender=John Doe');
              setState(() {
                _lastDeepLink = '/details/msg123?title=Message from John&sender=John Doe';
              });
            },
            child: Text('Open'),
          ),
        ],
      ),
    );
  }

  void _simulateEmailLink() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.email, color: Colors.green),
            SizedBox(width: 8),
            Text('Email Link'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password Reset Request',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Click the link below to reset your password:'),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Text(
                'https://yourapp.com/reset-password?token=abc123&user=john',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: Colors.blue[800],
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.push('/details/reset123?title=Password Reset&token=abc123&user=john');
              setState(() {
                _lastDeepLink = '/details/reset123?title=Password Reset&token=abc123&user=john';
              });
            },
            child: Text('Open Link'),
          ),
        ],
      ),
    );
  }

  void _shareCurrentRoute() {
    final currentUri = GoRouterState.of(context).uri;
    Clipboard.setData(ClipboardData(text: currentUri.toString()));
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.share, color: Colors.white),
            SizedBox(width: 8),
            Expanded(
              child: Text('Current route copied to clipboard: ${currentUri.toString()}'),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _navigateToCustomUrl() {
    final url = _urlController.text.trim();
    if (url.isEmpty) return;

    try {
      // Extract path and query from custom URL
      String path = '';
      String query = '';
      
      if (url.contains('://')) {
        // Handle custom scheme URLs
        final parts = url.split('://');
        if (parts.length > 1) {
          final pathAndQuery = parts[1];
          if (pathAndQuery.contains('?')) {
            final urlParts = pathAndQuery.split('?');
            path = '/${urlParts[0]}';
            query = '?${urlParts[1]}';
          } else {
            path = '/$pathAndQuery';
          }
        }
      } else if (url.startsWith('/')) {
        // Handle direct path URLs
        if (url.contains('?')) {
          final urlParts = url.split('?');
          path = urlParts[0];
          query = '?${urlParts[1]}';
        } else {
          path = url;
        }
      }

      final fullPath = '$path$query';
      context.push(fullPath);
      setState(() {
        _lastDeepLink = fullPath;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid URL format: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deep Link Demo'),
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
              const Text(
                'Deep Link Tutorial',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              const Card(
                color: Colors.blue,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'What is Deep Linking?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Deep linking allows users to navigate directly to specific screens in your app through URLs, notifications, or external links.',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              const Text(
                'Simulation Examples:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              
              // Notification Simulation
              Card(
                elevation: 2,
                child: ListTile(
                  leading: Icon(Icons.notifications, color: Colors.blue),
                  title: Text('Push Notification'),
                  subtitle: Text('Simulate notification with deep link'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: _simulateNotification,
                ),
              ),
              const SizedBox(height: 8),
              
              // Email Link Simulation
              Card(
                elevation: 2,
                child: ListTile(
                  leading: Icon(Icons.email, color: Colors.green),
                  title: Text('Email Link'),
                  subtitle: Text('Simulate email with deep link'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: _simulateEmailLink,
                ),
              ),
              const SizedBox(height: 8),
              
              // Share Current Route
              Card(
                elevation: 2,
                child: ListTile(
                  leading: Icon(Icons.share, color: Colors.orange),
                  title: Text('Share Current Route'),
                  subtitle: Text('Copy current route to clipboard'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: _shareCurrentRoute,
                ),
              ),
              
              const SizedBox(height: 24),
              
              const Text(
                'Custom URL Navigator:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Enter a deep link URL:',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _urlController,
                        decoration: const InputDecoration(
                          hintText: 'routing_demo://details/123?title=Example',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.link),
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _navigateToCustomUrl,
                          icon: const Icon(Icons.navigation),
                          label: const Text('Navigate to URL'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Deep Link Examples
              const Text(
                'Example Deep Links:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDeepLinkExample(
                        'User Profile',
                        '/details/user123?title=John Doe Profile&type=user',
                        'Opens user profile with ID 123',
                      ),
                      const Divider(),
                      _buildDeepLinkExample(
                        'Product Details',
                        '/details/product456?title=iPhone 15&category=electronics&price=999',
                        'Opens product page with multiple parameters',
                      ),
                      const Divider(),
                      _buildDeepLinkExample(
                        'Settings Page',
                        '/settings',
                        'Opens app settings directly',
                      ),
                    ],
                  ),
                ),
              ),
              
              if (_lastDeepLink.isNotEmpty) ...[
                const SizedBox(height: 24),
                Card(
                  color: Colors.green[50],
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.green),
                            SizedBox(width: 8),
                            Text(
                              'Last Deep Link Accessed:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green[800],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.green.shade200),
                          ),
                          child: Text(
                            _lastDeepLink,
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeepLinkExample(String title, String url, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            context.push(url);
            setState(() {
              _lastDeepLink = url;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    url,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: Colors.blue[800],
                    ),
                  ),
                ),
                Icon(
                  Icons.touch_app,
                  size: 16,
                  color: Colors.blue[600],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
} 