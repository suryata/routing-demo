# Go Router Demo - Tutorial Flutter Navigation

Aplikasi demo sederhana untuk belajar menggunakan package `go_router` di Flutter dengan clean code architecture.

## 🚀 Fitur-Fitur yang Didemonstrasikan

### 1. **Dasar-Dasar Navigation**
- `context.go()` - Mengganti route saat ini
- `context.push()` - Menambah route ke navigation stack
- `context.pop()` - Kembali ke route sebelumnya
- `context.goNamed()` - Navigasi menggunakan nama route

### 2. **Parameter Passing**
- **Path Parameters**: `/details/:id`
- **Query Parameters**: `?title=value`
- **Named Route Parameters**: Menggunakan `pathParameters` dan `queryParameters`

### 3. **Error Handling**
- Custom error page untuk route yang tidak ditemukan
- Redirect otomatis ke home page

## 📁 Struktur Project (Clean Architecture)

```
lib/
├── main.dart                 # Entry point aplikasi
├── router/
│   └── app_router.dart      # Konfigurasi routing
└── screens/
    ├── home_screen.dart     # Halaman utama
    ├── profile_screen.dart  # Halaman profile
    ├── settings_screen.dart # Halaman settings
    └── details_screen.dart  # Halaman detail dengan parameter
```

## 🛠️ Setup & Installation

1. **Clone atau download project ini**

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Jalankan aplikasi:**
   ```bash
   flutter run
   ```

## 📚 Tutorial Step-by-Step

### Step 1: Setup Go Router

Pertama, tambahkan dependency di `pubspec.yaml`:

```yaml
dependencies:
  go_router: ^14.6.1
```

### Step 2: Konfigurasi Router

Buat file `lib/router/app_router.dart`:

```dart
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      // Route lainnya...
    ],
  );
}
```

### Step 3: Setup MaterialApp.router

Di `main.dart`, gunakan `MaterialApp.router`:

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Go Router Demo',
      routerConfig: AppRouter.router,
    );
  }
}
```

## 🔍 Contoh-Contoh Navigation

### 1. Basic Navigation

```dart
// Mengganti route saat ini
context.go('/profile');

// Menambah route ke stack
context.push('/settings');

// Kembali ke route sebelumnya
context.pop();
```

### 2. Named Routes

```dart
context.goNamed('details', 
  pathParameters: {'id': '123'},
  queryParameters: {'title': 'Sample Title'}
);
```

### 3. Parameter Passing

```dart
// Route definition
GoRoute(
  path: '/details/:id',
  name: 'details',
  builder: (context, state) {
    final id = state.pathParameters['id'] ?? '0';
    final title = state.uri.queryParameters['title'] ?? 'Default';
    return DetailsScreen(id: id, title: title);
  },
),
```

## 💡 Tips & Best Practices

1. **Gunakan Named Routes** untuk navigasi yang lebih mudah dibaca
2. **Pisahkan Router Configuration** ke file terpisah untuk clean code
3. **Handle Error Cases** dengan `errorBuilder`
4. **Validasi Parameters** sebelum digunakan
5. **Gunakan const constructors** untuk performa yang lebih baik

## 🎯 Fitur-Fitur Go Router yang Digunakan

- ✅ Declarative routing
- ✅ Path parameters (`/details/:id`)
- ✅ Query parameters (`?title=value`)
- ✅ Named routes
- ✅ Error handling
- ✅ Navigation stack management
- ✅ URL-based navigation

## 📖 Referensi

- [Go Router Documentation](https://pub.dev/packages/go_router)
- [Flutter Navigation Guide](https://docs.flutter.dev/development/ui/navigation)
- [GoRouter API Reference](https://pub.dev/documentation/go_router/latest/)
---

**Happy Coding! 🚀**
