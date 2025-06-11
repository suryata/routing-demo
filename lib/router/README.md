# Go Router Configuration

## Overview
File `app_router.dart` berisi konfigurasi utama untuk routing aplikasi menggunakan package `go_router`.

## Struktur Router

### 1. Router Initialization
```dart
static final GoRouter router = GoRouter(
  initialLocation: '/',  // Route pertama yang dibuka
  routes: [...],         // Daftar routes
  errorBuilder: {...}    // Handler untuk error/404
);
```

### 2. Route Types

#### A. Basic Route
```dart
GoRoute(
  path: '/',
  name: 'home',
  builder: (context, state) => const HomeScreen(),
)
```

#### B. Route dengan Path Parameter
```dart
GoRoute(
  path: '/details/:id',  // :id adalah path parameter
  name: 'details',
  builder: (context, state) {
    final id = state.pathParameters['id'] ?? '0';
    final title = state.uri.queryParameters['title'] ?? 'Default';
    return DetailsScreen(id: id, title: title);
  },
)
```

## Konsep Penting

### Path Parameters vs Query Parameters

**Path Parameters** (`/details/:id`):
- Bagian dari URL path
- Diakses dengan `state.pathParameters['key']`
- Contoh: `/details/123` → `id = '123'`

**Query Parameters** (`?title=value&category=news`):
- Bagian setelah `?` di URL
- Diakses dengan `state.uri.queryParameters['key']`
- Contoh: `/details/123?title=Sample` → `title = 'Sample'`

### Error Handling
Router ini memiliki `errorBuilder` yang akan menampilkan halaman error khusus ketika user mengakses route yang tidak ada.

### Navigation Methods
- `context.go('/path')` - Mengganti route saat ini
- `context.push('/path')` - Menambah route ke stack
- `context.pop()` - Kembali ke route sebelumnya
- `context.goNamed('routeName')` - Navigasi dengan nama route

## Best Practices

1. **Gunakan named routes** untuk kemudahan maintenance
2. **Validasi parameters** sebelum digunakan (null safety)
3. **Handle error cases** dengan errorBuilder
4. **Pisahkan router config** dari main.dart untuk clean architecture 