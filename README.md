# Sellio Mobile Monorepo

Welcome to the Sellio Mobile Monorepo! This repository contains the code for the Customer, Seller, and Admin applications, all managed within a single workspace.

# sellio UI/UX
[https://www.figma.com/design/tChatRJKUjnpIlaundGyy6/MENA-APP?node-id=24127-6644&t=WzzFGOCbVWaokK79-1](https://www.figma.com/design/LX6p0Y8cGYXUyRteZDLPBD/Sellio--Copy-new-?node-id=33-5526&p=f)


## Project Structure

The project is organized as a Melos-managed monorepo:

```
sellio_mobile/
├── apps/
│   ├── customer/       # The main customer-facing application
│   ├── seller/         # The seller application (In Development)
│   └── admin/          # The admin dashboard application (In Development)
├── packages/
│   └── design_system/  # Shared UI components, themes, and assets
└── melos.yaml          # Workspace configuration
```

## Getting Started

### Prerequisites

- Flutter SDK (latest stable)
- Melos (`dart pub global activate melos`)

### Setup

1.  **Bootstrap the workspace**: Link all packages together.
    ```bash
    melos bootstrap
    ```

2.  **Generate Codes (if needed)**:
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```
    (Run this inside specific app directories if they use code generation)

## Running the Apps

### Customer App

```bash
cd apps/customer
flutter run
```

### Seller App

```bash
cd apps/seller
flutter run
```

### Admin App

```bash
cd apps/admin
flutter run
```

## Shared Design System

The `packages/design_system` package contains all shared UI elements.

- **Importing**: `import 'package:design_system/design_system.dart';`
- **Assets**: Assets are located in `packages/design_system/assets`. They are exported via the `AppImages` class.
- **Modifying**: If you add new assets or components, ensure you export them in `lib/design_system.dart` and update `pubspec.yaml` if dependencies change.

## Development Workflow

- **New Dependencies**: If adding a dependency that is used across multiple apps, consider adding it to the relevant package or individual app `pubspec.yaml`.
- **State Management**: We use `flutter_bloc`.
- **Navigation**: We use `go_router`.

For more details, please refer to the internal documentation.
