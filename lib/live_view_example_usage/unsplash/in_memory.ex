defmodule LiveViewExampleUsage.Unsplash.InMemory do
  @behaviour LiveViewExampleUsage.UnsplashBehaviour
  defmodule LiveViewExampleUsage.Unsplash.SearchPhoto do
    defstruct query: "", page: 1, per_page: 25
  end

  def search_photo(%{page: 3}) do
    metadata = %{total_pages: 2}
    {:ok, {[], metadata}}
  end

  def search_photo(_) do
    %{"results" => photos} = photos()

    metadata = %{total_pages: 2}

    duplicated_items_with_randomize_id =
      photos
      |> extract_attribute
      |> duplicate_collection(3)

    {:ok, {duplicated_items_with_randomize_id, metadata}}
  end

  defp extract_attribute(photo_items) do
    Enum.map(photo_items, &extract_item/1)
  end

  defp duplicate_collection(photos, count) do
    photos
    |> List.duplicate(count)
    |> List.flatten()
    |> Enum.map(&update_random_id/1)
  end

  defp extract_item(item) do
    %{
      id: random_id(),
      url: item["urls"]["small"],
      description: item["description"],
      blur_hash: item["blur_hash"],
      width: item["width"],
      height: item["height"]
    }
  end

  defp update_random_id(item) do
    %{item | id: random_id()}
  end

  defp random_id, do: _s = for(_ <- 1..10, into: "", do: <<Enum.random('0123456789abcdef')>>)

  # NOTE: this should only be used in dev environment
  def photos do
    :live_view_example_usage
    |> Application.app_dir("priv/data/unsplash.mock.json")
    |> File.read!()
    |> Jason.decode!()
  end
end
