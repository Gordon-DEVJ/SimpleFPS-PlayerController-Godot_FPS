# Half_Life-PlayerController Godot Engine
PlayerController inspired by Half Life movement for Godot Engine
This is a 3D movement system for Godot Engine inspired by the movement mechanics found in the Half-Life games developed by Valve.

## Features

- Smooth player and camera rotation using Euler angles.
- Adjustable movement speed, walk speed, and jump velocity.
- Implementation of basic walking and double jump mechanics.
- Mouse input for intuitive camera control.
- Linear interpolation for smooth transitions during movement.

## How to Use

1. Attach the script `player_movement.gd` and the scene `PlayerController.tscn` to your project in Godot Engine.
2. Customize movement parameters and options through exported variables.
3. Run the project to see the movement in action.

## Customization

You can customize the movement behavior by adjusting the exported variables in the `player_movement.gd` script. Experiment with values like `BASE_SPEED`, `WALK_SPEED`, and `JUMP_VELOCITY` to achieve the desired gameplay experience.

## Controls

- **W, A, S, D:** Movement
- **Space:** Jump
- **Shift:** Walk mode (slower movement)

## Credits

- Developed by [Gordon-DevJ](https://github.com/Gordon-DevJ).
- Inspiration and contributions from [StayAtHomeDev](https://github.com/StayAtHomeDev-Git) and [Lucky-nl](https://github.com/lukky-nl).

## Versions

1.0.0        Walk, Jump, Camera controls 

1.0.1        Improvements in the environment

## License Agreement

Copyright (c) 2023 Gordon-DEVJ

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
