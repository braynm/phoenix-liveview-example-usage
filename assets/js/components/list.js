import topbar from "topbar"
export default function list() {
  return {
    isRequestPending: true,
    keyword: "",
    currentPage: 1,
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

      //if (data.photos.length <= 0) {
        //dispatchEvent({ evtName: "request-finished", payload: {} })
      //}

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
