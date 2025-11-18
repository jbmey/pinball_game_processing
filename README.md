# Moebius Pinball Game

A physics-based pinball game built with Processing 4, featuring a Moebius-themed design with realistic ball physics and audio effects.

## Requirements

- **Processing 4** - This game requires Processing 4 to run
- **Fisica Library** - Physics simulation library for Processing
- **Minim Library** - Audio processing library for Processing

## Installation

1. Download and install [Processing 4](https://processing.org/download)
2. Install the required libraries through Processing's Library Manager:
   - Go to `Tools > Manage Tools > Libraries`
   - Search for and install:
     - **Fisica** (physics engine)
     - **Minim** (audio library)
3. Download or clone this repository
4. Open `pinballLauncher.pde` in Processing 4

## How to Play

### Game Controls

- **Space Bar** - Insert coin and start the game
- **Left Arrow** - Control left flipper
- **Right Arrow** - Control right flipper
- **Down Arrow** - Charge the ball launcher (hold and release)
- **Q Key** - Slam left (shake the pinball table left)
- **E Key** - Slam right (shake the pinball table right)
- **R Key** - Restart game

### Game Features

#### Scoring Elements
- **Targets** - Hit the three large colored circles at the top for points
  - Side targets: 100 points each
  - Center target: 1000 points
- **Moving Ship** - Hit the moving spaceship platform for 2000 points
- **Bumpers** - Triangular bumpers above flippers give impulse

#### Special Features
- **Bonus Ball** - Reach score thresholds to unlock a second ball
- **Extra Lives** - Gain extra lives by reaching score milestones
- **Flash Mode** - Targets flash different colors when bonus thresholds are reached
- **Tilt Protection** - Excessive slamming will temporarily disable controls

#### Audio System
The game features multiple audio approaches for educational purposes:
- **Sampled Audio** - Pre-recorded sound effects for flippers, bumpers, and launcher
- **Procedural Audio** - Real-time generated music themes
- **Physics Audio** - Ball collision sounds generated through audio synthesis

### Game Mechanics

#### Ball Physics
- Realistic physics simulation using the Fisica library
- Ball bouncing with proper restitution and momentum
- Gravity and impulse effects

#### Flipper System
- Motor-driven flippers with realistic movement limits
- Force feedback and proper physics integration
- Audio feedback for activation and release

#### Launch System
- Spring-loaded ball launcher with variable force
- Mouse-draggable for testing (when `setGrabbable(true)`)
- Flap mechanism to contain balls in launch area

## File Structure

- `pinballLauncher.pde` - Main game file with core logic
- `Ball.pde` - Ball physics and collision detection
- `Flipper.pde` - Flipper mechanics and controls
- `Frame.pde` - Game boundaries and structural elements
- `Target.pde` - Scoring targets with color effects
- `Player.pde` - Player stats (score, lives, thresholds)
- `Bumper.pde` - Bumper physics and impulse effects
- `MovingPlatform.pde` - Animated ship platform
- `Planet.pde` - Rotating planetary obstacles
- `Starter.pde` - Ball launcher mechanism
- `Music.pde` - Procedural music generation
- `SoundEffect.pde` - Real-time audio synthesis
- `data/` - Audio files and images

## Game States

1. **Start Screen** - Press Space to insert coin and begin
2. **Gameplay** - Active pinball simulation with all controls
3. **Game Over** - Final score display, press R to restart

## Educational Features

This project was made to learn various programming and game development concepts:
- Object-oriented design with multiple interacting classes
- Physics simulation and real-time collision detection
- Multiple audio processing techniques
- State management and game flow control
- Image loading and sprite attachment
- Real-time animation and visual effects

## Troubleshooting

**Game won't start:**
- Ensure Processing 4 is installed (not Processing 3.x)
- Verify Fisica and Minim libraries are installed
- Check that all image and audio files are in the `data/` folder

**No audio:**
- Verify Minim library is properly installed
- Check that audio files exist in the `data/` folder
- Ensure system audio is not muted

**Performance issues:**
- The game is optimized for 650x1000 resolution
- Reduce visual effects if experiencing lag
- Ensure adequate system resources

## Credits

Created as an educational project exploring physics simulation, audio processing, and game development in Processing. Features Moebius-inspired artwork and procedural audio generation.

## License

This project is for educational purposes. Please respect any third-party assets used in the `data/` folder.
