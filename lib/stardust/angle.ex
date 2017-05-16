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
  @spec new(number) :: %Angle{}
  @spec new(binary) :: %Angle{}
  def new(angle) when is_number(angle) == true do
    Logger.info "Assuming angle in degrees"
    %Angle{angle: (angle |> deg_to_rad), format: :d}
  end

  @doc """
  Construc new angle from h:m:s format.

  ## Example
      iex> Stardust.Angle.from_hms("1:00:00") |> Stardust.Angle.to_deg() |> Float.round
      15.0
  """
  @spec from_hms(binary) :: %Angle{}
  def from_hms(angle) do
    [h, m, s] = angle
    |> String.split(":")
    |> Enum.map(&Float.parse/1)
    |> Enum.map(&(elem(&1, 0)))
    %Angle{angle: ((((360 * h / 24) * 3600.0 + m * 60 + s) / 3600) |> deg_to_rad), format: :hms}
  end

  @doc """
  Construct new angle from d:m:s format.

  ## Example
      iex> Stardust.Angle.from_dms("6:30:00") |> Stardust.Angle.to_deg() |> Float.round(2)
      6.5
  """
  @spec from_dms(binary) :: %Angle{}
  def from_dms(angle) do
    [h, m, s] = angle
    |> String.split(":")
    |> Enum.map(&Float.parse/1)
    |> Enum.map(&(elem(&1, 0)))
    %Angle{angle: (((h * 3600.0 + m * 60 + s) / 3600) |> deg_to_rad), format: :dms}
  end

  @doc """
  Angle addition.

  ## Example
      iex> Stardust.Angle.new(90) |> Stardust.Angle.add(Stardust.Angle.new(90))
      %Stardust.Angle{angle: 3.141592653589793, format: :d}
  """

  @spec add(%Angle{}, %Angle{}) :: %Angle{}
  def add(angle1, angle2) do
    %Angle{angle: angle1.angle + angle2.angle, format: angle1.format} 
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
  @spec deg_to_rad(number) :: float
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
  @spec rad_to_deg(number) :: float
  def rad_to_deg(angle), do: angle * 180.0 / :math.pi

  @doc """
  Returns angle as specified format.

  ## Examples
      iex> Stardust.Angle.new(90) |> Stardust.Angle.to("d")
      90.0
      iex> Stardust.Angle.new(90) |> Stardust.Angle.to("r")
      1.5707963267948966
  """
  @spec to(%Angle{}, binary) :: binary | float
  def to(angle, "d"), do: angle |> Angle.to_deg()
  def to(angle, "r"), do: angle |> Angle.to_rad()

  @doc """
  Returns as degrees.

  ## Example
      iex> Stardust.Angle.new(90) |> Stardust.Angle.to_deg()
      90.0
  """
  @spec to_deg(%Angle{}) :: float
  def to_deg(angle), do: (angle.angle |> rad_to_deg)

  @doc """
  Returns as radians.

  ## Example
      iex> Stardust.Angle.new(90) |> Stardust.Angle.to_rad()
      1.5707963267948966
  """
  @spec to_rad(%Angle{}) :: float
  def to_rad(angle), do: angle.angle
end
