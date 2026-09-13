defmodule Kpay.Operations.Transfer do


  use Ash.Resource.Change

  @impl true
  def change(changeset, _opts, _context) do

    Ash.Changeset.before_action(changeset, fn changeset ->
      from_id = Ash.Changeset.get_argument(changeset, :from_account_id)
      to_id = Ash.Changeset.get_argument(changeset, :to_account_id)
      amount = Ash.Changeset.get_argument(changeset, :amount)

      with {:ok, from_account} <- get_account(from_id),
           {:ok, to_account} <- get_account(to_id),
           {:ok, _} <- set_changeset(from_account, :debit, amount),
           {:ok, _} <- set_changeset(to_account, :credit, amount) do
            changeset
            |> Ash.Changeset.change_attribute(:amount, amount)
            |>Ash.Changeset.change_attribute(:status, :success)
            |> Ash.Changeset.change_attribute(:from_account_id, from_id)
            |> Ash.Changeset.change_attribute(:to_account_id, to_id)
      else

        {:error, error} -> normalize_error(changeset, error)
      end

    end)

  end

  defp set_changeset(account, type, amount) when is_atom(type) and is_integer(amount) do
    changeset = Ash.Changeset.for_update(account, type, [amount: amount])
    case Ash.update(changeset) do
      {:error, account_error} ->
       {:error, account_error}
      {:ok, account_updated} ->
        {:ok, account_updated}
    end
  end

  defp set_changeset(_account, _type, _Amount), do: {:error, :process_failed}

  defp get_account(account_id) do
    case Ash.get(Kpay.Account, account_id) do
      {:error, error} ->
        {:error, error}

      nil ->
        {:error, "this account does not exit in Kpay system"}

      {:ok, account} ->
        {:ok, account}
    end
  end

  defp normalize_error(changeset, message) when is_binary(message) do
    Ash.Changeset.add_error(changeset, Ash.Error.Changes.InvalidChanges.exception(message: message))
  end

  defp normalize_error(changeset, error), do: Ash.Changeset.add_error(changeset, error)
end
