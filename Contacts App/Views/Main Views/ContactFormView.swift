
import SwiftUI
import PhotosUI

struct ContactFormView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var contact: Contact
    let onSave: (Contact) -> Void
    
    @State private var selectedImage: PhotosPickerItem?
    @State private var avatarImage: Image?
    @State private var isImageError: Bool = false
    @State private var avatarData: Data?
    
    @FocusState private var focusedField: Field?
    
    enum Field {
        case firstName, lastName, email, phoneNumber, address
       }
    

    var isEmailValid: Bool {
        contact.email.isValidEmail() && !contact.email.isEmpty
    }
    var emailCaption: String {
        contact.email.isEmpty ? "* Email is required" : " Invalid email address"
    }
    var emailCaptionColor: Color {
        contact.email.isEmpty ? .blue : .red
    }
  // Diable save button
    var disabled: Bool {
        contact.firstName.isEmpty ||
        contact.lastName.isEmpty ||
        contact.email.isEmpty ||
        !isEmailValid
    }
    
    private func customTextField(title: String, hint: String, value: Binding<String>, field: Field) -> some View {
        CustomTextField(title: title, hint: hint, value: value, onChange: {})
            .focused($focusedField, equals: field)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Required Information") {
                    customTextField(
                        title: "First Name",
                        hint: "Enter First Name",
                        value: $contact.firstName,
                        field: .firstName
                    )
                    customTextField(
                        title: "Last Name",
                        hint: "Enter Last Name",
                        value: $contact.lastName,
                        field: .lastName
                    )
                    VStack(alignment: .leading, spacing: 4) {
                        customTextField(
                            title: "Email Address",
                            hint: "Enter Email Address",
                            value: $contact.email,
                            field: .email
                        ).keyboardType(.emailAddress)
                            .textInputAutocapitalization(.none)
                        
                        if !isEmailValid {
                            Text(emailCaption)
                                .foregroundStyle(emailCaptionColor)
                                .font(.caption)
                                .fontWeight(.medium)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                }
                
                Section("Optional Information") {
                    customTextField(
                        title: "Phone Number",
                        hint: "Enter Phone Number",
                        value: $contact.phoneNumber,
                        field: .phoneNumber
                    )
                    .keyboardType(.phonePad)
                    
                    customTextField(
                        title: "Address",
                        hint: "Enter Address",
                        value: $contact.address,
                        field: .address
                    )
                  }
                 
                Section("Avatar") {
                    PhotosPicker(
                        selection: $selectedImage,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        ZStack {
                            AvatarView(
                                avatarImage: avatarImage,
                                name: contact.firstName)
                            .frame(
                                maxWidth: .infinity,
                                alignment: .leading)
                             
                            Text("Choose an Avatar")
                                .frame(
                                    maxWidth: .infinity,
                                    alignment: .center)
                        }
                    }
                    
                    Button("Remove Avatar") {
                        avatarImage = nil
                        avatarData = nil
                    }.foregroundStyle(.red)
                    
                    
                 }
                .onChange(of: selectedImage) { _, newValue in
                    loadImage(from: newValue)
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }.foregroundStyle(.red)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        contact.avatar = avatarData
                        onSave(contact)
                        dismiss()
                    }
                    .disabled(disabled)
                }
            }
            .navigationTitle("Add Contact")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if let avatarData = contact.avatar, let uiImage = UIImage(data: avatarData) {
                    avatarImage = Image(uiImage: uiImage)
               }
            }
        }
    }
    
    private func loadImage(from item: PhotosPickerItem?) {
        guard let item = item else { return }
        
        item.loadTransferable(type: Data.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if let data, let uiImage = UIImage(data: data) {
                        avatarImage = Image(uiImage: uiImage)
                        avatarData = data
                        isImageError = false
                    } else {
                        isImageError = true
                    }
                case .failure:
                    isImageError = false
                }
            }
        }
    }
}

#Preview {
    ContactFormView(contact: .constant(Contact()), onSave: { _ in })
}
