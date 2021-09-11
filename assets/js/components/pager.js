import topbar from "topbar"
import {
  both,
  complement,
  compose,
  isEmpty,
  prop,
  when,
} from "ramda"
import { dispatchEvent } from "../helper"
export default function pager() {
  return {
    isResultEmpty: false,
    metadata: {},
    requestNextPage() {
      const hasQuery = compose(
        complement(isEmpty),
        prop('query')
      )
      const hasNextPage = ({ page, total_pages }) => page < total_pages
      const dispatchWhenNextPageExists = when(
        both(hasQuery, hasNextPage),
        ({ page, query }) => {
          topbar.show()
          window.PhotoListHook.requestNextPage({ page: page + 1, query })
        }
      )
      dispatchWhenNextPageExists(this.metadata)
    },
    handleSearchResult(data) {
      this.metadata = data.metadata
      if (data.photos.length <= 0) {
        this.isResultEmpty = true
      } else {
        this.isResultEmpty = false
      }
    }
  }
}
