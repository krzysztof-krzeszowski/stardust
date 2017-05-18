defmodule Stardust.Angle do

  require Logger
  alias Stardust.Angle

  @moduledoc """
  Functions for angle parsing and calculations.
  """

  @doc """
  New angle from degrees

  ## Example
      iex> Stardust.Angle.from_degrees(90)
      1.5707963267948966
  """
  @spec from_degrees(number) :: float
  def from_degrees(angle), do: angle |> deg_to_rad

  @doc """
  New angle from radians. Written for consistency.

  ## Example
      iex> Stardust.Angle.from_radians(2.13)
      2.13
  """
  @spec from_radians(number) :: float
  def from_radians(angle), do: angle

  @doc """
  Construc new angle from h:m:s format.

  ## Example
      iex> Stardust.Angle.from_hms("1:00:00") |> Stardust.Angle.to_deg() |> Float.round
      15.0
  """
  @spec from_hms(binary) :: float
  def from_hms(angle) do
    [h, m, s] = angle
    |> String.split(":")
    |> Enum.map(&Float.parse/1)
    |> Enum.map(&(elem(&1, 0)))
    (((360 * h / 24) * 3600.0 + m * 60 + s) / 3600) |> deg_to_rad
  end

  @doc """
  Construct new angle from formats:
    12:00:00.0
    12d00m00.0s

  ## Example
      iex> Stardust.Angle.from_dms("6:30:00") |> Stardust.Angle.to_deg() |> Float.round(2)
      6.5
      iex> Stardust.Angle.from_dms("6d30m00s") |> Stardust.Angle.to_deg() |> Float.round(2)
      6.5
  """
  @spec from_dms(binary) :: float | :error
  def from_dms(angle) do
    [h, m, s] = angle
    |> String.split(:binary.compile_pattern([":", "d", "m"]))
    |> Enum.map(&Float.parse/1)
    |> Enum.map(&(elem(&1, 0)))
    ((h * 3600.0 + m * 60 + s) / 3600) |> deg_to_rad
  end

  @doc """
  Angle addition.

  ## Example
      iex> Stardust.Angle.from_degrees(90) |> Stardust.Angle.add(Stardust.Angle.from_degrees(90))
      3.141592653589793
  """

  @spec add(float, float) :: float
  def add(angle1, angle2) do
    angle1 + angle2
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
      iex> Stardust.Angle.from_degrees(90) |> Stardust.Angle.to("d")
      90.0
      iex> Stardust.Angle.from_degrees(90) |> Stardust.Angle.to("r")
      1.5707963267948966
  """
  @spec to(float, binary) :: binary | float
  def to(angle, "d"), do: angle |> Angle.to_deg()
  def to(angle, "r"), do: angle |> Angle.to_rad()

  @doc """
  Returns as degrees.

  ## Example
      iex> Stardust.Angle.from_degrees(90) |> Stardust.Angle.to_deg()
      90.0
  """
  @spec to_deg(float) :: float
  def to_deg(angle), do: angle |> rad_to_deg

  @doc """
  Returns as radians.

  ## Example
      iex> Stardust.Angle.from_degrees(90) |> Stardust.Angle.to_rad()
      1.5707963267948966
  """
  @spec to_rad(float) :: float
  def to_rad(angle), do: angle
end
