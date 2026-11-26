# GovermentServices

A VIPER demo app that shows the hot water shutoff schedule from a public open-data service.

The app downloads the dataset as a ZIP archive, unpacks it, stores the schedule in Core Data and lists the affected addresses with their shutoff dates.

## Architecture

Each screen is a VIPER module generated with [Generamba](https://github.com/strongself/Generamba) from the `swifty_viper` template in `Templates/`:

```
Modules/HotWaterShutoff/
├── Configurator   — wires the module together
├── Interactor     — loads and filters the schedule
├── Presenter      — formats data for the view
└── View           — UIKit screen
```

| Folder | Contents |
|---|---|
| `Services/DataService` | Network API with Moya |
| `Services/FileService` | Download and unzip |
| `Services/Storage` | Core Data model and storage |
| `Entities` | Schedule and date period models |

## Running

```sh
pod install
open GovermentServices.xcworkspace
```

Dependencies: Moya, Zip, SwiftGen.
