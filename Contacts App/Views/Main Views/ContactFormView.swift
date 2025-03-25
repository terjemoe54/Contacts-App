
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
    
// TODO: isEmailValid
    var isEmailValid: Bool {
        true
    }
    var emailCaption: String {
        contact.email.isEmpty ? "* Email is required" : " Invalid email address"
    }
    var emailCaptionColor: Color {
        contact.email.isEmpty ? .blue : .red
    }
  // Diable save button
    var disable: Bool {
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
            }
        }
    }
}

#Preview {
    ContactFormView(contact: .constant(Contact()), onSave: { _ in })
}
