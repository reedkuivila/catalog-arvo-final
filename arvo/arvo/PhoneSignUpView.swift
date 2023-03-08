//
//  PhoneAuthentication.swift
//  Final Project AG RK
//
//  Created by reed kuivila on 3/1/23.
//

import SwiftUI
import Combine


struct PhoneAuthentication: View {
    @State var phoneNumber: String = ""
    @State var showCountries = false
    @State var countryCode : String = "+1"
    @State var countryFlag : String = "🇺🇸"
    @State var countryPattern : String = "### ### ####"
    @State var countryLimit : Int = 17
    @State private var searchCountry: String = ""
    
    @Environment(\.colorScheme) var colorScheme
    @FocusState private var keyIsFocused: Bool
    
    let counrties: [CountryData] = Bundle.main.decode("CountryNumbers.json")
    
    var filteredCountries: [CountryData] {
        if searchCountry.isEmpty {
            return counrties
        } else {
            return counrties.filter { $0.name.contains(searchCountry) }
        }
    }
    var body: some View {
        // prompt user to enter his/her phone number
        VStack (alignment: .leading){
            Text("What's your phone number?")
                .padding(.leading, 25)
                .padding(.top, -150)
                .font(.custom("times", fixedSize: 40.0))
                .fontWeight(.bold)
            
            HStack {
                Button {
                    showCountries = true
                    keyIsFocused = false
                } label: {
                    Text("\(countryFlag) \(countryCode)")
                        .padding(10)
                }
                TextField("phone number",
                          text: $phoneNumber)
                .keyboardType(.numberPad)
                .fontWeight(.bold)
                .focused($keyIsFocused)
                
            }
        }
        
        // show list of countries with emojis when tapped
        .sheet(isPresented: $showCountries) {
            NavigationView {
                List(filteredCountries) { country in
                    HStack {
                        Text(country.flag)
                        Text(country.name)
                            .font(.headline)
                        Spacer()
                        Text(country.dial_code)
                            .foregroundColor(.secondary)
                    }
                    .onTapGesture {
                        self.countryFlag = country.flag
                        self.countryCode = country.dial_code
                        self.countryPattern = country.pattern
                        self.countryLimit = country.limit
                        showCountries = false
                        searchCountry = ""
                    }
                }
                .listStyle(.plain)
                .searchable(text: $searchCountry, prompt: "Your country")
            }
        }
    }
    
    func applyPatternOnNumbers(_ stringvar: inout String, pattern: String, replacementCharacter: Character) {
        var pureNumber = stringvar.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else {
                stringvar = pureNumber
                return
            }
            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacementCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        stringvar = pureNumber
    }
}


struct PhoneAuthentication_Previews: PreviewProvider {
    static var previews: some View {
        PhoneAuthentication()
    }
}
