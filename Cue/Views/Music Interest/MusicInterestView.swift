//
//  MusicInterestView.swift
//  Cue
//
//  Created by Jaylen Smith on 10/8/22.
//

import SwiftUI

struct MusicInterestView: View {
    
    @State private var selectedMusicInterest = Set<MusicInterest>()
    @State private var alertOfDismissingWithOutSave: Bool = false
    
    @State private var displayCaution: Bool = false
    
    @StateObject var onBoardVM = OnBoardViewModel()
    @ObservedObject var musicModel: MusicModel
        
    let columns = [GridItem(), GridItem()]
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 15) {
                Text("Your interest")
                    .largeTitleStyle()
                Text("Let's get to know who you are! Tell us what music genre you're into")
                    .multilineTextAlignment(.center)
                if displayCaution {
                    Text("Your previously saved genres will be replaced")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                Text("\(musicModel.limitOfMusicInterest - self.selectedMusicInterest.count) avaliable")
                Divider()
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(musicInterests.sorted(by: <), id: \.id) { interest in
                            MusicInterestMemberStyle(interest: interest, musicModel: musicModel, selectedMusicInterest: $selectedMusicInterest)
                                .onTapGesture { checkMusicInterst(interest: interest) }
                        }
                    }
                }
                Spacer()
                if self.selectedMusicInterest.count == musicModel.limitOfMusicInterest {
                    if musicModel.isShowingMusicInterestView {
                        Button {
                            self.save()
                            musicModel.isShowingMusicInterestView = false
                        } label: {
                            Text("Done")
                                .onBoardButtonStyle()
                        }
                    } else {
                        NavigationLink {
                            BeginCueView(onBoardVM: onBoardVM, musicModel: musicModel)
                        } label: {
                            Text("Next")
                                .onBoardButtonStyle()
                        }
                    }
                }
                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            isBeingPresented()
        }
        .onDisappear {
            save()
        }
        .alert("You're leaving?", isPresented: self.$alertOfDismissingWithOutSave) {
            Button("Ok") { dismiss() }
            Button("Nevermind") {}
        } message: {
            Text("Any changes made will not be saved!")
        }
    }
    
    ///Check if the passed 'MusicInterest' has been saved or not; or if 'musicInterest' count equal 5. With haptic feedback
    private func checkMusicInterst(interest: MusicInterest) {
        
        let feedbackRemoved = UIImpactFeedbackGenerator(style: .light)
        let notificationFeedback = UINotificationFeedbackGenerator()
                
        if selectedMusicInterest.contains(interest) {
            removeMusicInterest(member: interest)
            feedbackRemoved.impactOccurred()
        } else if selectedMusicInterest.count == musicModel.limitOfMusicInterest {
            notificationFeedback.notificationOccurred(.warning)
        }
        else {
            selectedMusicInterest.insert(interest)
            feedbackRemoved.impactOccurred()
        }
    }
    
    private func isBeingDismissed() {
        if self.selectedMusicInterest.count != 0 {
            self.alertOfDismissingWithOutSave = true
        }
        else {
            dismiss()
        }
    }
    
    private func isBeingPresented() {
        if !musicModel.savedMusicInterest.isEmpty {
            displayCaution = true
        } else {
            displayCaution = false
        }
    }
    
    private func save() {
        if selectedMusicInterest.count == musicModel.limitOfMusicInterest {
            musicModel.savedMusicInterest = Array(selectedMusicInterest)
        }
    }
    
    private func removeMusicInterest(member: MusicInterest) {
        DispatchQueue.main.async {
            selectedMusicInterest.remove(member)
        }
    }
}

struct MusicInterestMemberStyle: View {
    
    let interest: MusicInterest
    
    @ObservedObject var musicModel: MusicModel
    
    @Binding var selectedMusicInterest: Set<MusicInterest>
    
    var isSelected: Bool {
        return self.selectedMusicInterest.contains {
            $0.title == self.interest.title
        }
    }
    
    var hasReachedLimit: Bool {
        return self.selectedMusicInterest.count == musicModel.limitOfMusicInterest
    }
    
    var body: some View {
        ZStack {
            Text(interest.title)
                .padding()
                .font(.caption2.weight(.semibold))
                .frame(width: 105)
                .background(isSelected ? Color(uiColor: .white) : hasReachedLimit ? Color.gray : Color.brandPink)
                .foregroundColor(isSelected ? .black : .white)
                .cornerRadius(15)
        }
    }
}

struct MusicInterestView_Previews: PreviewProvider {
    static var previews: some View {
        MusicInterestView(onBoardVM: OnBoardViewModel(), musicModel: MusicModel())
    }
}
