# Kenney Sprites Directory

This directory contains PNG sprite assets from **Kenney asset packs** for students to use in their game development projects.

## Purpose

- Students can browse these sprites using the **Sprite Gallery** button in the navigation bar
- Sprite filenames are shown in the gallery for easy reference in code
- Students can rotate sprites 90° clockwise/counterclockwise before downloading
- Downloaded sprites can be uploaded to their microStudio projects

## Required Sprites

Add PNG files from Kenney asset packs to this directory. The sprite gallery expects the following filenames (update `sprite-gallery.js` if using different names):

### Enemy Ships
- `enemy_ship_1.png`
- `enemy_ship_2.png`
- `enemy_ship_3.png`
- `enemy_ship_4.png`
- `enemy_ship_5.png`

### Aliens
- `alien_1.png`
- `alien_2.png`
- `alien_3.png`
- `alien_4.png`
- `alien_5.png`

### Asteroids
- `asteroid_1.png`
- `asteroid_2.png`
- `asteroid_3.png`

### UFOs
- `ufo_1.png`
- `ufo_2.png`
- `ufo_3.png`

## How to Update Sprite List

To add or remove sprites from the gallery, edit the `SPRITES` array in `sprite-gallery.js`:

```javascript
const SPRITES = [
    'enemy_ship_1.png',
    'enemy_ship_2.png',
    // Add more filenames here...
];
```

## Kenney Asset Pack Sources

Recommended packs:
- **Space Shooter Redux** - https://www.kenney.nl/assets/space-shooter-redux
- **Platformer Pack Redux** - https://www.kenney.nl/assets/platformer-pack-redux
- **Game Icons** - https://www.kenney.nl/assets/game-icons

All Kenney assets are CC0 licensed (public domain).

## Image Requirements

- Format: PNG with transparency
- Recommended size: 32x32 to 128x128 pixels
- Sprites should be pixel art style to match microStudio aesthetics
- Filenames should be descriptive and use underscores (no spaces)

## Testing

After adding sprites, test the gallery:
1. Open `index.html` in a browser
2. Click "🎨 Sprite Gallery" button
3. Verify all sprites appear in the grid with correct filenames
4. Test rotation controls
5. Test download functionality
