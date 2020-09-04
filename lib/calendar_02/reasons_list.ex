defmodule Calendar02.ReasonsList do
  @moduledoc """
  The ReasonsList context.
  """

  import Ecto.Query, warn: false
  alias Calendar02.Repo

  alias Calendar02.ReasonsList.ReasonList

  @doc """
  Returns the list of reasons_list.

  ## Examples

      iex> list_reasons_list()
      [%ReasonList{}, ...]

  """
  def list_reasons_list do
    Repo.all(ReasonList)
  end

  @doc """
  Gets a single reason_list.

  Raises `Ecto.NoResultsError` if the Reason list does not exist.

  ## Examples

      iex> get_reason_list!(123)
      %ReasonList{}

      iex> get_reason_list!(456)
      ** (Ecto.NoResultsError)

  """
  def get_reason_list!(id), do: Repo.get!(ReasonList, id)

  @doc """
  Creates a reason_list.

  ## Examples

      iex> create_reason_list(%{field: value})
      {:ok, %ReasonList{}}

      iex> create_reason_list(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_reason_list(attrs \\ %{}) do
    %ReasonList{}
    |> ReasonList.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a reason_list.

  ## Examples

      iex> update_reason_list(reason_list, %{field: new_value})
      {:ok, %ReasonList{}}

      iex> update_reason_list(reason_list, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_reason_list(%ReasonList{} = reason_list, attrs) do
    reason_list
    |> ReasonList.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a reason_list.

  ## Examples

      iex> delete_reason_list(reason_list)
      {:ok, %ReasonList{}}

      iex> delete_reason_list(reason_list)
      {:error, %Ecto.Changeset{}}

  """
  def delete_reason_list(%ReasonList{} = reason_list) do
    Repo.delete(reason_list)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking reason_list changes.

  ## Examples

      iex> change_reason_list(reason_list)
      %Ecto.Changeset{data: %ReasonList{}}

  """
  def change_reason_list(%ReasonList{} = reason_list, attrs \\ %{}) do
    ReasonList.changeset(reason_list, attrs)
  end
end
