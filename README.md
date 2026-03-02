Family Guard
Tree Project
lib/
├── core/                          # Shared resources toàn app
│   ├── constants/                 # Hằng số (color, text, key, ...)
│   ├── theme/                     # App theme, color scheme, text style
│   ├── utils/                     # Helper, extension, formatter, ...
│   ├── network/                   # Dio client, interceptors, API config
│   ├── error/                     # Exception, failure handling
│   └── widgets/                   # Reusable global widgets
│
├── features/                      # Feature-based modules
│   ├── login/
│   │   ├── data/                  # Data layer
│   │   │   ├── datasources/       # Remote & local data source
│   │   │   ├── models/            # DTO models (JSON)
│   │   │   └── repositories_impl/ # Repository implementation
│   │   │
│   │   ├── domain/                # Business logic layer
│   │   │   ├── entities/          # Core business entities
│   │   │   ├── repositories/      # Abstract repository
│   │   │   └── usecases/          # Login use case
│   │   │
│   │   └── presentation/          # UI layer
│   │       ├── screens/           # Login screens
│   │       ├── cubit/             # State management (Cubit/Bloc)
│   │       └── widgets/           # Local widgets (if needed)
│   │
│   └── ...                        # Other features (register, home, sos,...)
│
└── main.dart                      # Entry point
