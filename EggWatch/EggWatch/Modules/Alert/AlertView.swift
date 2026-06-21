import SwiftUI

struct AlertView: View {
    let onBack: () -> Void

    @StateObject private var viewModel = AlertViewModel()

    var body: some View {
        VStack(spacing: 0) {
            alertNavigation
                .padding(.horizontal, 22)
            alertContent
        }
        .background(Color.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            viewModel.fetchNotifications()
        }
        .overlay {
            if viewModel.isLoading {
                ProgressView()
            }
        }
    }

    // MARK: - 네비게이션 바
    private var alertNavigation: some View {
        HStack(spacing: 8) {
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.black)
                    .frame(width: 24, height: 24)
            }
            Text("알림")
                .font(.medium16)
                .foregroundStyle(.black)
            Spacer()
        }
        .padding(.vertical, 24)
        .background(Color.white)
    }

    // MARK: - 알림 목록 / 빈 상태 / 에러 상태
    @ViewBuilder
    private var alertContent: some View {
        if let error = viewModel.errorMessage {
            emptyStateView(message: error)
        } else if viewModel.notifications.isEmpty && !viewModel.isLoading {
            emptyStateView(message: viewModel.emptyMessage ?? "아직 확인할 알림이 없어요.")
        } else {
            alertList
        }
    }

    private var alertList: some View {
        List {
            ForEach(viewModel.notifications) { item in
                AlertCardView(item: item)
                    .listRowBackground(Color.white)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 5, leading: 35, bottom: 5, trailing: 35))
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            viewModel.markAsRead(notificationId: item.notificationId)
                        } label: {
                            Label("삭제", systemImage: "trash")
                        }
                    }
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }

    private func emptyStateView(message: String) -> some View {
        VStack {
            Spacer()
            Text(message)
                .font(.regular12)
                .foregroundStyle(Color.gray02)
                .multilineTextAlignment(.center)
            Spacer()
        }
    }
}

#Preview {
    AlertView(onBack: {})
}
