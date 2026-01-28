#!/bin/bash

# colors
RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
YELLOW="\e[33m"
RESET="\e[0m"

wins=0
playthrough=0
player_name=""

# ask player name
greet_user(){
    read -p "Whats your name? " player_name
    if [ "$player_name" == "" ]; then
        player_name="Player"
    fi
    clear
}

# play again function
play_again(){
    read -p "Play again? (y/n): " again
    if [ "$again" == "y" ] || [ "$again" == "Y" ]; then
        main_menu
    elif [ "$again" == "n" ] || [ "$again" == "N" ]; then
        echo -e "${GREEN}Thanks For Playing $player_name${RESET}"
        exit
    else
        echo -e "${RED}Invalid Input!${RESET}"
        main_menu
    fi
}

# main menu
main_menu(){
    clear
    if [ "$player_name" == "" ]; then
        greet_user
    fi

    echo
    echo -e "${CYAN}=== NUMBER GUESSING GAME FOR ${GREEN}$player_name${CYAN} ===${RESET}"
    echo "Wins: $wins"
    echo -e "${YELLOW}1) Classic Game${RESET}"
    echo -e "${YELLOW}2) Custom Game${RESET}"
    echo -e "${YELLOW}3) Exit${RESET}"
    echo

    read -p "Choose an option: " choice

    case $choice in
        1|Classic|classic|"Classic game"|"Classic Game"|"classic game") classic_menu ;;
        2|Custom|custom|"Custom game"|"Custom Game"|"custom game") custom_game ;;
        3|Exit|exit)
            echo -e "${GREEN}Thanks for playing!${RESET}"
            exit
            ;;
        *)
            echo -e "${RED}Invalid choice.${RESET}"
            main_menu
            ;;
    esac
}

# classic menu
classic_menu(){
    echo
    read -p "Choose difficulty (Easy, Medium, Hard or Back): " difficulty

    case $difficulty in
        easy|Easy) play_game 10 6 ;;
        medium|Medium) play_game 50 10 ;;
        hard|Hard) play_game 100 10 ;;
        back|Back) main_menu ;;
        *)
            echo -e "${RED}Invalid difficulty.${RESET}"
            classic_menu
            ;;
    esac
}

# unified game function (simple)
play_game(){
    max_num=$1
    attempts=$2
    prev_guess=""
    feedback=""
    comp_num=$((RANDOM % max_num + 1))

    while [ $attempts -gt 0 ]; do
        clear

        # show previous guess if exists
        if [ "$prev_guess" != "" ]; then
            echo -e "${MAGENTA}Previous guess: $prev_guess${RESET}"
        fi

        # show feedback if exists
        if [ "$feedback" != "" ]; then
            echo -e "$feedback"
        fi

        echo "Attempts left: $attempts"
        read -p "Your guess (1–$max_num): " user_num

        # check number
        if ! [[ "$user_num" =~ ^[0-9]+$ ]]; then
            feedback="${RED}Numbers only!${RESET}"
            continue
        fi

        prev_guess=$user_num

        if [ $user_num -lt $comp_num ]; then
            feedback="${BLUE}Too Low${RESET}"
        elif [ $user_num -gt $comp_num ]; then
            feedback="${RED}Too High${RESET}"
        else
            feedback="${GREEN}You got it!${RESET}"
            ((wins++))
            ((playthrough++))
            clear
            echo -e "$feedback"
            play_again
            return
        fi

        ((attempts--))
    done

    clear
    echo "Out of guesses. Number was $comp_num."
    play_again
}

# custom game
custom_game(){
    read -p "Max number: " max_num
    read -p "Attempts: " attempts

    # simple check
    if ! [[ "$max_num" =~ ^[0-9]+$ ]] || ! [[ "$attempts" =~ ^[0-9]+$ ]]; then
        echo "Numbers only."
        main_menu
        return
    fi

    play_game "$max_num" "$attempts"
}

# start
main_menu
