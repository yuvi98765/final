#!/bin/bash

# colors to make the game look nicer
RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
YELLOW="\e[33m"
RESET="\e[0m"

# keeps track of how many times the user wins
wins=0

# main menu where the user chooses what game mode to play
main_menu(){
    read -p "Whats your name? " player_name
    if [ -z "$player_name" ]; then
        player_name="Player"
    fi
   
    echo
    echo -e "${CYAN}=== NUMBER GUESSING GAME FOR ${GREEN}$player_name${CYAN} ===${RESET}"
    echo "Wins: $wins"
    echo -e "${YELLOW}1) Classic Game${RESET}"
    echo -e "${YELLOW}2) Custom Game${RESET}"
    echo -e "${YELLOW}3) Exit${RESET}"
    echo

    read -p "Choose an option: " choice

    case "$choice" in
        1|Classic|classic|Classic game|Classic Game|classic game) classic_menu ;;
        2|Custom|custom|Custom game|Custom Game|custom game) custom_game ;;
        3)
            echo -e "${GREEN}Thanks for playing!${RESET}"
            exit
            ;;
        *)
            echo -e "${RED}Invalid choice.${RESET}"
            main_menu
            ;;
    esac
}

# menu for classic difficulty selection
classic_menu(){
    echo
    read -p "Choose difficulty (Easy, Medium, Hard or Back): " difficulty

    case $difficulty in
        easy|Easy) easy ;;
        medium|Medium) medium ;;
        hard|Hard) hard ;;
        back|Back) main_menu ;;
        *)
            echo -e "${RED}Invalid difficulty.${RESET}"
            classic_menu
            ;;
    esac
}

# easy mode guessing game
easy(){
    attempts=6
    comp_num=$((RANDOM % 10 + 1))
    prev_guess=""

    while [[ $attempts -gt 0 ]]; do
        if [[ -n "$prev_guess" ]]; then
            echo -e "${MAGENTA}Previous guess: $prev_guess${RESET}"
        fi
        read -p "Guess (1–10): " user_num

        if [[ ! "$user_num" =~ ^[0-9]+$ ]]; then
            echo "Numbers only!"
            continue
        fi

        prev_guess=$user_num

        if [[ $user_num -lt $comp_num ]]; then
            echo -e "${BLUE}Too Low${RESET}"
        elif [[ $user_num -gt $comp_num ]]; then
            echo -e "${RED}Too High${RESET}"
        else
            echo -e "${GREEN}You got it!${RESET}"
            ((wins++))
            read -p "Play again? (y/n): " again
            if [[ $again == "y" || $again == "Y" ]]; then
                main_menu
            else
                echo -e "${GREEN}Thanks for playing!${RESET}"
                exit
            fi
            return
        fi

        ((attempts--))
        echo "Attempts left: $attempts"
    done

    echo "Out of guesses. Number was $comp_num."
    classic_menu
}

# medium mode guessing game
medium(){
    attempts=10
    comp_num=$((RANDOM % 50 + 1))
    prev_guess=""

    while [[ $attempts -gt 0 ]]; do
        if [[ -n "$prev_guess" ]]; then
            echo -e "${MAGENTA}Previous guess: $prev_guess${RESET}"
        fi
        read -p "Guess (1–50): " user_num

        if [[ ! "$user_num" =~ ^[0-9]+$ ]]; then
            echo "Numbers only!"
            continue
        fi

        prev_guess=$user_num

        if [[ $user_num -lt $comp_num ]]; then
            echo -e "${BLUE}Too Low${RESET}"
        elif [[ $user_num -gt $comp_num ]]; then
            echo -e "${RED}Too High${RESET}"
        else
            echo -e "${GREEN}You got it!${RESET}"
            ((wins++))
            read -p "Play again? (y/n): " again
            if [[ $again == "y" || $again == "Y" ]]; then
                main_menu
            else
                echo -e "${GREEN}Thanks for playing!${RESET}"
                exit
            fi
            return
        fi

        ((attempts--))
        echo "Attempts left: $attempts"
    done

    echo "Out of guesses. Number was $comp_num."
    classic_menu
}

# hard mode guessing game
hard(){
    attempts=10
    comp_num=$((RANDOM % 100 + 1))
    prev_guess=""

    while [[ $attempts -gt 0 ]]; do
        if [[ -n "$prev_guess" ]]; then
            echo -e "${MAGENTA}Previous guess: $prev_guess${RESET}"
        fi
        read -p "Guess (1–100): " user_num

        if [[ ! "$user_num" =~ ^[0-9]+$ ]]; then
            echo "Numbers only!"
            continue
        fi

        prev_guess=$user_num

        if [[ $user_num -lt $comp_num ]]; then
            echo -e "${BLUE}Too Low${RESET}"
        elif [[ $user_num -gt $comp_num ]]; then
            echo -e "${RED}Too High${RESET}"
        else
            echo -e "${GREEN}You got it!${RESET}"
            ((wins++))
            read -p "Play again? (y/n): " again
            if [[ $again == "y" || $again == "Y" ]]; then
                main_menu
            else
                echo -e "${GREEN}Thanks for playing!${RESET}"
                exit
            fi
            return
        fi

        ((attempts--))
        echo "Attempts left: $attempts"
    done

    echo "Out of guesses. Number was $comp_num."
    classic_menu
}

# custom game where the user chooses range and attempts
custom_game(){
    read -p "Max number: " max_num
    read -p "Attempts: " attempts

    if [[ ! "$max_num" =~ ^[0-9]+$ || ! "$attempts" =~ ^[0-9]+$ ]]; then
        echo "Numbers only."
        main_menu
        return
    fi

    comp_num=$((RANDOM % max_num + 1))
    prev_guess=""

    while [[ $attempts -gt 0 ]]; do
        if [[ -n "$prev_guess" ]]; then
            echo -e "${MAGENTA}Previous guess: $prev_guess${RESET}"
        fi
        read -p "Your guess: " user_num

        if [[ ! "$user_num" =~ ^[0-9]+$ ]]; then
            echo "Numbers only!"
            continue
        fi

        prev_guess=$user_num

        if [[ $user_num -lt $comp_num ]]; then
            echo -e "${BLUE}Too Low${RESET}"
        elif [[ $user_num -gt $comp_num ]]; then
            echo -e "${RED}Too High${RESET}"
        else
            echo -e "${GREEN}You got it!${RESET}"
            ((wins++))
            read -p "Play again? (y/n): " again
            if [[ $again == "y" || $again == "Y" ]]; then
                main_menu
            else
                echo -e "${GREEN}Thanks for playing!${RESET}"
                exit
            fi
            return
        fi

        ((attempts--))
        echo "Attempts left: $attempts"
    done

    echo "Out of guesses. Number was $comp_num."
    main_menu
}

# starts the program
main_menu