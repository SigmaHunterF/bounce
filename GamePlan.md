# Bounce — Game Plan: Road to Publishing

Your game already has a solid foundation: a top-down shooter with wave-based slime enemies, bouncing bullets, and a health system. This plan takes it from "cool prototype" to "shareable game" in 5 phases. Work through them in order — each phase builds on the last.

---

## Story & Theme

> Every great game has a reason to exist. This is yours.

### The Story

The slimes came from the ocean.

Nobody knows why they surfaced, but they did — first crawling out of the sea, then spreading across the land. You are **The Bouncer**: a lone defender with the only weapon that works against them. Normal bullets just get absorbed by slime armor. But your ricochet cannon fires energy orbs that bounce off walls and pierce right through — one shot can chain across a whole room if you angle it right.

You can't stop them forever. You can only hold the line as long as possible.

**Land Mode** = the slimes are invading your turf. Hold them back.
**Ocean Mode** = you dive into the source — underwater, into the heart of the swarm.

### The Theme

**Vibe:** Arcade fun. Saturday-morning-cartoon energy. The slimes are goofy, not scary — but there are SO MANY of them.

**Tone:** Fast, exciting, and fair. Players should feel clever when they bounce a shot into three enemies, and feel like it was their fault (not bad luck) when they take damage.

**Color palette:**
- Land: bright greens and warm yellows — lively, energetic
- Ocean: deep blues and teals with glowing purples — mysterious and beautiful

**Tagline:** *"Every shot counts. Every wall helps."*

### Your Design Rules (refer back to these while building)

1. **The bounce is the star.** Every mechanic should make the bouncing bullet feel more satisfying, not distract from it.
2. **No waiting.** Players should always have something to dodge, aim at, or react to.
3. **Readable at a glance.** A new player should understand what's happening on screen within 5 seconds — clear player, clear enemies, clear bullets.
4. **Reward skill, don't punish bad luck.** Enemy spawns should always give the player room to react. Damage should always be avoidable.

---

## Phase 1: Polish the Core Game

> Before adding new stuff, make the existing game feel complete and professional.

- [ ] **Main Menu** — Create a new scene (`Nodes/main_menu.tscn`) with the game title, a **Play** button, and a **Quit** button. Set it as the starting scene in `project.godot` (Project > Project Settings > Application > Run > Main Scene).
- [ ] **Game Over Screen** — Right now the game just reloads. Instead, show a "Game Over" screen with:
  - Your final wave number
  - A **Play Again** button
  - A **Main Menu** button
  - (Bonus) A score = wave number × total kills
- [ ] **High Score Saving** — Use Godot's `FileAccess` to save your best score to `user://highscore.save`. Display it on the Game Over screen so players can try to beat it.
- [ ] **Fix Enemy Spawning** — Enemies currently spawn at random positions that can overlap the player. Change `game.gd` to spawn enemies only at the *edges* of the arena so they always walk toward you from the outside.
- [ ] **Check Bullet Collision** — Open `Bullet.tscn` in the Godot editor and make sure the collision layer/mask settings match the slime's layer. This ensures bullets reliably hit enemies.

**Files to work on:** `Scripts/game.gd`, new `Scripts/main_menu.gd`, new `Scripts/game_over.gd`

---

## Phase 2: Game Feel & Controls

> A game that *feels* good to play keeps people coming back. These changes make the controls intuitive and every action satisfying — no tedious grinding.

### Controls to Add

- [ ] **Invincibility Frames after damage** — Right now you can lose all 3 hearts in a fraction of a second if enemies cluster on you. Add 1 second of invulnerability after taking a hit. The player should flash (toggle `visible` on/off rapidly with a timer). This is standard in every good action game and makes damage feel *fair*.

  In `Scripts/player.gd`: add a `var invincible: bool = false` flag and a Timer node. When `damage()` is called, set `invincible = true`, start the timer, and in `_on_timer_timeout()` set it back to `false`. Skip the damage if `invincible` is true.

- [ ] **Dash ability** — Press **Shift** to dash a short burst in your current movement direction. Brief invulnerability during the dash. 1.5-second cooldown shown as a small bar under the player. This is the single biggest upgrade to how the game *feels* — it lets players dodge skill fully and rewards good timing.

  In `Scripts/player.gd`: on Shift press, multiply velocity by 4 for 0.15 seconds using a short Timer, then return to normal speed. Block re-use until cooldown timer expires.

- [ ] **Reload indicator** — The current 0.1s shoot cooldown is invisible, which makes the shooting feel random or "laggy." Add a small arc or bar under the player that fills up after each shot. Now players can clearly see their rhythm and plan their shots.

- [ ] **Wave break countdown** — Between waves, pause enemy spawning for 3 seconds and show a countdown: *"Wave 3 incoming… 3… 2… 1… GO!"* This gives players a breath of relief, builds anticipation, and stops the game from feeling like an endless grind with no rhythm.

  In `Scripts/game.gd`: after every 10th kill triggers a wave change, pause spawning and run a 3-second timer before re-enabling it.

### Feedback & Juice

These are small touches that make every action feel satisfying:

- [ ] **Screen shake on damage** — When the player takes a hit, shake the camera for 0.2 seconds. Godot makes this easy: offset the camera position by a small random vector repeatedly, then reset. Makes damage feel impactful without being annoying.
- [ ] **Slime death splat** — When a slime dies, spawn a small burst of green particles (`GPUParticles2D`) at its position before it disappears. A satisfying "pop" to go with the death animation.
- [ ] **Bounce combo counter** — When a single bullet kills 2+ enemies via bounces, flash a "*×2 BOUNCE!*" label on screen for 1 second. No gameplay effect — pure fun. This rewards creative angling and makes the bouncing feel intentional, not accidental.

### Enemy Drops (breaks up monotony)

When enemies die, give them a small chance to drop a powerup. Players will naturally gravitate toward the enemies, which keeps the arena exciting and prevents players from just camping in a corner.

| Drop | Chance | Effect | Duration |
|------|--------|--------|----------|
| Heart | 20% from Big Slime only | Restore 1 heart | Instant |
| Speed Boost | 15% | Movement speed +50% | 5 seconds |
| Rapid Fire | 10% | No shoot cooldown | 3 seconds |

Create `Nodes/pickup.tscn` with a script that checks which type it is and applies the effect when the player walks over it. Auto-despawn after 6 seconds if uncollected.

**Files to work on:** `Scripts/player.gd`, `Scripts/game.gd`, `Scripts/slime.gd`, new `Nodes/pickup.tscn`, new `Scripts/pickup.gd`

---

## Phase 3: New Enemies

> One enemy type gets boring fast. Let's mix it up!

Each enemy follows the same recipe as your existing slime: one `.tscn` scene file and one `.gd` script. After building each one, update `game.gd` to start spawning them in the right waves.

### Enemy 1: Fast Slime
**File:** `Nodes/fast_slime.tscn` + `Scripts/fast_slime.gd`

| Stat | Value |
|------|-------|
| Speed | 120 |
| Health | 1 HP (one shot kill) |
| Look | Red-tinted slime sprite (`modulate = Color(1, 0.3, 0.3)`) |
| Spawns | Wave 3+ |

Small, quick, and scary in groups. A speed demon that punishes players who stand still.

---

### Enemy 2: Big Slime
**File:** `Nodes/big_slime.tscn` + `Scripts/big_slime.gd`

| Stat | Value |
|------|-------|
| Speed | 25 (slow!) |
| Health | 6 HP |
| Look | Normal slime at 1.5× scale |
| Wave bar | Counts as 3 kills when it dies |
| Spawns | Wave 2+ |

A tank. Takes a lot of bullets to kill but moves slowly. Forces you to prioritize targets. High chance to drop a Heart when it dies.

---

### Enemy 3: Shooter Slime
**File:** `Nodes/shooter_slime.tscn` + `Scripts/shooter_slime.gd`

| Stat | Value |
|------|-------|
| Speed | 40 (walks toward you, stops at ~150px away) |
| Health | 2 HP |
| Attack | Fires a projectile at the player every 2 seconds |
| Spawns | Wave 5+ |

Keeps its distance and shoots at you. Makes the arena feel dangerous even from far away. Reuse `Bullet.tscn` for its projectile — just make a copy called `EnemyBullet.tscn` with a different color so it damages the player instead of slimes.

---

**To wire them all up in `game.gd`:** Replace the single slime spawn with a function that picks a random enemy type based on `wave_number`. Example logic:
```
Wave 1-2:  only slimes
Wave 2+:   add big slimes (rare)
Wave 3+:   add fast slimes
Wave 5+:   add shooter slimes
```

---

## Phase 4: Underwater Mode

> An alternate game mode — same arena, totally different vibe. This is where the story goes deeper (literally).

Add "Ocean Mode" to the main menu alongside the normal "Land Mode." The core game loop stays the same, but the look and feel are completely different.

### Visuals
- Deep blue color tint: change `CanvasModulate` to `Color(0.1, 0.3, 0.7, 1)`
- Add slowly drifting bubbles using a `GPUParticles2D` node (built into Godot)
- Optional: swap the arena tileset for ocean floor tiles

### Gameplay Tweaks
- **Player speed:** Reduce to 70 (swimming is slower than running)
- **Air Meter:** A new UI bar that slowly drains over time. Collect air bubbles to refill it. If it hits zero, you lose a heart. Create `Nodes/air_bubble.tscn` — a collectible that spawns every 15 seconds at random positions.

### Underwater Enemies

| Enemy | File | How it Moves |
|-------|------|--------------|
| Jellyfish | `Nodes/jellyfish.tscn` | Drifts slowly in a wavy pattern, damages on contact |
| Pufferfish | `Nodes/pufferfish.tscn` | Grows bigger when you get close, then deflates and dashes |
| Crab | `Nodes/crab.tscn` | Only moves sideways (left/right), 4 HP, hard to dodge |

### How to Switch Modes
Create a **GameState autoload** (`Scripts/game_state.gd`) that holds the current mode:

```gdscript
# Scripts/game_state.gd
extends Node

var underwater_mode: bool = false
var high_score: int = 0
```

Register it in **Project > Project Settings > Autoload** as `GameState`.

The main menu sets `GameState.underwater_mode = true/false` before loading the game scene. Then `game.gd` checks that variable on startup to decide which enemies to spawn and which visuals to activate.

---

## Phase 5: Export and Publish

> The finish line! Get the game on a website.

### Step 1 — Export to Web (HTML5)
1. In Godot, go to **Project > Export**
2. Click **Add** and choose **Web**
3. If it asks you to download export templates — do it!
4. Create a folder called `web_export/` in your project
5. Export there. Godot creates an `index.html` plus a few other files.

### Step 2 — Test It Locally
Before handing it off, make sure it works in a browser:
```
# In your web_export/ folder:
python -m http.server 8000
# Then open http://localhost:8000 in Chrome
```

### Step 3 — Share With Mom
Give Mom the entire `web_export/` folder. She uploads those files to the website. The main file is `index.html` — that's what visitors load.

### Shortcut: Itch.io
If you want to share with friends *before* the website is ready, upload to [itch.io](https://itch.io) for free:
1. Create a free account
2. Create a new project, set it to "HTML"
3. Zip up `web_export/` and upload the zip
4. Publish — you get a link you can send to anyone, right now

---

## Quick Reference: New Files to Create

```
bounce/
├── Nodes/
│   ├── main_menu.tscn        (Phase 1)
│   ├── game_over.tscn        (Phase 1)
│   ├── pickup.tscn           (Phase 2)
│   ├── fast_slime.tscn       (Phase 3)
│   ├── big_slime.tscn        (Phase 3)
│   ├── shooter_slime.tscn    (Phase 3)
│   ├── enemy_bullet.tscn     (Phase 3)
│   ├── jellyfish.tscn        (Phase 4)
│   ├── pufferfish.tscn       (Phase 4)
│   ├── crab.tscn             (Phase 4)
│   └── air_bubble.tscn       (Phase 4)
├── Scripts/
│   ├── main_menu.gd          (Phase 1)
│   ├── game_over.gd          (Phase 1)
│   ├── pickup.gd             (Phase 2)
│   ├── game_state.gd         (Phase 4 — autoload)
│   ├── fast_slime.gd         (Phase 3)
│   ├── big_slime.gd          (Phase 3)
│   ├── shooter_slime.gd      (Phase 3)
│   ├── jellyfish.gd          (Phase 4)
│   ├── pufferfish.gd         (Phase 4)
│   └── crab.gd               (Phase 4)
└── web_export/               (Phase 5)
```

**Existing files to modify:**
- `Scripts/player.gd` — invincibility frames, dash, reload indicator (Phase 2)
- `Scripts/game.gd` — wave breaks, multi-enemy spawning, mode switching (Phases 1, 2, 3, 4)
- `Scripts/slime.gd` — drop pickup on death (Phase 2)

---

## You've Got This

You already built the hardest part — a working game with enemies, health, and waves. The story gives everything a reason to exist, the game feel improvements make it *fun* to play, and the new content gives players a reason to keep coming back. Take it one checkbox at a time, and by Phase 5 you'll have a real game your friends can play from anywhere.
