# 🐤 Flutter Jump Game

A fun, animated tap-to-jump game built using Flutter and GetX. Control a cute chick and jump over obstacles to score points. Simple mechanics, clean code, and engaging visuals make this game a great Flutter showcase project.

---

## 🎮 Gameplay

- Tap the screen to make the chick jump  
- Avoid hitting obstacles (red bars)  
- Game ends on collision  
- Score increases as you survive longer  
- Tap to restart after game over  

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.6.6

flutter:
  assets:
    - assets/images/chick.png
    - assets/images/sky.jpg
    - assets/images/ground.jpg
```

🛠 Setup Instructions

Clone the repo
git clone https://github.com/SuqenaSheikh/jumpingchick
cd flutter-jump-game
Get dependencies
flutter pub get
Add assets
Place the following images in assets/images/:
chick.png
sky.jpg
ground.jpg

Run the app
flutter run

📚 Concepts Used

Custom game loop with Timer
Parabolic jump physics
Collision detection
State management with GetX
Responsive layout with MediaQuery

💡 Ideas for Extension

Add sound effects for jumping and game over
Add animated obstacles
Introduce power-ups and difficulty levels
Add leaderboard or high score saving

📄 License

MIT License © 2025 Tayyaba Shahid

🙌 Credits

Chick, background, and ground images from open-source/free asset providers.



