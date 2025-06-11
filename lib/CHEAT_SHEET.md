# GoRouter Cheat Sheet 🚀

## Quick Setup

```dart
// 1. Add dependency
dependencies:
  go_router: ^14.6.1

// 2. Setup router
final router = GoRouter(
  initialLocation: '/',
  routes: [...],
);

// 3. Use MaterialApp.router
MaterialApp.router(
  routerConfig: router,
)
```

## Route Definitions

```dart
// Basic route
GoRoute(
  path: '/',
  name: 'home',
  builder: (context, state) => HomeScreen(),
)

// Route with path parameter
GoRoute(
  path: '/user/:id',
  builder: (context, state) {
    final id = state.pathParameters['id']!;
    return UserScreen(id: id);
  },
)

// Route with multiple parameters
GoRoute(
  path: '/post/:postId/comment/:commentId',
  builder: (context, state) {
    final postId = state.pathParameters['postId']!;
    final commentId = state.pathParameters['commentId']!;
    return CommentScreen(postId: postId, commentId: commentId);
  },
)
```

## Navigation Methods

```dart
// Replace current route
context.go('/profile');

// Push new route to stack
context.push('/settings');

// Go back
context.pop();

// Named navigation
context.goNamed('user', pathParameters: {'id': '123'});

// With query parameters
context.goNamed(
  'product',
  pathParameters: {'id': '456'},
  queryParameters: {'color': 'red', 'size': 'large'},
);

// Check if can pop
if (context.canPop()) {
  context.pop();
}
```

## Parameter Access

```dart
// In route builder
GoRoute(
  path: '/product/:id',
  builder: (context, state) {
    // Path parameters
    final id = state.pathParameters['id'];
    
    // Query parameters
    final color = state.uri.queryParameters['color'];
    final size = state.uri.queryParameters['size'];
    
    // Full URI
    final fullUri = state.uri.toString();
    
    return ProductScreen(id: id, color: color, size: size);
  },
)

// In widget
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = GoRouterState.of(context);
    final currentPath = state.uri.path;
    return Text('Current path: $currentPath');
  }
}
```

## Error Handling

```dart
GoRouter(
  routes: [...],
  errorBuilder: (context, state) => ErrorScreen(
    error: state.error,
    path: state.uri.path,
  ),
)
```

## Redirect & Guards

```dart
GoRouter(
  routes: [...],
  redirect: (context, state) {
    final isLoggedIn = AuthService.isLoggedIn;
    final isLoginRoute = state.uri.path == '/login';
    
    if (!isLoggedIn && !isLoginRoute) {
      return '/login';
    }
    
    if (isLoggedIn && isLoginRoute) {
      return '/home';
    }
    
    return null; // No redirect
  },
)
```

## Nested Routes

```dart
GoRoute(
  path: '/shop',
  builder: (context, state) => ShopLayout(),
  routes: [
    GoRoute(
      path: 'products',
      builder: (context, state) => ProductsScreen(),
    ),
    GoRoute(
      path: 'cart',
      builder: (context, state) => CartScreen(),
    ),
  ],
)
```

## Shell Routes (Persistent UI)

```dart
ShellRoute(
  builder: (context, state, child) => MainLayout(child: child),
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => ProfileScreen(),
    ),
  ],
)
```

## Common Patterns

### 1. Bottom Navigation
```dart
class MainLayout extends StatelessWidget {
  final Widget child;
  
  const MainLayout({required this.child});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          switch (index) {
            case 0: context.go('/home'); break;
            case 1: context.go('/search'); break;
            case 2: context.go('/profile'); break;
          }
        },
        items: [...],
      ),
    );
  }
}
```

### 2. Conditional Navigation
```dart
ElevatedButton(
  onPressed: () {
    if (userLoggedIn) {
      context.push('/dashboard');
    } else {
      context.push('/login');
    }
  },
  child: Text('Continue'),
)
```

### 3. Back Button Handling
```dart
AppBar(
  leading: IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () {
      if (context.canPop()) {
        context.pop();
      } else {
        context.go('/');
      }
    },
  ),
)
```

## Tips & Tricks 💡

1. **Always use named routes** for better maintainability
2. **Validate parameters** with null checks and defaults
3. **Use redirect for authentication** guards
4. **Keep router configuration** in separate file
5. **Test navigation flows** with widget tests
6. **Use Shell routes** for persistent layouts
7. **Handle deep links** gracefully with error builders

## Deep Linking 🔗

```dart
// Get current route URI
final currentUri = GoRouterState.of(context).uri;

// Share current route
Clipboard.setData(ClipboardData(text: currentUri.toString()));

// Handle custom URL schemes
routing_demo://details/123?title=Product&category=electronics

// Extract all query parameters
final allParams = state.uri.queryParameters;
```

## Common Gotchas ⚠️

- Path parameters are always `String?`
- Query parameters can be `null`
- Use `context.go()` carefully - it replaces navigation stack
- Routes are matched in order - put specific routes first
- Remember to handle back button on root routes
- Test deep links thoroughly on different platforms 