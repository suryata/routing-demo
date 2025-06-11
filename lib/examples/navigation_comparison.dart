// Contoh perbandingan antara Navigator tradisional vs GoRouter

/* 
=======================================================================
NAVIGATOR TRADISIONAL (MaterialApp)
=======================================================================
*/

// 1. SETUP - MaterialApp dengan routes
/*
MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => HomeScreen(),
    '/profile': (context) => ProfileScreen(),
    '/settings': (context) => SettingsScreen(),
  },
)
*/

// 2. NAVIGATION - Menggunakan Navigator
/*
// Push ke route baru
Navigator.pushNamed(context, '/profile');

// Push dengan arguments
Navigator.pushNamed(
  context, 
  '/details',
  arguments: {'id': '123', 'title': 'Sample'}
);

// Pop kembali
Navigator.pop(context);

// Replace current route
Navigator.pushReplacementNamed(context, '/profile');
*/

// 3. PARAMETER PASSING - Melalui arguments
/*
class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = 
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String id = args['id'];
    final String title = args['title'];
    
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Text('ID: $id'),
    );
  }
}
*/

/* 
=======================================================================
GO ROUTER (Modern Approach)
=======================================================================
*/

// 1. SETUP - MaterialApp.router dengan GoRouter
/*
MaterialApp.router(
  routerConfig: GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => ProfileScreen(),
      ),
      GoRoute(
        path: '/details/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'];
          final title = state.uri.queryParameters['title'];
          return DetailsScreen(id: id, title: title);
        },
      ),
    ],
  ),
)
*/

// 2. NAVIGATION - Menggunakan context extensions
/*
// Push ke route baru
context.push('/profile');

// Go to route (replace)
context.go('/profile');

// Named navigation
context.goNamed('details', 
  pathParameters: {'id': '123'},
  queryParameters: {'title': 'Sample'}
);

// Pop kembali
context.pop();
*/

// 3. PARAMETER PASSING - Melalui URL
/*
class DetailsScreen extends StatelessWidget {
  final String id;
  final String title;
  
  const DetailsScreen({
    required this.id,
    required this.title,
  });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Text('ID: $id'),
    );
  }
}
*/

/* 
=======================================================================
PERBANDINGAN KEUNTUNGAN
=======================================================================

NAVIGATOR TRADISIONAL:
✓ Familiar untuk developer lama
✓ Simple untuk aplikasi sederhana
✗ Tidak URL-friendly
✗ Sulit handle deep linking
✗ Parameter passing tidak type-safe
✗ Tidak mendukung web dengan baik

GO ROUTER:
✓ URL-based navigation (web-friendly)
✓ Type-safe parameter passing
✓ Declarative routing
✓ Better deep linking support
✓ Error handling built-in
✓ Named routes dengan parameter
✓ Automatic back button handling
✗ Learning curve untuk developer baru
✗ Sedikit lebih complex untuk setup awal

=======================================================================
KAPAN MENGGUNAKAN GO ROUTER?
=======================================================================

Gunakan GoRouter jika:
- Aplikasi akan di-deploy ke web
- Butuh deep linking yang robust
- Ingin URL yang SEO-friendly
- Aplikasi memiliki struktur navigasi yang complex
- Tim development sudah familiar dengan declarative approach

Gunakan Navigator jika:
- Aplikasi mobile-only yang simple
- Tim masih learning Flutter
- Prototyping cepat
- Tidak butuh URL-based navigation

*/ 