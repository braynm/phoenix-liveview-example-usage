import topbar from "topbar"
export default function list() {
  return {
    isRequestPending: true,
    keyword: "",
    photos: [],
    metadata: {},
    handleRequest() {
      this.isRequestPending = true
    },
    isEmpty() {
      return !this.isRequestPending && this.photos.length <= 0
    },
    requestFinished(data) {
      this.isRequestPending = false
      this.photos = data.photos
      this.metadata = data.metadata
      topbar.hide()
    },
    loadingItems(total = 10) {
      let list = []
      for (let i = 1; i <= total; i++) {
        list[i] = i
      }

      return list
    }
  }
}

