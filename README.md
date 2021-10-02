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

### [Chat](https://dawn-forest-7320.fly.dev/chat)

![Chat Example](https://raw.githubusercontent.com/braynm/phoenix-liveview-example-usage/master/chat.gif)

## Example Usage
  * Pagination (Infinite Scroll)
  * Chat
  * OTP Login (WIP)

## Live Demo (No pun intended)

I deployed the [demo](https://dawn-forest-7320.fly.dev/pagination) to [fly.io](https://fly.io/). The deployment process is surprisingly easy.

[Demo](https://dawn-forest-7320.fly.dev/pagination)

## Observer

## Resources

  * [Phoenix Framework](https://www.phoenixframework.org/)
  * [ElixirConf 2020 - Patrick Thompson - Liven up your LiveViews (even further) with AlpineJS](https://www.youtube.com/watch?v=Dv64_tGJhHo)
  * [Adding Tailwind CSS to Phoenix 1.4 and 1.5](https://pragmaticstudio.com/tutorials/adding-tailwind-css-to-phoenix)
  * [Communicating between LiveViews on the same page](https://thepugautomatic.com/2020/08/communicating-between-liveviews-on-the-same-page/)
  * [Building a Distributed Turn-Based Game System in Elixir](https://fly.io/blog/building-a-distributed-turn-based-game-system-in-elixir/)
  * [Deploying Elixir application in fly.io](https://fly.io/docs/getting-started/elixir/)
  * [Connecting Observer in Production](https://fly.io/blog/observing-elixir-in-production/)

## Credits
  * Happy\ Bunch\ -\ Astronaut.png image is from [blush.design](https://blush.design/) check it out! they have awesome illustrations!

## TODO
  * Upgrade to [Phoenix 1.6](https://www.phoenixframework.org/blog/phoenix-1.6-released)
