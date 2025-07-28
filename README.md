# TurboVets Flutter Challenge
This is a messaging app with an embedded internal tools dashboard. It has a native messaging interface built in Flutter and an embedded Angular (with TailwindCSS styling) dashboard displayed via WebView from within the Flutter app interface. The dashboard has a ticket status tracker, a knowledgebase editor (markdown editor) and a live log console.

## Angular Server
The Angular Server that hosts the internal tools dashboard can be run with this command:

```
cd webpage
ng serve
```

You can also run it using ```ng serve --host 0.0.0.0 --port 4200``` to make the Angular web server visible to other devices on the network. This is required if you are testing the Flutter app with a physical device. 


## Flutter App
In order to run the Flutter app, you need to run these commands from the main directory:

```
cd flutter_app
flutter pub get
flutter run
```
You may also need to run ```flutter doctor``` to fix any issues with Flutter.

You will likely get prompted to choose a device to run the app on. If you are using a physical device, you should replace line 28 in *flutter_app/lib/webview_screen.dart* with ```..loadRequest(Uri.parse('http://192.168.xxx.xxx:4200'));```, where xxx.xxx is the rest of your computers IP address.

## Project Structure
```
turbovets_challenge/
├── flutter_app/                            # Flutter mobile application
│   ├── pubspec.yaml                        # Flutter dependencies
│   ├── lib/
│   │   ├── main.dart                       # App entry point with navigatation
│   │   ├── chat_screen.dart                # Chat functionality
│   │   ├── webview_screen.dart             # Embedded dashboard - loaded via WebViewer
│   │   └── message.dart                    # Message data model
├── webpage/                                # Angular dashboard
│   ├── tailwind.config.js                  # Tailwind CSS configuration
│   └── src/
│       ├── app/
│       │   ├── index.html                  # Main HTML file, has logic for theme change
│       │   ├── app.html                    # Contains routing
│       │   ├── app.routes.ts               # Angular routing configuration
│       │   ├── app.ts                      # Main app component, handles theme changes and loading state
│       │   ├── header/                     # Header component with theme toggle
│       │   │   ├── header.ts               # Header component logic
│       │   │   └── header.html             # Header component template
│       │   ├── ticket-viewer/              # Ticket viewer component
│       │   │   ├── ticket-viewer.ts        # Ticket viewer logic
│       │   │   └── ticket-viewer.html      # Ticket viewer template
│       │   ├── knowledge-editor/           # Knowledgebase editor component
│       │   │   ├── knowledge-editor.ts     # Knowledgebase editor logic
│       │   │   └── knowledge-editor.html   # Knowledgebase editor template
│       │   └── live-logs/.                 # Live logs component
│       │       ├── live-logs.ts            # Live logs logic
│       │       └── live-logs.html          # Live logs template
├── README.md                               # Project documentation
```


## Assumptions about this project
- I have assumed that you will be testing it on a simulator. It is currently set to localhost:4200 (for running on an iOS simulator), but I've added extra instructions for other device types in webview_screen.dart



## Stretch Goals Completed
- The app has a dark mode that applies to both the Flutter app and the Angular web server.
- Messages are persistant (via SharedPreferences).
- The text message input is emoji compatable.
