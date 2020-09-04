defmodule Calendar02.Calendars do
  @moduledoc """
  The Calendars context.
  """

  import Ecto.Query, warn: false
  alias Calendar02.Repo

  alias Calendar02.Calendars.Reason
  alias Calendar02.ReasonsList.ReasonList

  @doc """
  Returns the list of reasons.

  ## Examples

      iex> list_reasons()
      [%Reason{}, ...]

  """
  #Calendar02.Calendars.list_reasons

  def list_reasons do
    # reasons = from r in Reason, select: struct(p, [:id, :reason]) #, join: l in ReasonList, on: r.reason == l.id
    # Repo.all(reasons)

    #Reason |> select([c], struct(c, [:name]),, struct(c, [:name]))

    Reason
    |> join(:left, [p], c in ReasonList, on: c.id == p.reason and c.active == true)
    |> select([p, c], {p, c})
    |> Repo.all()

    #reasons = from(r in Reason, select: struct({r}, [:id]))
    # Repo.all(reasons)
    #Reason |> select([c], %{id: c.id}) |> Repo.all()


    #Repo.all(Reason)
    # {reasons} =
    #   Reason
      #from p in Reason, select: {p}
    #|> join(:left, [p], c in ReasonList, on: c.id == p.reason and c.active == true)
    #|> select([p, c], {p, c})
    # |> select([r], {r})
    # |> Repo.all()
    # b = Repo.all(posts_with_comments)
    # c = Repo.all(Reason)
    # d = Repo.all(posts_with_comments)

    #IO.inspect reasons
    # IO.inspect " ------- B --------- "
    # IO.inspect b
    # IO.inspect " -------- C -------- "
    # IO.inspect c
    # IO.inspect " ------- D --------- "
    # IO.inspect [d]
  end

  @doc """
  Gets a single reason.

  Raises `Ecto.NoResultsError` if the Reason does not exist.

  ## Examples

      iex> get_reason!(123)
      %Reason{}

      iex> get_reason!(456)
      ** (Ecto.NoResultsError)

  """
  def get_reason!(id) do
    Reason
    |> join(:left, [p], c in ReasonList, on: c.id == p.reason and c.active == true)
    |> select([p, c], {p, c})
    |> where([p], p.id == ^id)
    |> Repo.one()
    #Repo.get(Reason, id)
  end

  @doc """
  Creates a reason.

  ## Examples

      iex> create_reason(%{field: value})
      {:ok, %Reason{}}

      iex> create_reason(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_reason(attrs \\ %{}) do
    %Reason{}
    |> Reason.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a reason.

  ## Examples

      iex> update_reason(reason, %{field: new_value})
      {:ok, %Reason{}}

      iex> update_reason(reason, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_reason(%Reason{} = reason, attrs) do
    reason
    |> Reason.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a reason.

  ## Examples

      iex> delete_reason(reason)
      {:ok, %Reason{}}

      iex> delete_reason(reason)
      {:error, %Ecto.Changeset{}}

  """
  def delete_reason(%Reason{} = reason) do
    Repo.delete(reason)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking reason changes.

  ## Examples

      iex> change_reason(reason)
      %Ecto.Changeset{data: %Reason{}}

  """
  def change_reason(%Reason{} = reason, attrs \\ %{}) do
    Reason.changeset(reason, attrs)
  end
end
