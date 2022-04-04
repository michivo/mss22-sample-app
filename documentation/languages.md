## How to use other languages

When you want to translate your written text you have to do this steps:

in lib/l10n/app_de.arb, add your word or phrase with the a key 

```
"test" : "das ist ein test"
```
in lib/l10n/app_en.arb, add the translated english version with the same key 

```
"test" : "this is a test"
```
make sure that the key begin with a lowercase!

build the the application to generate the new translated values

enter ```flutter build apk --debug```

this will update files in .dart_tool/flutter_gen/gen_l10n

Usage:

import in your view 
```
import 'package:flutter_gen/gen_l10n/
app_localizations.dart';

```
add AppLocalizations.of(context)!.```<key>``` in the Textfield
```
Text(AppLocalizations.of(context)!.test),
```

Run the Application:
```
flutter run lib/main.dart
```