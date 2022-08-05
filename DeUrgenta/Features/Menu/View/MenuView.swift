import SwiftUI

protocol MenuViewDelegate {
    func menuViewShouldRedirect(from view: MenuView, withItem item: MenuOption)
    func menuViewDidTapDonateButton(_ view: MenuView)
}

struct MenuView: View {
    var viewModel: MenuViewModel
    var delegate: MenuViewDelegate

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LogoView()

                ForEach(viewModel.options, id: \.self) { option in
                    Button(action: {
                        delegate.menuViewShouldRedirect(from: self, withItem: option)
                    }, label: {
                        MenuOptionItem(option: option)
                    })
                }

                Spacer()

                VStack(alignment: .leading) {
                    Text(AppStrings.MenuView.headerIconLabel.localized())
                        .foregroundColor(Color.gray)
                        .customFont(size: 14)

                    Image("code4romania-icon")

                    DonateButton(delegate: delegate, mainView: self)
                }
                .padding(.top, 80)
                .padding(.horizontal)
            }
        }
    }
}

struct LogoView: View {
    var body: some View {
        HStack {
            Image("logo")
                .resizable()
                .frame(width: 100, height: 100)

            Spacer()
        }
        .padding()
    }
}

struct MenuOptionItem: View {
    var option: MenuOption

    var body: some View {
        VStack(alignment: .leading) {
            Text(option.name)
                .customFont(.IBMPlexSansBold, size: 16)
                .padding()

            Divider()
        }
    }
}

struct DonateButton: View {
    var delegate: MenuViewDelegate
    var mainView: MenuView

    var body: some View {
        Button(action: {
            delegate.menuViewDidTapDonateButton(mainView)
        }, label: {
            HStack {
                Text(AppStrings.MenuView.donateButtonText.localized())
                    .foregroundColor(.secondary)
                    .customFont(.IBMPlexSansBold, size: 16)
                    .padding(.vertical)
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(Color.green)
            .cornerRadius(6)
        })
        .padding(.vertical, 20)
    }
}
