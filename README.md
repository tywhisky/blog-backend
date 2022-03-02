# ElixirBlogBackend

ElixirBlogBackend is a very simple and clean-design blog system implemented with Elixir. It's one of my learning projects to explore awesome features with phoenix framework on web programming. 

This project only provides the APIs, and you are free to write your own admin or frontend, if you want to use the off-the-shelf admin system, you can visit: [BlogAdmin](https://github.com/tywhisky/blog-frontend).


# Development

I assume you have installed the PostgreSQL with user and password equals postgres.

### Setup

> git clone https://github.com/tywhisky/blog-backend.git
>
> cd blog-backend
>
> mix deps.get
>
> mix ecto.create
>
> mix ecto.migrate
>
> mix run priv/repo/seeds.exs

### Run

> mix phx.server

### APIs Docs

>http://localhost:4000/api/graphql
