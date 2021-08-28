// Store object for Alpinejs read more: https://alpinejs.dev/magics/store
const Store = {
  Pagination: {
    totalPage: 0,
    currentPage: 1,
    isFetching: true,
      setTotalPage(total) {
      this.total = total
    },
    setPage(page) {
      this.currentPage = page
    },
    resetWithParam(value) {
      this.totalPage = 0
      this.currentPage = 1
      this.searchParam = value
    },
    setParam(value) {
      this.searchParam = value
    },
    incrementPage() {
      if (this.searchParam) {
        this.currentPage =  this.currentPage + 1
      }
    }
  }
}

export default Store
