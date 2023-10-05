//
//  DataCoordinator+Apollo.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 10/5/23.
//

import Apollo
import PokeAPI

extension DataCoordinator {
    func makePokemonGraphQLCall() {
           debugPrint("\(DataCoordinator.identifier) makePokemonGraphQLCall \(DebuggingIdentifiers.actionOrEventInProgress) Making API Call... \(DebuggingIdentifiers.actionOrEventInProgress)")
           guard let apolloClient = self.apolloClient else {
               debugPrint("\(DataCoordinator.identifier) makePokemonGraphQLCall \(DebuggingIdentifiers.actionOrEventFailed) Could not make call as Apollo Client does not exist.")
               return
           }

           apolloClient.fetch(query: PokemonGraphQLCallQuery()) { result in
               switch result {
               case .success(let response):
                   // Please note that we only print the first one to avoid overloading the interface.
                   debugPrint("\(DataCoordinator.identifier) makePokemonGraphQLCall \(DebuggingIdentifiers.actionOrEventSucceded) Retrieved GraphQL Pokemon Data : \(response.data?.pokemon_v2_pokemon.first?.name).")
               case .failure(let error):
                   debugPrint("\(DataCoordinator.identifier) makePokemonGraphQLCall \(DebuggingIdentifiers.actionOrEventFailed) Failed to retrieve GraphQL Pokemon Data with error : \(error).")
               }
           }
       }
}
