# Flutter Test Task

Тестовое мобильное приложение, разработанное на Flutter.

Приложение включает:
- Нативный Splash Screen
- Onboarding экран
- Бесконечную ленту
- Интеграцию с GitHub API
- Архитектуру MVVM
- Управление состоянием через Provider

---

# Функционал

## Splash Screen
Нативный экран загрузки, отображаемый при запуске приложения.

## Onboarding
Многостраничный onboarding, реализованный с использованием `PageView`.

## Бесконечная лента

Бесконечно прокручиваемый список GitHub-репозиториев организации Facebook.

Источник данных:
https://api.github.com/orgs/facebook/repos

Пагинация реализована с помощью:
- `ScrollController`
- ленивой загрузки
- динамической подгрузки страниц

---

# Структура проекта

```text
lib/
│
├── core/
├── features/
│
├── features/splash/
├── features/onboarding/
├── features/feed/
│
│   ├── data/
│   │   ├── models/
│   │   ├── repositories/
│   │   └── services/
│   │
│   ├── presentation/
│   └── viewmodel/
```

---

# Технологии

- Flutter
- Dart
- Provider
- Dio
- MVVM
- Clean Architecture

---

# Запуск проекта

## Требования

- Flutter SDK
- Android Studio или VS Code
- Android SDK
- Android Emulator или физическое устройство

---

# Установка

Клонировать репозиторий:

```bash
git clone <(https://github.com/Senzaj/flutter_app.git)>
```

Перейти в папку проекта:

```bash
cd flutter_test_task
```

Установить зависимости:

```bash
flutter pub get
```

Запустить приложение:

```bash
flutter run
```

---

# API

Для загрузки репозиториев используется GitHub REST API:
https://api.github.com/orgs/facebook/repos
