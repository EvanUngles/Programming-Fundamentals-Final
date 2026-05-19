//
//  main.swift
//  Programming Fundamentals Final
//
//  Created by Evan K. Ungles on 5/19/26.
//

import Foundation

let pet = SaveState.load()

pet.welcomeBack()
while (true)
{
    print("\nInput the number for what would you like to do?\n1: Feed \(pet.name)\n2: Check your progress\n0: Leave")
    
    let response = Int(readLine()!)
    
    if (response == nil)
    {
        print("Please input a whole number")
    }
    else if (response == 1)
    {
        pet.feed()
    }
    else if (response == 2)
    {
        pet.checkStats()
    }
    else if (response == 0)
    {
        break
    }
    else
    {
        print("That wasn't one of the options")
    }
}

SaveState.save(pet)
print("\(pet.name) watches sadly as you walk away")
