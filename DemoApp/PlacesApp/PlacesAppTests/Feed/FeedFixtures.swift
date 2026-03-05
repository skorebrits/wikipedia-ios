//
//  FeedFixtures.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

enum FeedFixtures {
    
    static let validJSONResponse = """
        {
          "locations": 
          [
            {
              "name": "Amsterdam",
              "lat": 52.3547498,
              "long": 4.8339215
            },
            {
              "name": "Mumbai",
              "lat": 19.0823998,
              "long": 72.8111468
            },
            {
              "name": "Copenhagen",
              "lat": 55.6713442,
              "long": 12.523785
            },
            {
              "lat": 40.4380638,
              "long": -3.7495758
            }
          ]
        }
        """
    
    static let invalidJSONResponse = """
        {
          "locs": 
          [
            {
              "name": "Amsterdam",
              "lat": 52.3547498,
              "long": 4.8339215
            },
          ]
        }
        """
}
