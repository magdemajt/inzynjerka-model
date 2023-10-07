defmodule InzynjerkaModel.Chatbot.Questions do
  @moduledoc """
  The Chatbot.Questions context.
  """

  import Ecto.Query, warn: false
  alias InzynjerkaModel.Repo

  alias InzynjerkaModel.Chatbot.Questions.Question

  @doc """
  Returns the list of questions.

  ## Examples

      iex> list_questions()
      [%Question{}, ...]

  """
  def list_questions do
    Repo.all(Question)
  end

  @doc """
  Gets a single question.

  Raises `Ecto.NoResultsError` if the Question does not exist.

  ## Examples

      iex> get_question!(123)
      %Question{}

      iex> get_question!(456)
      ** (Ecto.NoResultsError)

  """
  def get_question!(id), do: Repo.get!(Question, id)

  @doc """
  Creates a question.

  ## Examples

      iex> create_question(%{field: value})
      {:ok, %Question{}}

      iex> create_question(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_question(attrs \\ %{}) do
    %Question{}
    |> Question.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a question.

  ## Examples

      iex> update_question(question, %{field: new_value})
      {:ok, %Question{}}

      iex> update_question(question, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_question(%Question{} = question, attrs) do
    question
    |> Question.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a question.

  ## Examples

      iex> delete_question(question)
      {:ok, %Question{}}

      iex> delete_question(question)
      {:error, %Ecto.Changeset{}}

  """
  def delete_question(%Question{} = question) do
    Repo.delete(question)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking question changes.

  ## Examples

      iex> change_question(question)
      %Ecto.Changeset{data: %Question{}}

  """
  def change_question(%Question{} = question, attrs \\ %{}) do
    Question.changeset(question, attrs)
  end

  alias InzynjerkaModel.Chatbot.Questions.QuestionAsk

  @doc """
  Returns the list of question_asks.

  ## Examples

      iex> list_question_asks()
      [%QuestionAsk{}, ...]

  """
  def list_question_asks do
    Repo.all(QuestionAsk)
  end

  @doc """
  Gets a single question_ask.

  Raises `Ecto.NoResultsError` if the Question ask does not exist.

  ## Examples

      iex> get_question_ask!(123)
      %QuestionAsk{}

      iex> get_question_ask!(456)
      ** (Ecto.NoResultsError)

  """
  def get_question_ask!(id), do: Repo.get!(QuestionAsk, id)

  @doc """
  Creates a question_ask.

  ## Examples

      iex> create_question_ask(%{field: value})
      {:ok, %QuestionAsk{}}

      iex> create_question_ask(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_question_ask(attrs \\ %{}) do
    %QuestionAsk{}
    |> QuestionAsk.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a question_ask.

  ## Examples

      iex> update_question_ask(question_ask, %{field: new_value})
      {:ok, %QuestionAsk{}}

      iex> update_question_ask(question_ask, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_question_ask(%QuestionAsk{} = question_ask, attrs) do
    question_ask
    |> QuestionAsk.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a question_ask.

  ## Examples

      iex> delete_question_ask(question_ask)
      {:ok, %QuestionAsk{}}

      iex> delete_question_ask(question_ask)
      {:error, %Ecto.Changeset{}}

  """
  def delete_question_ask(%QuestionAsk{} = question_ask) do
    Repo.delete(question_ask)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking question_ask changes.

  ## Examples

      iex> change_question_ask(question_ask)
      %Ecto.Changeset{data: %QuestionAsk{}}

  """
  def change_question_ask(%QuestionAsk{} = question_ask, attrs \\ %{}) do
    QuestionAsk.changeset(question_ask, attrs)
  end

  def get_questions_with_answers do
    Repo.all(from q in Question, where: not is_nil(q.answer))
  end

  def get_question_by_question(content) do
    Repo.one(from q in Question, where: q.content == ^content)
  end

  def list_questions_without_answers do
    Repo.all(from q in Question, where: is_nil(q.answer))
  end
end
