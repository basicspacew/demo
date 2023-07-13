defmodule DemoWeb.SelectExampleLive do
  use DemoWeb, :live_view

  def mount(_params, _session, socket) do
    socket =
      socket
    |> assign(source: nil, target: nil, next: nil, show_target: false, form: to_form(changeset(), as: :form))
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <.simple_form
        for={@form}
        id="user-form"
        phx-change="change"
        phx-submit="submit"
      >
      <.input  field={@form[:source]} value={@source} />
      <.input  field={@form[:source]} value={@source} type="select" options={src_opts()} label="Source" prompt="Select One"/>
      <div :if={true}>
        <.input  field={@form[:target]} value={@target} type="select" options={target_opts()} label="Target" prompt="Select Two"/>
      </div>
      <.input  field={@form[:next]} value={@next} type="select" options={src_opts()} label="Next" prompt="Select Three"/>

      <.button type="submit" phx-disable-with="Saving...">Save</.button>
    </.simple_form>
    """
  end

    def handle_event("change", %{"form" => params}, socket) do
      map =
        params
        |> Map.delete("_target")
        |> Map.new(fn {k,v} ->{String.to_atom(k), v} end)
        |> Map.merge(%{show_target: true})

      socket = assign(socket, map)
      {:noreply, socket}
    end

    def handle_event("submit", %{"form" => params}, socket) do
      IO.inspect(params, label: "submitted_params")
      {:noreply, reset_assigns(socket)}
    end

    def changeset(params \\ %{}) do
      types = {%{}, %{source: :string, target: :string}}
      Ecto.Changeset.cast(types, params, [:source, :target])
      |> Ecto.Changeset.apply_changes()
    end

    def reset_assigns(socket) do
      assign(socket, %{source: nil, target: nil, next: nil, show_target: false, form: to_form(changeset(), as: :form) })
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
