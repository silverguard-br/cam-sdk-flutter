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
            ref: 1.2.0
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

<!-- Camera (necessário para adicionar foto direto da camera em anexos) -->
<uses-permission android:name="android.permission.CAMERA" />
```

### iOS 

Adicionar permissão para microfone no arquivo `ios/Runner/Info.plist`

```xml
<key>NSMicrophoneUsageDescription</key>
<string>This app needs access to your microphone to record audio.</string>

<key>NSCameraUsageDescription</key>
<string>This app needs camera access to take photos/videos.</string>
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

                ## dart: PermissionGroup.camera
                'PERMISSION_CAMERA=1',
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
    ),
);
```

#### b) Visualizar lista de contestações

```Dart
SilverguardCAM.showList(
    context,
    RequestListUrlModel(
        reporterClientId: "12345678901"
    ),
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
    reporterBranchNumber: 1234,
    reporterAccountNumber: 12345678
)
```

#### `RequestListUrlModel` (lista de contestações)

```Dart
RequestListUrlModel(
    reporter_client_id: "12345678901",
    reporterBranchNumber: 1234,
    reporterAccountNumber: 12345678
)
```

---

### 5. Comunicação webview ⇄ Flutter

A comunicação entre a SDK e o seu código é realizada através de um sistema de mensagens.
O SDK já tem a parte de requisição de permissões implementada, mas se achar necessário você pode implementar seu próprio código. 
As classes `SilverguardBridge` e `SilverguardPermissionBridge` dão a possibilidade de implementação de callbacks e/ou sobrepor o código permissões.

`SilverguardBridge` - Contém apenas as ações de callback para a ação de voltar e command, que seria qualquer comando não mapeado no SDK.
Exemplo:
```Dart
class CustomBridge implements SilverguardBridge {
  @override
  void onBackCallback(String origin) {    
    // Informa que o usuário retornou e em $origin qual fluxo.
  }

  @override
  void onCommandCallback(String command) {
    // Retorna em $command todo comando retornado da webview sem mapeamento no SDK
  }  
}
```

`SilverguardPermissionBridge` - Além dos callbacks de `SilverguardBridge`, permite sobrepor o código de permissão de microfone e arquivos.
Exemplo:
```Dart
class CustomBridgeWithPermission implements SilverguardPermissionBridge {

  @override
  void onBackCallback(String origin) {
    // Informa que o usuário retornou e em $origin qual fluxo.
  }
  
  @override
  void onWebviewCallback(String command) {
    // Informa todo comando retornado da webview sem mapeamento no SDK
  }
  
  @override
  void onRequestLibraryPermission() {
    // Código que será chamado no momento em que a webview for checar a permissão de acesso aos arquivos
  }
  
  @override
  void onRequestMicrophonePermission() {
    // Código que será chamado no momento em que a webview for checar a permissão de acesso ao microfone
  }  

  @override
  void onRequestCameraPermission() {
    // Código que será chamado no momento em que a webview for checar a permissão de acesso a camera
  }  
}
```

Após a criação da classe, você deve passa-la para SDK, para que seu código seja chamado, conforme abaixo:

Código passando `SilverguardBridge`
```Dart 
final customBridge = CustomBridge();

SilverguardCAM.setSilverguardBridge(customBridge)
```

Código passando `SilverguardPermissionBridge`
```Dart
final customBridgeWithPermission = CustomBridgeWithPermission();

SilverguardCAM.setSilverguardBridge(customBridgeWithPermission)
```

OBS: Você deve criar e passar a classe `SilverguardBridge` ou a classe `SilverguardPermissionBridge`.
A classe `SilverguardCAM` é um singleton, então, a cada chamada da função `setSilverguardBridge` o valor anterior será sobreposto com o novo.
Para remover os callbacks pode ser passado a qualquer momento null para a função.
```Dart
SilverguardCAM.setSilverguardBridge(null)
```

### 6. Customização de Estilo (Opcional)

Você pode personalizar cores e fontes do SDK sobrepondo o tema base passando a classe `SilverguardTheme`.
Você deve passar opcionalmente para a classe o `SilverguardThemeTextStyles` e/ou o `SilverguardThemeColors` com o estilo de fonte ou cor que deseja para ser aplicado nas telas.

Exemplo de utilização:
```Dart 
SilverguardCAM.setSilverGuardTheme(
  SilverguardTheme(
    colors: SilverguardThemeColors(
      background: Colors.grey[300]!,
      primary: Colors.red,
      label: Colors.white,
      buttonTitle: Colors.white,
      buttonEnabled: Colors.red,
      buttonDisabled: Colors.blueGrey,
    ),
    textStyle: SilverguardThemeTextStyles(
      button: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      body: TextStyle(fontSize: 16),
      headline2: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      headline3: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
),
```

A classe `SilverguardCAM` é um singleton, então, a cada chamada da função `setSilverGuardTheme` o valor anterior será sobreposto com o novo.
Para remover o tema adicionado, voltando para o tema padrão, pode ser passado a qualquer momento null para a função.
```Dart
SilverguardCAM.setSilverGuardTheme(null)
```

## 📄 Licença

Este SDK é distribuído sob a licença proprietária da **Silverguard**. O uso é restrito a clientes autorizados.
