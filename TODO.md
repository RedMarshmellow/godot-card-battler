# TODO

## Code Cleanup

- [ ] Add blank lines between functions in all scripts (GDScript convention)
- [ ] Rename `CustomDeckManager` autoload back to `DeckManager` (and update all references)
- [ ] Add methods to `enemy.gd` for status effects instead of writing fields from outside:
  - `apply_vulnerable(n)`, `tick_statuses()`, `get_hp()` 
- [ ] Replace direct `$Enemy.hp` reads with a getter method
- [ ] Use `TurnState.VICTORY` / `DEFEAT` in `end_battle()` instead of `ENEMY_TURN`
- [ ] Rename `block.tres` to `defend.tres` to match card name
- [ ] Use `_ready()` instead of `_init()` in `deck_manager.gd`

## Game Features

- [ ] Cards that apply strength/vulnerable to the player (self-debuff, self-buff)
- [ ] Enemy strength gain (some enemies should scale)
- [ ] Energy display updates when energy changes (already done?)
- [ ] More cards (AoE, heal, draw, high-cost finisher)
- [ ] More enemies with different behaviors (debuff, scale, summon)
- [ ] Map / level progression between fights
- [ ] Save/Load system
- [ ] Sound effects & music

## Content

- [ ] Add more card resource files (aim for 8-10 total)
- [ ] Add 3-5 enemy types
- [ ] Balance tuning (damage values, enemy HP, energy costs)

## Polish

- [ ] Card hover effects (scale up, glow)
- [ ] Card drag/drop or click-to-play with visual feedback
- [ ] Animations (card slide in, damage numbers, enemy hit flash)
- [ ] Death/victory screen instead of immediate scene switch
- [ ] Music and SFX
