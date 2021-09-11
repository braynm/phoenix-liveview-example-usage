# LiveViewExampleUsage

This is my attempt to learn `LiveView` by building a web app component.

## Quick Start
  * Elixir version `1.12.2`; OTP version 23.3.2
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server` or app inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Setup

### Requirements

  * Elixir 1.12.2
  * Phoenix 1.15.9
  * Nodejs 12.13.0

### [Pagination](https://dawn-forest-7320.fly.dev/pagination) (Infinite Scroll)

We used photos from Unsplash website via Unsplash API. We need to setup from [here](https://unsplash.com/developers).
1. Create Unsplash application in order to use [Unsplash API](https://unsplash.com/developers)
2. Add this to `config/dev.exs:`
```elixir
config :live_view_example_usage, :unsplash_credentials,
  client_id: <CLIENT_ID>,
  client_secret: <CLIENT_SECRET>
```
3. Run `iex- S mix phx.server`

![Pagination Example](https://raw.githubusercontent.com/braynm/phoenix-liveview-example-usage/master/pagination.gif)

## Example Usage
  * Pagination (Infinite Scroll)
  * Chat (WIP)
  * OTP Login (WIP)

## Live Demo (No pun intended)

[Demo](https://dawn-forest-7320.fly.dev/pagination)

## References

  * [Phoenix Framework](https://www.phoenixframework.org/)
  * [ElixirConf 2020 - Patrick Thompson - Liven up your LiveViews (even further) with AlpineJS](https://www.youtube.com/watch?v=Dv64_tGJhHo)
  * [Adding Tailwind CSS to Phoenix 1.4 and 1.5](https://pragmaticstudio.com/tutorials/adding-tailwind-css-to-phoenix)
  * [Communicating between LiveViews on the same page](https://thepugautomatic.com/2020/08/communicating-between-liveviews-on-the-same-page/)
