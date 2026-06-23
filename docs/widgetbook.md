# Widgetbook en `habitu_ui`

## Requisitos

- Flutter instalado y disponible en `PATH`.
- Este repositorio clonado localmente.
- La app principal `habitu` puede usar un override local mientras los cambios del package no estén publicados.

## Ejecutar el catálogo

```bash
cd widgetbook
flutter pub get
flutter run
```

## Flujo de trabajo

1. Crear o actualizar un widget en `lib/src/widgets`.
2. Si hace falta, definir un modelo en `lib/src/models`.
3. Exportar el widget desde `lib/habitu_ui.dart`.
4. Registrar un caso en `widgetbook/lib/main.dart`.
5. Ejecutar Widgetbook y validar estados.
6. Integrar el widget desde `habitu`.
7. Publicar el repo `habitu_ui` y actualizar el `ref` consumido por la app principal.

## Consumir desde la app principal

Dependencia oficial en `habitu/pubspec.yaml`:

```yaml
dependencies:
  habitu_ui:
    git:
      url: https://github.com/EnriDv/habitu_ui.git
      ref: main
```

Override local para desarrollo no publicado en `habitu/pubspec_overrides.yaml`:

```yaml
dependency_overrides:
  habitu_ui:
    path: ../habitu_ui
```

## Checklist de migración

- El widget ya no importa notifiers, entidades ni servicios de `habitu`.
- Toda la lógica de negocio salió hacia callbacks o adapters.
- El widget tiene al menos un caso en Widgetbook.
- La app principal ya consume el widget desde `package:habitu_ui/habitu_ui.dart`.
