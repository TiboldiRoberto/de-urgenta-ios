import Contacts
import SwiftUI

protocol AddNewManagerViewDelegate {
    func addNewManagerViewDidTapAddManager(_ view: AddNewManagerView)
}

struct AddNewManagerView: View {
    @State private var transferResourcesInNewBackpack = false
    @State private var showingAlert = false

    var delegate: AddNewManagerViewDelegate

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(AppStrings.AddNewManagerView.headerTitle.localized())
                    .font(.custom("IBMPlexSans-SemiBold", size: 23))
                    .frame(alignment: .leading)
                    .padding(.vertical, 10)

                VStack {
                    Text(AppStrings.AddNewManagerView.firstParagraph.localized())
                        .modifier(PrimaryTextStyle())

                    Text(AppStrings.AddNewManagerView.secondParagraph.localized())
                        .modifier(PrimaryTextStyle())
                        .padding(.top, 15)
                }
                .lineSpacing(10)
                .padding(.vertical, 10)

                Toggle(isOn: $transferResourcesInNewBackpack, label: {
                    Text(AppStrings.AddNewManagerView.toggleLabel.localized())
                        .font(.custom("IBMPlexSans-Bold", size: 16))
                        .foregroundColor(.black)
                })
                .padding(.vertical)

                Text(AppStrings.AddNewManagerView.addManagerHeader.localized())
                    .font(.custom("IBMPlexSans-SemiBold", size: 20))
                    .foregroundColor(.darkText)
                    .padding(.vertical)

                VStack {
                    Divider()
                        .padding(.top, 10)

                    Button(action: {
                        requestAccess()
                    }, label: {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.accent)

                            Text(AppStrings.AddNewManagerView.addManagerButton.localized())
                                .font(.custom("IBMPlexSans-SemiBold", size: 20))
                                .foregroundColor(.accent)
                        }
                        .padding(.vertical)

                        Spacer()

                        Image("chevron-right")
                            .renderingMode(.template)
                            .foregroundColor(.accent)
                            .padding(.trailing, 10)
                    })

                    Divider()
                }
                .padding(.bottom, 20)

                Spacer()
            }
            .padding(.horizontal)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(AppStrings.GroupView.alertTitle.localized()),
                      message: Text(AppStrings.GroupView.alertMessage.localized()),
                      primaryButton: .default(Text(AppStrings.GroupView.alertPrimaryButton.localized()), action: {
                          UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                      }),
                      secondaryButton: .default(Text(AppStrings.GroupView.alertCloseButton.localized())))
            }
        }
    }

    func requestAccess() {
        CNContactStore().requestAccess(for: .contacts) { access, _ in
            if access {
                DispatchQueue.main.async {
                    delegate.addNewManagerViewDidTapAddManager(self)
                }
            } else {
                showingAlert.toggle()
            }
        }
    }
}
