import SwiftUI

struct CheckInView: View {
    @State private var selectedTags: Set<FeelingTag> = []
    @State private var freeText: String = ""
    @State private var resultBlend: GunaBlend?
    @State private var showResult = false
    @FocusState private var isTextEditorFocused: Bool

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text("How are you right now?")
                        .font(.title2.bold())
                        .padding(.bottom, 4)

                    Text("Tap what fits, add detail below, or both.")
                        .font(.subheadline)
                        .foregroundStyle(GunaColors.muted)
                        .padding(.bottom, 16)

                    FlowLayout(spacing: 8) {
                        ForEach(FeelingTags.all) { tag in
                            tagChip(tag)
                        }
                    }
                    .padding(.bottom, 20)

                    Text("TELL ME MORE (OPTIONAL)")
                        .font(.caption2.bold())
                        .foregroundStyle(GunaColors.muted)
                        .padding(.bottom, 8)

                    TextEditor(text: $freeText)
                        .frame(minHeight: 90)
                        .padding(8)
                        .background(GunaColors.card)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(GunaColors.border, lineWidth: 1.5)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .padding(.bottom, 24)
                        .focused($isTextEditorFocused)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button("Done") {
                                    isTextEditorFocused = false
                                }
                                .font(.subheadline.bold())
                            }
                        }

                    Button(action: computeResult) {
                        Text("See my guna")
                            .font(.subheadline.bold())
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(canSubmit ? GunaColors.ink : GunaColors.ink.opacity(0.35))
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                    .disabled(!canSubmit)
                }
                .padding(20)
            }
            .scrollDismissesKeyboard(.interactively)
            .background(GunaColors.background)
            .navigationDestination(isPresented: $showResult) {
                if let resultBlend {
                    ResultView(blend: resultBlend)
                }
            }
        }
    }

    private var canSubmit: Bool {
        !selectedTags.isEmpty || !freeText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private func tagChip(_ tag: FeelingTag) -> some View {
        let isSelected = selectedTags.contains(tag)
        let guna = tag.blend.dominant

        return Text(tag.name)
            .font(.system(size: 13, weight: .semibold))
            .padding(.horizontal, 13)
            .padding(.vertical, 8)
            .background(isSelected ? GunaColors.softColor(for: guna) : GunaColors.card)
            .foregroundStyle(isSelected ? GunaColors.color(for: guna) : GunaColors.ink)
            .clipShape(Capsule())
            .overlay(
                Capsule().stroke(isSelected ? GunaColors.color(for: guna) : GunaColors.border, lineWidth: 1.5)
            )
            .onTapGesture {
                isTextEditorFocused = false
                if isSelected {
                    selectedTags.remove(tag)
                } else {
                    selectedTags.insert(tag)
                }
            }
    }

    private func computeResult() {
        let tagBlend = selectedTags.isEmpty ? nil : GunaBlend.average(selectedTags.map(\.blend))
        let textBlend = GunaClassifier.classifyText(freeText)
        resultBlend = GunaClassifier.combine(tagBlend: tagBlend, textBlend: textBlend)
        showResult = true
    }
}

#Preview {
    CheckInView()
}
