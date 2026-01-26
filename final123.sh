#!/bin/bash

greet_user() {
    read -p "Whats your name? " user_name
    if [ -z "$user_name" ]; then
        echo "Hello User!"
    else
        echo "Hello $user_name"
    fi
}

difficulty_level(){
    read -p " $user_name Choose a difficulty level Easy, Medium, or Hard: " difficulty
    case "${difficulty,,}" in
        easy) easy ;;
        medium) medium ;;
        hard) hard ;;
        *) echo "Invalid difficulty level."; difficulty_level ;;
    esac
}

easy(){
    attempts=10
    comp_num=$((RANDOM % 10 + 1))
    while [[ $attempts -gt 0 ]]; do
        read -p " $user_name Choose a number between 1 and 10: " user_num

        if [[ ! "$user_num" =~ ^[0-9]+$ ]]; then
        echo "Numbers only! Try again."
        continue
    fi
        if [[ $user_num -lt $comp_num ]]; then
            echo "Too Low"
        elif [[ $user_num -gt $comp_num ]]; then
            echo "Too High"
        else
            echo "You got it!"
            break
        fi
        ((attempts--))
        echo " $user_name You have $attempts attempts remaining to guess the number."
    done
 [[ $attempts -eq 0 ]] && echo "You've run out of guesses, you lose. The number was $comp_num."
    read -p "Would you like to play again? (yes/no): " play_again
    if [[ "$play_again" = "yes" ]]; then
    	difficulty_level
    else 
    	echo "Thanks for playing! $user_name "
    	
    fi
}

medium(){
    attempts=10
    comp_num=$((RANDOM % 50 + 1))
    while [[ $attempts -gt 0 ]]; do
       read -p " $user_name Choose a number between 1 and 10: " user_num

        if [[ ! "$user_num" =~ ^[0-9]+$ ]]; then
        echo "Numbers only! Try again."
        continue
    fi
        if [[ $user_num -lt $comp_num ]]; then
            echo "Too Low"
        elif [[ $user_num -gt $comp_num ]]; then
            echo "Too High"
        else
            echo "You got it!"
            break
        fi
        ((attempts--))
       echo " $user_name You have $attempts attempts remaining to guess the number."
    done
     [[ $attempts -eq 0 ]] && echo "You've run out of guesses, you lose. The number was $comp_num."
    read -p "Would you like to play again? (yes/no): " play_again
    if [[ "$play_again" = "yes" ]]; then
    	difficulty_level
    else 
    	echo "Thanks for playing! $user_name "
    	
    fi
}

hard(){
    attempts=10
    comp_num=$((RANDOM % 100 + 1))

    while [[ $attempts -gt 0 ]]; do
        read -p " $user_name Choose a number between 1 and 100: " user_num

        if [[ ! "$user_num" =~ ^[0-9]+$ ]]; then
        echo "Numbers only! Try again."
        continue
    fi

        if [[ $user_num -lt $comp_num ]]; then
            echo "Too Low"
        elif [[ $user_num -gt $comp_num ]]; then
            echo "Too High"
        else
            echo "You got it!"
            break
        fi

        ((attempts--))
        echo " $user_name You have $attempts attempts remaining to guess the number."
    done

    [[ $attempts -eq 0 ]] && echo "You've run out of guesses, you lose. The number was $comp_num."

    read -p "Would you like to play again? (yes/no): " play_again
    if [[ "$play_again" = "yes" ]]; then
        difficulty_level
    else
        echo "Thanks for playing! $user_name"
    fi
}


greet_user
difficulty_level
