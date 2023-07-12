defmodule DemoWeb.SelectExampleLive do
  use DemoWeb, :live_view

  def mount(_params, _session, socket) do
    socket =
      socket
    |> assign(source: nil, target: nil, next: nil, show_target: false)
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <.simple_form
        for={%{}}
        as={:form_params}
        id="user-form"
        phx-change="change"
        phx-submit="submit"
      >
      <.input name="text" value={@source} />
      <.input name="source" value={@source} type="select" options={src_opts()} label="Source" prompt="Select One"/>
      <div :if={@show_target}>
        <.input name="target" value={@target} type="select" options={target_opts()} label="Target" prompt="Select Two"/>
      </div>
      <.input name="next" value={@next} type="select" options={src_opts()} label="Next" prompt="Select Three"/>

      <.button phx-disable-with="Saving...">Save</.button>
    </.simple_form>
    """
  end

    def handle_event("change", %{} = params, socket) do
      map =
        params
        |> Map.delete("_target")
        |> Map.new(fn {k,v} ->{String.to_atom(k), v} end)
        |> Map.merge(%{show_target: true})

      socket = assign(socket, map)
      {:noreply, socket}
    end

    def handle_event("submit", %{} = params, socket) do
      {:noreply, reset_assigns(socket)}
    end

    def reset_assigns(socket) do
      assign(socket, %{source: nil, target: nil, next: nil, show_target: false})
    end

    def src_opts() do
      [
        {1, 1},
        {2, 2},
        {3, 3},
      ]
    end

    def target_opts() do
      [
        {:a, :a},
        {:b, :b},
        {:c, :c},
      ]
    end
end
