import Alpine from "alpinejs"
export default function search() {
  return {
    searchPhoto(value) {
      if (value) {
        Alpine.store("pagination").resetWithParam(value)
        window.SearchPhotoHook.request(value)
      }
    }
  }
}

