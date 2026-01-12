# Cordova Screenshot Detector iOS (Native)

Plugin nativo para iOS que detecta capturas de pantalla usando la API nativa de Apple:
`UIApplicationUserDidTakeScreenshotNotification`

## ✅ Ventajas sobre otros métodos:
- **100% confiable** - Usa la API oficial de Apple
- **Sin heurísticas** - Detección directa sin falsos positivos
- **Automático** - Se activa al iniciar la app
- **Ligero** - Solo código nativo Objective-C

## 📦 Instalación

### Opción 1: Desde carpeta local
```bash
cordova plugin add /ruta/a/cordova-plugin-screenshot-ios
```

### Opción 2: Subir a GitHub y usar URL
```xml
<plugin name="cordova-plugin-screenshot-ios-native" spec="https://github.com/tu-usuario/cordova-plugin-screenshot-ios.git"/>
```

## 🚀 Uso en JavaScript

```javascript
document.addEventListener('deviceready', function() {
    // El plugin se activa automáticamente
    
    // Escuchar el evento personalizado
    document.addEventListener('screenshotDetected', function(event) {
        console.log('¡Screenshot detectado!', event.timestamp);
        
        // Tu código aquí
        registrarCapturaPantalla();
    }, false);
    
    console.log('Screenshot detector listo');
}, false);
```

## 🔧 Cómo funciona

1. Al iniciar la app, el plugin registra un observer nativo de iOS
2. iOS notifica automáticamente cuando el usuario toma screenshot
3. El plugin captura la notificación y dispara un evento JavaScript
4. Tu código JavaScript responde al evento

## ⚠️ Limitaciones

- **Solo iOS**: Este plugin solo funciona en iOS (Apple proporciona la API)
- **Detección únicamente**: No puede prevenir screenshots (limitación de iOS)
- **Requiere iOS 7+**: La API está disponible desde iOS 7

## 📝 API

### Evento: `screenshotDetected`

Se dispara automáticamente cuando se detecta un screenshot.

**Propiedades del evento:**
- `timestamp`: Milisegundos desde epoch cuando ocurrió

## 🐛 Debug

Para ver logs en Xcode:
1. Abre el proyecto en Xcode
2. Ejecuta en simulador o dispositivo
3. Mira la consola: `[ScreenshotDetector] ¡SCREENSHOT DETECTADO!`

## 📄 Licencia

MIT
