# DRAGONBOUND VERSION 0.2

print('Welcome to Dragonbound!')


def character_name():
    char_name = input('Enter your name: ')
    return char_name


def character_class():
    while True:
        print('Choose your Class!')
        print('1. Warrior')
        print('2. Mage')
        print('3. Rogue')

        try:
            choice = int(input(''))

            if choice == 1:
                return 'Warrior'
            elif choice == 2:
                return 'Mage'
            elif choice == 3:
                return 'Rogue'
            else:
                print('Invalid Choice! Please choose between 1, 2, 3!')

        except ValueError:
            print('Please enter a number!')


def character_stats(name, char_class):

    if char_class == 'Warrior':
        weapon = 'Iron Sword'
        hp = 150
        mana = 50
        gold = 100

    elif char_class == 'Mage':
        weapon = 'Battle Staff'
        hp = 100
        mana = 100
        gold = 100

    elif char_class == 'Rogue':
        weapon = 'Iron Daggers'
        hp = 100
        mana = 70
        gold = 100

    stats = {
        'name': name,
        'class': char_class,
        'weapon': weapon,
        'level': 1,
        'hp': hp,
        'max_hp': hp,
        'mana': mana,
        'gold': gold,
        'inventory': [
            weapon,
        ],
    }

    return stats


def show_character(stats):
    print('Name:', stats["name"])
    print('Class:', stats["class"])
    print('Level:', stats["level"])
    print('Weapon:', stats["weapon"])
    print('Inventory:', stats["inventory"])
    print('Gold:', stats["gold"])
    print('HP:', stats["hp"])
    print('Mana:', stats["mana"])


def goblin_stats():
    stats = {
        'name': 'Goblin',
        'class': 'Monster',
        'weapon': 'Claws',
        'level': 1,
        'hp': 20,
        'mana': 0,
        'gold': 10,
        'inventory': [],
    }

    return stats


def battle(player_stats, goblin):
    print('A wild Goblin Appears!')

    while goblin['hp'] > 0:
        print('1. Attack')
        print('2. Spells')

        try:
            battle_choice = int(input('1. Attack, 2. Spells: '))

            if battle_choice == 1:
                goblin['hp'] -= 10
                print(
                    'You attacked the Goblin!',
                    "Goblin's HP:",
                    goblin['hp']
                )

            elif battle_choice == 2:
                goblin['hp'] -= 15
                print(
                    'You cast a spell!',
                    "Goblin's HP:",
                    goblin['hp']
                )

            else:
                print('Invalid Choice!')

        except ValueError:
            print('Please Enter A Number!')

    print('Goblin has been defeated!')

    player_stats["gold"] += goblin["gold"]

    print(
        f'Received {goblin["gold"]} gold!',
        f'You now have {player_stats["gold"]} gold!'
    )


def shop(player_stats):
    while True:
        print('Welcome to the shop! Buy your wares!')
        print('1. Health Potion - 10 Gold')
        print('2. Mana Potion - 10 Gold')   

        choice = input('Choose an item to buy or type "exit" to leave: ')

        if choice == '1':
            if player_stats["gold"] < 10:
                print('Not enough gold!')
                continue
            print('You bought a Health Potion!')
            print(f'You now have {player_stats["gold"]} gold.')
            player_stats["inventory"].append("Health Potion")
            player_stats["gold"] -= 10

        elif choice == '2':
            if player_stats["gold"] < 10:
                print('Not enough gold!')
                continue
            print('You bought a Mana Potion!')
            print(f'You now have {player_stats["gold"]} gold.')
            player_stats["inventory"].append("Mana Potion")
            player_stats["gold"] -= 10
        
        elif choice.lower() == 'exit':
            print('Leaving the shop...')
            break

# IN DEVELOPMENT
def inn(player_stats):
    print('You rest at the inn.')
    player_stats["hp"] = player_stats["max_hp"]
    print(f'Your HP is now restored to {player_stats["hp"]}.')
    input('Press Enter to return to Honeywood...')
  
def honeywood(player_stats):
    while True:
        print("\nYou arrive at Honeywood.")
        print("=== Honeywood ===")
        print("1. Shop")
        print("2. Inn")
        print("3. View Character")
        print("4. Explore Forest")
        print("5. Quit")

        try:
            choice = int(input('Choose an option: '))

            if choice == 1:
                shop(player_stats)

            elif choice == 2:
                print('You rest at the inn.')
                input('Press Enter to return to Honeywood...')

            elif choice == 3:
                show_character(player_stats)
                input('Press Enter to return to Honeywood...')

            elif choice == 4:
                print('You head into the forest.')
                input('Press Enter to return to Honeywood...')

            elif choice == 5:
                print('Thanks for playing Dragonbound!')
                break

            else:
                print('Invalid Choice!')

        except ValueError:
            print('Please enter a number!')




# GAME START

player_name = character_name()
player_class = character_class()

player_stats = character_stats(
    player_name,
    player_class
)

goblin = goblin_stats()

player_stats["inventory"].append("Health Potion")

print(
    f'Welcome! {player_name} the {player_class}!'
    ' Your adventure begins..'
)

show_character(player_stats)

battle(player_stats, goblin)

honeywood(player_stats)