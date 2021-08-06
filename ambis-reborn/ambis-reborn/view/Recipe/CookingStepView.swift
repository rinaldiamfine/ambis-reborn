//
//  CookingStepView.swift
//  ambis-reborn
//
//  Created by Muhammad Rizki Miftha Alhamid on 8/4/21.
//

import Foundation
import SwiftUI

struct CookingStepView: View {
    let cookingStepSample: [String]
    
    var body: some View {
        VStack {
            ImagePlaceholder()
            ScrollView {
                ForEach(0..<cookingStepSample.count) { count in
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(.white)
                        RoundedRectangle(cornerRadius: 25)
                            .strokeBorder(Color("BrandColor"), lineWidth: 1)
                        HStack {
                            VStack {
                                Circle()
                                    .foregroundColor(.gray)
                                    .frame(width: 25, height: 25)
                                    .padding(.top)
                                    .offset(x: 0, y: -15)
                                Spacer()
                            }
                            VStack(alignment: .leading) {
                                Text("Step \(count + 1)")
                                    .font(.system(size: 19))
                                    .fontWeight(.semibold)
                                Text(cookingStepSample[count])
                                    .font(.system(size: 16))
                                    .multilineTextAlignment(.leading)
                            }
                            Spacer()
                        }
                        .padding()
                    }
                    .frame(maxHeight: .infinity)
                }
            }.padding(.top)
        }
        .navigationBarTitle("Cooking Steps")
        .padding(.horizontal)
        .background(Color("AppBackground"))
    }
}
