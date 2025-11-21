# Project Context: GenUiProject

## Overview
This project is a Flutter workspace containing a custom UI package and a test application. It is structured to allow simultaneous development of the library and the consuming application.

## Directory Structure
*   `flutter_gen_ui/`: A Flutter package containing reusable UI components and logic. This is the core library project.
*   `test_app/`: A Flutter application configured to use `flutter_gen_ui` via a local path dependency. It serves as a test harness and example implementation.

## Key Technologies
*   **Framework**: Flutter (Dart SDK ^3.10.0)
*   **Linting**: `flutter_lints`

## Development Workflow

### Running the App
To run the test application:
1.  Navigate to the app directory: `cd test_app`
2.  Get dependencies: `flutter pub get`
3.  Run the app: `flutter run`

### Testing
*   **Package Tests**:
    ```bash
    cd flutter_gen_ui
    flutter test
    ```
*   **App Tests**:
    ```bash
    cd test_app
    flutter test
    ```

### Dependencies
The `test_app` depends on `flutter_gen_ui` locally. Changes in the `flutter_gen_ui` directory should be immediately reflected in `test_app` after a hot reload or restart.
