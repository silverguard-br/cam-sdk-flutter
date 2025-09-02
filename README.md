# SilverguardCAM

SDK Flutter para integração com o fluxo de **Contestação CAM** da Silverguard.

---

## 📦 Instalação

Adicione uma linha como esta ao `pubspec.yaml` do seu pacote:

```yaml
dependencies:
    silverguard:
        git: 
            url: https://github.com/silverguard-br/cam-sdk-flutter.git
            ref: 1.0.0
```

E execute:

```bash
flutter pub get
```

##  🔐 Permissões

### Android 

Adicionar permissões necessárias no arquivo `android/app/src/main/AndroidManifest.xml`

```xml
<uses-permission android:name="android.permission.INTERNET" />

<!-- Áudio (solicitadas em tempo de execução quando necessário) -->
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />

<!-- Upload de arquivos: só é necessário em Android 12L (API 32) ou inferior -->
<uses-permission
    android:name="android.permission.READ_EXTERNAL_STORAGE"
    android:maxSdkVersion="32" />
```

### iOS 

Adicionar permissão para microfone no arquivo `ios/Runner/Info.plist`

```xml
<key>NSMicrophoneUsageDescription</key>
<string>This app needs access to your microphone to record audio.</string>
```

Também é necessário adicionar a permissão no arquivo `ios/Podfile` 

Onde no arquivo encontrar o seguinte código 

```ruby
post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)    
  end
end
```

Alterar para 

```ruby
post_install do |installer|
    installer.pods_project.targets.each do |target|
        flutter_additional_ios_build_settings(target)
        
        ## silverguard flutter sdk permissions
        target.build_configurations.each do |config|
            config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= [
                '$(inherited)',

                ## dart: PermissionGroup.microphone
                'PERMISSION_MICROPHONE=1',

                ## dart: PermissionGroup.mediaLibrary
                'PERMISSION_MEDIA_LIBRARY=1',
            ]
        end
    end
end
```


## 🚀 Uso

### 1. Importação

```Dart
import 'package:silverguard/silverguard.dart';
```

---

### 2. Configuração 

Antes de iniciar qualquer fluxo, inicialize a classe do SDK com sua **API Key** e silverguard **Url Base**:

```Dart
SilverguardCAM.init(
      apiKey: 'SUA_API_KEY',
      baseUrl: 'URL_BASE_SILVERGUARD_API',
    );
```

---

### 3. Inicialização dos fluxos

O SDK oferece **dois fluxos principais**:

#### a) Criar uma nova contestação

```Dart
SilverguardCAM.getRequestUrlModel(
    context,
    RequestUrlModel(
        transactionId: generateRandomId(),
        transactionAmount: 150.0,
        transactionTime: "2025-07-11 11:10:00",
        transactionDescription: "Pagamento via PIX",
        reporterClientName: "John Doe",
        reporterClientId: '123456789',
        contestedParticipantId: "123456",
        counterpartyClientName: "Maria dos Santos",
        counterpartyClientId: '987654321',
        counterpartyClientKey: "DEST_KEY_1",
        protocolId: "PROT_2025_001",
        pixAuto: true,
        clientId: "CLI_456789",
        clientSince: "2020-01-15",
        clientBirth: "1985-03-22",
        autofraudRisk: true,
    ),
);
```

#### b) Visualizar lista de contestações

```Dart
SilverguardCAM.showList(
    context,
    RequestListUrlModel(reporterClientId: "12345678901"),
)
```

---

### 4. Exemplos de modelos enviados

#### `RequestUrlModel` (nova contestação)

```Dart
RequestUrlModel(
    transactionId: generateRandomId(),
    transactionAmount: 150.0,
    transactionTime: "2025-07-11 11:10:00",
    transactionDescription: "Pagamento via PIX",
    reporterClientName: "John Doe",
    reporterClientId: '123456789',
    contestedParticipantId: "123456",
    counterpartyClientName: "Maria dos Santos",
    counterpartyClientId: '987654321',
    counterpartyClientKey: "DEST_KEY_1",
    protocolId: "PROT_2025_001",
    pixAuto: true,
    clientId: "CLI_456789",
    clientSince: "2020-01-15",
    clientBirth: "1985-03-22",
    autofraudRisk: true,
)
```

#### `RequestListUrlModel` (lista de contestações)

```Dart
RequestListUrlModel(
    reporter_client_id = "12345678901"
)
```

---

### 5. Captura de retorno

Defina uma função para callback e ser notificado quando o usuário aciona voltar dentro do fluxo.
O SDK enviará um origin (string) indicando de qual tela/etapa o retorno ocorreu e finaliza a Activity do fluxo após o callback.

```Dart
SilverguardCAM.setBackCallback(void Function(String backOrigin));
```

## 📄 Licença

Este SDK é distribuído sob a licença proprietária da **Silverguard**. O uso é restrito a clientes autorizados.
