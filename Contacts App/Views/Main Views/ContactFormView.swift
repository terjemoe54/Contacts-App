
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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ContactFormView(contact: .constant(Contact()), onSave: { _ in })
}
