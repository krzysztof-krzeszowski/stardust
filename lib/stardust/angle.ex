defmodule Stardust.Angle do

  require Logger
  alias Stardust.Angle

  @moduledoc """
  Functions for angle parsing and calculations.
  """

  defstruct angle: nil, format: :d

  @doc """
  Construct new angle

  ## Examples
      iex> Stardust.Angle.new(90)
      %Stardust.Angle{angle: 1.5707963267948966, format: :d}
  """
  @spec new(integer) :: %Angle{}
  @spec new(float) :: %Angle{}
  @spec new(binary) :: %Angle{}
  def new(angle) when is_integer(angle) == true, do: new(1.0 * angle)
  def new(angle) when is_float(angle) do
    Logger.warn "Assuming angle in degrees"
    %Angle{angle: (angle |> deg_to_rad), format: :d}
  end

  @doc """
  Converts degrees to radians.

  ## Examples
      iex> Stardust.Angle.deg_to_rad(360)
      6.283185307179586
      iex> Stardust.Angle.deg_to_rad(90.0)
      1.5707963267948966
      iex> Stardust.Angle.deg_to_rad(35.23)
      0.6148794954776022
  """
  @spec deg_to_rad(integer) :: float
  @spec deg_to_rad(float) :: float
  def deg_to_rad(angle), do: angle * :math.pi / 180.0

  @doc """
  Converts radians to degrees.

  ## Examples
      iex> Stardust.Angle.rad_to_deg(6.283)
      359.9893826806963
      iex> Stardust.Angle.rad_to_deg(1.57)
      89.95437383553926
      iex> Stardust.Angle.rad_to_deg(1)
      57.29577951308232
  """
  @spec rad_to_deg(integer) :: float
  @spec rad_to_deg(float) :: float
  def rad_to_deg(angle), do: angle * 180.0 / :math.pi

  @doc """
  Returns as degrees.

  ## Example
      iex> Stardust.Angle.new(90) |> Stardust.Angle.to_deg()
      90.0
  """
  @spec to_deg(%Angle{}) :: float
  def to_deg(angle), do: (angle.angle |> rad_to_deg)

  @spec to_rad(%Angle{}) :: float
  def to_rad(angle), do: angle.angle
end
