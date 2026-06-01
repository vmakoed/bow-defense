CHECK WITH GRILL ME?

Level Scene:
- level.gd script: base logic connecting to LevelManager (level won, lost, etc.)
- child: BaseLevel: 
    - everything common in the game: player, bow, etc.
    - level_config var: array of enemies to spawn
- child (optional): LevelController
    - custom logic for this level only (example: boss level)


Creating new level:
- Instantiate BaseLevel child
- Set level_config var

Logic in base_level.gd:
- when it is time to spawn next enemy: 
    - pop from the level_config
    - decide which spawn strategy to use (attribute of EnemyStats)
    - decide which enemy class to use (attribute of EnemyStats)
    - if no enemies left, level won
- when to spawn?
    - timer
    - on timeout: spawn unless max enemy on screen limit reached
    - on enemy death: if timeout stopped, spawn next enemy and start timeout
- spawn strategies:
    - base
    - shielder: 
        - look for another enemy (with most health) OR spawn extra enemmy
            - easier to implement architecturally
            - disconnect: more enemies on screen than max variable - maybe okay?
            - rename variable to max_primary_enemies?
        - make shield connection
        - if no enemies: mvp - do nothing, later: connect on spawn
    - boss:
        - can request to spawn an enemy


REUSE SHIELDS FOR BOSS!!!

boss spawns enemies - they shield him
need to kill shielders before hurting boss
shielders don't move, only thing that hurts player is projectiles
maybe throw in plain squares in the mix

base enemy class that both Enemy and Boss extend (maybe ShieldPair too?), use it for static typing in level contents and spawner
