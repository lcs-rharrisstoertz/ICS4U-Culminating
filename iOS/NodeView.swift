//
//  NodeView.swift
//  iOS
//
//  Created by Salvarajah, Prajina on 2022-06-01.
//

import SwiftUI
//import ICS4U_Culminating

struct NodeView: View {
   
    // MARK: Stored properties
        let node: Node
        @Binding var activeNode: Int
        @State private var reader: ScrollViewProxy?
        
        var body: some View {
            
            ScrollView {
                
                ScrollViewReader {
                    scrollViewProxy in
                    
                    Text("")
                        .id("top-of-page")
                        .tag("top-of-page")
                    

                    VStack(alignment: .leading) {
                        
                        // Ending page
                        if node.ending != nil {
                            
                            // Returns to the first page of the book
                            Button("restart") {
                                
                                activeNode = 1
                                
                            }
                            
                            // Leads to the AchievementsView
                            AchievementsView()
                            
                            
                        } else {
                            
                            // A normal story page
                            // Page number
                            Text("\(node.id)")
                                .padding()
                                .font(.custom("Georgia", size: 30, relativeTo: .headline))
                            
                            // Iterate over all the paragraphs
                            ForEach(node.paragraphs, id: \.self) { currentParagraph in
                                Text(currentParagraph)
                                    .padding()
                                    .font(.custom("Georgia", size: 20, relativeTo: .headline))
                            }
                            
                            // Show the image, if there is one
                            
                            if let image = node.image {
                                
                                Image(image)
                                    .resizable()
                                    .scaledToFit()

                            }
                            
                            // Show choices, when they exist
                            ForEach(node.edges, id: \.self) { currentEdge in
                                HStack {
                                    Spacer()
                                    
                                    Text(currentEdge.prompt)
                                        .italic()
                                        .padding()
                                        .font(.custom("Georgia", size: 20, relativeTo: .headline))
                                        .multilineTextAlignment(.trailing)
                                        .onTapGesture {
                                            if currentEdge.destinationId == 132 {
                                                
                                                addEndingReached(currentNode: activeNode)
                                                
                                            }
                                            // Advance to whatever node this prompt is for
                                            activeNode = currentEdge.destinationId
                                            
                                            // Sets the scroll view to return to the top after moving to a new page
                                            reader?.scrollTo("top-of-page")

                                        }
                                    
                                }
                            }
                            
                        }
                       
                    }
                    .onAppear {
                        self.reader = scrollViewProxy
                    }

                }
                                
            }
            .background(
                Image("Background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all))
            
        }
    }

struct NodeView_Previews: PreviewProvider {
    static var previews: some View {
        NodeView(node: testNode, activeNode: Binding.constant(4))
    }
}
