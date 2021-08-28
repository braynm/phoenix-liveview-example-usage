import { decode } from "blurhash"
// helper function for replacing blurhash in the DOM
export function handleImg (photo) {
  const itemContainer = document.getElementById(`item-${photo.id}`)
  const img = document.getElementById(`img-${photo.id}`)
  const canvas = document.getElementById(`canvas-${photo.id}`)
  const parentWidth = canvas.parentElement.clientWidth
  const parentHeight = canvas.parentElement.clientHeight
  if (photo.blur_hash && photo.blur_hash.length >= 6) {
    const pixels = decode(photo.blur_hash, parentWidth, parentHeight);
    const ctx = canvas.getContext("2d");
    const imageData = ctx.createImageData(parentWidth, parentHeight);

    imageData.data.set(pixels);
    ctx.putImageData(imageData, 0, 0);
  }

  img.onload = () => {
    img.classList.remove('hidden')
    itemContainer.removeChild(canvas)
  }
  img.src = photo.url
}
