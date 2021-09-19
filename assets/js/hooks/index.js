import topbar from "topbar"
import { handleImg } from './helper'
import { dispatchEvent } from '../helper'

const Hooks = {
  SearchPhoto: {
    mounted() {
      window.SearchPhotoHook = this
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
        payload.photos.forEach(handleImg)
        dispatchEvent({ evtName: "request-finished", payload })
      })
    },
    destroyed() {
      window.PhotoListHook = null
    },
    requestNextPage(payload) { 
      this.pushEventTo(".photo-list", "next_page", payload)
    }
  },
  Pager: {
    mounted() {
      //window.PagerHook = this
    },
    requestNextPage() {

    }
  },
  Chat: {
    mounted() {
      window.ChatHook = this
      this.handleEvent("new_message", (payload) => {
        dispatchEvent({ evtName: "new-message", payload })
      })
    },
    sendMessage(payload) {
      this.pushEventTo("#chat", "send_message", payload)
    }
  }
}

export default Hooks
