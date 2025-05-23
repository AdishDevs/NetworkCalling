//
//  ContentView.swift
//  NetworkCalling
//
//  Created by Admin on 2025-05-23.
//

import SwiftUI

struct ContentView: View {
    @State private var user: GItHubUser?
    
    var body: some View {
        VStack(spacing:20){
            
            AsyncImage(url: URL(string: user?.avatarUrl ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .foregroundColor(.gray)
            }
            .frame(width: 150,height: 150)
            
                
            Text(user?.login ?? "Login Placeholder")
                .bold()
                .font(.title3)
            Text(user?.bio ?? "Bio Placeholder")
                .padding()
            Spacer()
        }
        .padding()
        .task {
            do{
                user = try await getUser()
            } catch GHError.invalidURL{
                print("invalid URL")
            }catch GHError.invalidResponse{
                print("invalid response")
            }catch GHError.invalidData{
                print("invalid data")
            }catch{
                print("unexpected error")
            }
        }
    }
    
    func getUser() async throws ->GItHubUser{
        let endpoint = "https://api.github.com/users/AdishDevs"
        guard let url = URL(string: endpoint) else {
            throw GHError.invalidURL
        }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GHError.invalidResponse
        }
        
        do{
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(GItHubUser.self, from: data)
        }catch{
            throw GHError.invalidData
        }
    }
}

#Preview {
    ContentView()
}

struct GItHubUser: Codable{
    let login: String
    let avatarUrl: String
    let bio: String
    
}



enum GHError: Error{
    case invalidURL
    case invalidResponse
    case invalidData
}
