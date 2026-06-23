# habitu_ui

`habitu_ui` es el package de UI compartida de Habitu. Aquí viven los tokens, el tema, los widgets base, los bloques visuales extraídos desde la app principal y el catálogo visual para revisar componentes de forma aislada.

## Qué contiene

- Tokens visuales: color, tipografía y tema.
- Widgets core: `HabituButton`, `HabituCard`, `HabituNavigationBar`.
- Widgets de foundations: métricas, estados vacíos, secciones, notices y switchers.
- Widgets de dominio desacoplados mediante props y callbacks.
- Una app de catálogo con Widgetbook en `widgetbook/`.

## Estructura

```text
lib/
  habitu_ui.dart
  src/
    models/
    theme/
    tokens/
    widgets/
      core/
      foundations/
      habits/
      social/
widgetbook/
docs/
```

## Convención de widgets

- `habitu_ui` no importa notifiers, repositorios ni servicios de `habitu`.
- Todo dato de negocio llega como props o view models puros.
- Los side effects se inyectan con callbacks desde la app principal.
- Los bloques visuales extraídos desde pantallas viven en `widgets/foundations/`.

## Cómo agregar un widget

1. Crear o mover el widget a la carpeta adecuada dentro de `lib/src/widgets`.
2. Si depende de datos de negocio, crear un view model en `lib/src/models`.
3. Exportarlo desde `lib/habitu_ui.dart`.
4. Agregar al menos un caso visible en `widgetbook/lib/main.dart`.
5. Añadir o actualizar tests si el widget tiene lógica visual importante.

## Cómo ejecutar Widgetbook

```bash
cd widgetbook
flutter pub get
flutter run
```

## Cómo consumir desde `habitu`

La dependencia oficial debe venir por Git:

```yaml
dependencies:
  habitu_ui:
    git:
      url: https://github.com/EnriDv/habitu_ui.git
      ref: main
```

Para desarrollo local en esta workspace, `habitu` puede usar `pubspec_overrides.yaml` apuntando a `../habitu_ui` sin tocar la dependencia oficial.
