import 'package:teslo_shop/features/shared/infrastructure/services/camera_gallery_service.dart';
import 'package:image_picker/image_picker.dart';



class CameraGalleryServImpl extends CameraGalleryService {
  // TODO: ELIMINAR el _isPickerACtivi y manejarlo con el formProvider
  final ImagePicker _picker = ImagePicker();
  bool _isPickerActive = false;

  @override
  Future<String?> selectPhoto() async {

    if (_isPickerActive) return null;
    
    try {
      
      _isPickerActive = true;

      final XFile? photo = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      
      if ( photo == null ) return null;

      // print('Tenemos una imagen ${ photo.path }');    
      return photo.path;

    } catch (e) {
      // print('Error al seleccionar foto ${e}');
      return null;
    } finally {
      _isPickerActive = false;
    }

  }

  @override
  Future<String?> takePhoto() async {
    
    if (_isPickerActive) return null;
    
    try {
      
      _isPickerActive = true;

      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        // imageQuality: 80, //Podemos poner un porcentaje de calidad de imagen.
        preferredCameraDevice: CameraDevice.rear,
      );
      
      if ( photo == null ) return null;

      // print('Tenemos una imagen ${ photo.path }');    
      return photo.path;

    } catch (e) {
      // print('Error al seleccionar foto ${e}');
      return null;
    } finally {
      _isPickerActive = false;
    }

  }

}