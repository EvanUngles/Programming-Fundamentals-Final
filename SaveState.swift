//
//  SaveState.swift
//  Programming Fundamentals Final
//
//  Created by Evan K. Ungles on 5/19/26.
//

import Foundation

let fileManager = FileManager.default
let fileURL = fileManager.homeDirectoryForCurrentUser.appendingPathComponent("pet.json")

class SaveState
{
    //Loads the pet from the saved file if there is one
    //Creates a new pet if there isn't an existing one
    static func load() -> Pet
    {
        //Checks if there is an existing file
        if ( fileManager.fileExists(atPath: fileURL.path) )
        {
            do
            {
                //Reads the file
                let data = try Data(contentsOf: fileURL)
                
                //Decodes the file data
                let decoder = JSONDecoder()
                let petData = try decoder.decode(Pet.self, from: data)
                
                //Recreates the pet and returns it
                return Pet(petData.name, petData.numHours, petData.happiness, petData.timeLastFed)
            }
            catch
            {
                //Stops the program if something goes wrong
                fatalError("Failed to load save: \(error.localizedDescription)")
            }
        }
        else
        {
            //Creates a new pet if there isn't an existing one
            return Pet()
        }
    }
    
    
    
    //Saves the pet
    static func save(_ pet: Pet)
    {
        do
        {
            //Encodes the information
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted   //Makes the file more readable for humans
            let data = try encoder.encode(pet)
            
            //Writes the data to the file
            //The .atomic makes it write to a temporary file first then swap it with the actual file, which makes sure that the original file won't be affected if something happens in the middle of saving
            try data.write(to: fileURL, options: .atomic)
        }
        catch
        {
            fatalError("Failed to save: \(error.localizedDescription)")
        }
    }
}
