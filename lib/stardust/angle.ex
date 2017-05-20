defmodule Stardust.Angle do

  require Logger
  alias Stardust.Angle

  @moduledoc """
  Functions for angle parsing and calculations.
  """

  @doc """
  New angle from degrees

  ## Example
      iex> from_deg(90)
      1.5707963267948966
  """
  @spec from_deg(number) :: float
  def from_deg(angle), do: angle |> deg_to_rad

  @doc """
  New angle from radians. Written for consistency.

  ## Example
      iex> from_rad(2.13)
      2.13
  """
  @spec from_rad(number) :: float
  def from_rad(angle), do: angle

  @doc """
  Construc new angle from formats:
    12:00:00.0
    12h00m00.0s

  ## Example
      iex> from_hms("1:00:00.0") |> to_deg |> Float.round
      15.0
      iex> from_hms("1h00m00.0s") |> to_deg |> Float.round
      15.0
  """
  @spec from_hms(binary) :: float
  def from_hms(angle) do
    [h, m, s] = angle
    |> String.split(:binary.compile_pattern([":", "h", "m"]))
    |> Enum.map(&Float.parse/1)
    |> Enum.map(&(elem(&1, 0)))
    (((360 * h / 24) * 3600.0 + m * 60 + s) / 3600) |> deg_to_rad
  end

  @doc """
  Construct new angle from formats:
    12:00:00.0
    12d00m00.0s

  ## Example
      iex> from_dms("6:30:00.0") |> to_deg |> Float.round(2)
      6.5
      iex> from_dms("6d30m00.0s") |> to_deg |> Float.round(2)
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
      iex> from_deg(90) |> add(from_deg(90))
      3.141592653589793
  """

  @spec add(float, float) :: float
  def add(angle1, angle2) do
    angle1 + angle2
  end

  @doc """
  Converts degrees to radians.

  ## Examples
      iex> deg_to_rad(360)
      6.283185307179586
      iex> deg_to_rad(90.0)
      1.5707963267948966
      iex> deg_to_rad(35.23)
      0.6148794954776022
  """
  @spec deg_to_rad(number) :: float
  def deg_to_rad(angle), do: angle * :math.pi / 180.0

  @doc """
  Converts radians to degrees.

  ## Examples
      iex> rad_to_deg(6.283)
      359.9893826806963
      iex> rad_to_deg(1.57)
      89.95437383553926
      iex> rad_to_deg(1)
      57.29577951308232
  """
  @spec rad_to_deg(number) :: float
  def rad_to_deg(angle), do: angle * 180.0 / :math.pi

  @doc """
  Returns angle as specified format.

  ## Examples
      iex> from_deg(90) |> to("d")
      90.0
      iex> from_deg(90) |> to("r")
      1.5707963267948966
      iex> from_deg(90) |> to("h")
      6.0
      iex> from_dms("0d10m0.0s") |> to("m") |> Float.round
      10.0
      iex> from_dms("0d0m20.0s") |> to("s") |> Float.round
      20.0
  """
  @spec to(float, binary) :: binary | float
  def to(angle, "d"), do: angle |> Angle.to_deg()
  def to(angle, "r"), do: angle |> Angle.to_rad()
  def to(angle, "h"), do: angle * 12 / :math.pi
  def to(angle, "m"), do: 60.0 * (angle |> Angle.to_deg())
  def to(angle, "s"), do: 60.0 * (angle |> to("m"))

  @doc """
  Returns as degrees.

  ## Example
      iex> from_deg(90) |> to_deg
      90.0
  """
  @spec to_deg(float) :: float
  def to_deg(angle), do: angle |> rad_to_deg

  @doc """
  Returns as radians.

  ## Example
      iex> from_deg(90) |> to_rad
      1.5707963267948966
  """
  @spec to_rad(float) :: float
  def to_rad(angle), do: angle

  @doc """
  Output angle in dms format with provided separators and with desired precision.

  ## Example
      iex> from_deg(19.12) |> to_dms
      "19d7m12.0s"
      iex> from_deg(180) |> to_dms("dms", 3)
      "180d0m0.000s"
      iex> from_deg(45.5) |> to_dms(":")
      "45:30:0.0"
  """
  @spec to_dms(float, binary, float) :: binary
  def to_dms(angle, sep \\ "dms", prec \\ 1) do
    v = angle
    |> to_deg
    {d, rd} = {trunc(v), v - trunc(v)}
    {m, rm} = {trunc(rd * 60), (rd * 60) - trunc(rd * 60)}
    s = rm * 60 |> Float.round(prec) |> :erlang.float_to_binary([decimals: prec])
    case sep do
      ":" -> "#{d}:#{m}:" <> s
      "dms" -> "#{d}d#{m}m" <> s <> "s"
    end
  end
end
