//
//  Pet.swift
//  Programming Fundamentals Final
//
//  Created by Evan K. Ungles on 5/19/26.
//

import Foundation

class Pet: Codable
{
    var name: String
    var numHours: Double
    var happiness: Int
    var timeLastFed: Date
    
    //For the first time
    init()
    {
        print("You see a stray animal wandering around the gym. It seems to like you, and follows you around. \nWhat do you want to call it?")
        
        var nameGiven: String
        while (true)
        {
            nameGiven = readLine()!
            
            var isValid = true
            for char in nameGiven
            {
                if (!char.isLetter && !char.isNumber && ![" ", "_", "."].contains(char))
                {
                    print("That's a weird name, maybe try something else")
                    isValid = false
                    break
                }
            }
            if (isValid) { break }
        }
        
        name = nameGiven
        print("\(name) seems like that name")
        
        numHours = 0
        happiness = 0
        timeLastFed = Date()
    }
    
    init(_ name: String, _ numHours: Double, _ happiness: Int, _ timeLastFed: Date)
    {
        self.name = name
        self.numHours = numHours
        self.happiness = happiness
        self.timeLastFed = timeLastFed
    }
    
    
    
    func welcomeBack()
    {
        printASCII()
        
        let messages = ["\(name) seems happy to see you", "\(name) looks at you intently as you approach", "\(name) greets you with a hopeful expression"]
        print(messages.randomElement()!)
    }
    
    
    
    func feed()
    {
        print()
        while (true)
        {
            print("\(name) wants to know how how many hours you were exercising (or 0 to walk away)")
            let hours = Double(readLine()!)
            
            if (hours == nil || hours! < 0)
            {
                print("That doesn't seem right!\n")
            }
            else if (hours == 0)
            {
                print("\(name) seems disappointed as you walk away")
                break
            }
            else
            {
                numHours += hours!
                updateHappiness(hours!)
                timeLastFed = Date()
                break
            }
        }
    }
    
    
    
    func checkStats()
    {
        printASCII()
        print("Total number of hours exercising: \(numHours) hours!")
        
        let timeSinceFed = Date().timeIntervalSince(timeLastFed) / (60 * 60)
        print("Time since working out: \( (timeSinceFed * 10).rounded() / 10.0 ) hours")
    }
    
    
    
    func updateHappiness(_ hours: Double)
    {
        let hoursSinceLastFed = max(Date().timeIntervalSince(timeLastFed), 1) / (60 * 60)
        happiness += Int((hours/hoursSinceLastFed) * 10 - hoursSinceLastFed)
        
        print("It's been \( (hoursSinceLastFed * 10).rounded() / 10.0 ) hours since you last fed \(name)")
        
        printASCII()
        let messages = ["\(name) seems to like that", "\(name) stares at you intently, waiting for more", "\(name) seems grateful for that", "\(name) looks at you with a hopeful expression"]
        print(messages.randomElement()!)
    }
    
    
    
    //Prints out ASCII art to represent the happiness of the pet
    func printASCII()
    {
        print()
        
        if (happiness < 10)
        {
            print(
                """
                 | |
                 ___
                /   \\
                """)
        }
        else if (happiness < 100)
        {
            print(
                """
                 | |
                _____
                """)
        }
        else if (happiness < 200)
        {
            print(
                """
                 | |
                .___.
                """)
        }
        else if (happiness < 500)
        {
            print(
                """
                 | |
                -___-
                """)
        }
        else
        {
            print(
                """
                 | |
                \\___/
                """)
        }
        
        print("Happiness: \(happiness)")
    }
}
