import topbar from "topbar"
import { handleImg } from './helper'
import { dispatchEvent } from '../helper'

const Hooks = {
  SearchPhoto: {
    mounted() {
      window.SearchPhotoHook = this
      console.log('SEARCH PHOTO MOUNTED')
    },
    destroyed() {
      window.SearchPhotoHook = null
    },
    request(value) {
      this.pushEventTo(".photo-list", "search", {value})
      dispatchEvent({ evtName: "fetch-data", payload: {} })
      topbar.show()
    }
  },
  PhotoList: {
    mounted() {
      window.PhotoListHook = this
      this.handleEvent("fetch_result", (payload) => {
        console.log({ photos: payload.photos })
        payload.photos.forEach(handleImg)
        dispatchEvent({ evtName: "request-finished", payload })
      })
    },
    updated() {
      console.log("updated..")
    },
    destroyed() {
      window.PhotoListHook = null
    }
  }
}

export default Hooks
