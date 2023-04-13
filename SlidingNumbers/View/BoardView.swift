//
//  BoardView.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-02.
//

import SwiftUI

struct BoardView: View{
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @Environment(\.dismiss) private var dismiss
    @Environment(\.isPresented) private var isPresented
    @StateObject var boardModel = BoardModel()
    @State private var orientation = UIDeviceOrientation.unknown
    @State var isShowPicker: Bool = false
    //@State var isLaunchCamera: Bool = false ////// Ask for permission
    @State var isMemoryWarning: Bool = false
    @State var image: Image? = Image(systemName:"person.fill")
   
    private let memoryWarningPublisher = NotificationCenter.default.publisher(for: UIApplication.didReceiveMemoryWarningNotification)

    func reload(){
        boardModel.resetBoard()
        boardModel.regenerateBoard.toggle()
    }
    
    func navigateBack(){
        //boardModel.clearBoard()
        dismiss()
    }
    
    var body: some View{
        VStack{
            HStack{
                Button(action: navigateBack, label: {
                    Text("Go Back")
                        .font(.subheadline.bold())
                        
                })
                .frame(alignment: .leading)
                Button(action: reload, label: {
                    Text("Reload Board")
                        .font(.subheadline.bold())
                })
                .frame(maxWidth: .infinity,alignment: .center)
                /*Button(action: { self.isLaunchCamera.toggle() }, label: {
                    Image(systemName:"camera.fill")
                        .resizable()
                        .scaledToFit()
                })
                .frame(maxWidth: .infinity,maxHeight: 30.0)*/
                Button(action: { self.isShowPicker.toggle() }, label: {
                    image?
                        .resizable()
                        .scaledToFit()
                })
                .frame(maxWidth: 30.0,maxHeight: 30.0)
            }
            GeometryReader { geometry in
                ZStack() {
                    ForEach(boardModel.getMarkers(width:geometry.size.width,height:geometry.size.height), id: \.id) { marker in
                        BoardCell(cellMarker:marker)
                    }
                    
                }
                .environmentObject(boardModel)
                .frame(width: geometry.size.width,
                       height: geometry.size.height,
                       alignment: .topLeading)
                .border(WOOD_IMAGE_PAINT, width: BOARDER_SIZE)
                /*.onRotate { newOrientation in
                    orientation = newOrientation
                }*/
                .onAppear{
                    //printAny("on Appear BoardView \(safeAreaInsets.leading)")
                    
                }
                .onDisappear{
                    //printAny("on Dissapear BoardView")
                    
                }
                
            }
        }
        .sheet(isPresented: $isShowPicker) {
            ImagePicker(image: self.$image,sourceType: .photoLibrary)
        }
        /*.sheet(isPresented: $isLaunchCamera) {
            ImagePicker(image: self.$image,sourceType: .camera)
        }*/
        .alert("App Recieved Memory Warning", isPresented: $isMemoryWarning) {
            Button("OK", role: .cancel) { }
        }
        .padding(.top,10)
        .padding([.leading,.trailing,.bottom],20)
        .onReceive(memoryWarningPublisher) { _ in
            isMemoryWarning.toggle()
        }
    }
    
}

struct ImagePicker: UIViewControllerRepresentable {

    @Environment(\.presentationMode)
    var presentationMode
    @Binding var image: Image?
    var sourceType: UIImagePickerController.SourceType
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode, image: $image)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

        @Binding var presentationMode: PresentationMode
        @Binding var image: Image?

        init(presentationMode: Binding<PresentationMode>, image: Binding<Image?>) {
            _presentationMode = presentationMode
            _image = image
        }
        
        deinit{
            printAny("deinit coordinator")
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
                printAny("we have not image")
                presentationMode.dismiss()
                return 
            }
            printAny("we have image")
            image = Image(uiImage: uiImage)
            presentationMode.dismiss()

        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            printAny("dismiss")
            presentationMode.dismiss()
        }

    }

}
