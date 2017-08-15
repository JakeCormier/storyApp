//
//  Page.swift
//  InteractiveStory
//
//  Created by Jake Cormier on 8/14/17.
//  Copyright © 2017 Government Entertainment. All rights reserved.
//

import Foundation

enum AdventureError: Error {
    case nameNotProvided
}

class Page {
    let story: Story
    
    typealias Choice = (title: String, page: Page)
    //tuple is an anon struct
    var firstChoice: Choice?
    var secondChoice: Choice?
    
    init(story: Story) {
        self.story = story
    }
}

extension Page {
    func addChoiceWith(title: String, story: Story) -> Page {
        let page = Page(story: story)
        return addChoiceWith(title: title, page: page)
    }
    
    func addChoiceWith(title: String, page: Page) -> Page {

        switch(firstChoice, secondChoice) {
        case (.some, .some): return self
                            // or break
        case (.none, .none), (.none, .some): firstChoice = (title, page)
                            // this makes it exhaustive
            
        //an optional is an enum under the hood with a none and some case
            
        case(.some, .none): secondChoice = (title, page)
        }
        /*guard firstChoice != nil && secondChoice != nil else { return self }
        //checking if both firstChoice and secondChoice are nil
        //if they are not nil it will return self which is the Page
        
        if firstChoice == nil {
            firstChoice = (title, page)
        } else {
            secondChoice = (title, page)
        }*/
        
        return page
    }
}

struct Adventure {
    static func story(withName name: String) -> Page {
        let returnTrip = Page(story: .returnTrip(name: name))
        let touchdown = returnTrip.addChoiceWith(title: "Stop and Investigate", story: .touchDown)
        let homeward = returnTrip.addChoiceWith(title: "Continue home to Earth", story: .homeward)
        let rover = touchdown.addChoiceWith(title: "Explore the Rover", story: .rover(name: name))
        let crate = touchdown.addChoiceWith(title: "Open the Crate", story: .crate)
        
        homeward.addChoiceWith(title: "Head back to Mars", page: touchdown)
        let home = homeward.addChoiceWith(title: "Continue Home to Earth", story: .home)
        
        let cave = rover.addChoiceWith(title: "Explore the Coordinates", story: .cave)
        rover.addChoiceWith(title: "Return to Earth", page: home)
        
        cave.addChoiceWith(title: "Continue towards faint light", story: .droid(name: name))
        cave.addChoiceWith(title: "Refill the ship and explore the rover", page: rover)
        
        crate.addChoiceWith(title: "Explore the Rover", page: rover)
        crate.addChoiceWith(title: "Use the key", story: .monster)
        
        return returnTrip
    }
}




















