defmodule Stardust.Observatories do
  @moduledoc """
    List of observatories.

    Example entry:

    `
    :skinakas => %{
      desc: "Skinakas Observatory, Crete, Greece",
      lat: ~S(E24°53'57"),
      lon: ~S(N35°12'43"),
      alt: 1750
    },
    `
  """

  @list %{
    :skinakas => %{
      desc: "Skinakas Observatory, Crete, Greece",
      lat: ~S(E24°53'57"),
      lon: ~S(N35°12'43"),
      alt: 1750
    },
    :suhora => %{
      desc: "Mt. Suhora Observatory, Poland",
      lat: ~S(E20°04'03"),
      lon: ~S(N49°34'09"),
      alt: 1009
    },
  }

  @doc """
  Get information on observatory

  ## Example:
      iex> :skinakas |> get |> (Map.get :alt)
      1750
  """

  @spec get(:atom) :: :map
  def get obs do
    @list[obs]
  end

  @doc """
  List all defined observatories
  
  ## Example:
      iex> is_list(list())
      true
  """
  def list do
    @list
    |> Map.keys
  end
end
