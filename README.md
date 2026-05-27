# Flutter Test Task

Тестовое мобильное приложение, разработанное на Flutter.

Приложение включает:
- Нативный Splash Screen
- Onboarding экран
- Бесконечную ленту
- Интеграцию с GitHub API (через Dio)
- Управление состоянием и зависимостями через Provider

---

# Функционал

## Splash Screen
Нативный экран загрузки, отображаемый при запуске приложения.

## Onboarding
Многостраничный onboarding.

## Бесконечная лента

Бесконечно прокручиваемый список GitHub-репозиториев организации Facebook.

Источник данных:
https://api.github.com/orgs/facebook/repos

Пагинация реализована с помощью ленивой динамической подгрузки страниц

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
git clone https://github.com/Senzaj/flutter_app.git
```

Перейти в папку проекта:

```bash
cd flutter_app
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
