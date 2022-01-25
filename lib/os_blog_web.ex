defmodule OsBlogWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use OsBlogWeb, :controller
      use OsBlogWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: OsBlogWeb

      import Plug.Conn
      import OsBlogWeb.Gettext
      alias OsBlogWeb.Router.Helpers, as: Routes
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/os_blog_web/templates",
        namespace: OsBlogWeb

      # Import convenience functions from controllers
      import Phoenix.Controller,
        only: [get_flash: 1, get_flash: 2, view_module: 1, view_template: 1]

      # Include shared imports and aliases for views
      unquote(view_helpers())
    end
  end

  def router do
    quote do
      use Phoenix.Router

      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def resolver do
    quote do
      import OsBlogWeb.ResolverHelpers
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import OsBlogWeb.Gettext
    end
  end

  def schema do
    quote do
      use Absinthe.Schema.Notation
      import Absinthe.Resolution.Helpers, only: [dataloader: 1, dataloader: 2, dataloader: 3]
      import OsBlogWeb.SchemaHelpers
    end
  end

  defp view_helpers do
    quote do
      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML
      # Import basic rendering functionality (render, render_layout, etc)
      import Phoenix.View

      import OsBlogWeb.ErrorHelpers
      import OsBlogWeb.Gettext
      alias OsBlogWeb.Router.Helpers, as: Routes

      def render_page(page, item_mapper) do
        %{
          items: Enum.map(page.entries, item_mapper),
          page_info: page_info(page)
        }
      end

      defp page_info(%Scrivener.Page{} = page) do
        %{
          type: "page",
          current: page.page_number,
          page_size: page.page_size,
          total_pages: page.total_pages,
          total_count: page.total_entries
        }
      end
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
