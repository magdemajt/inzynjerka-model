defmodule InzynjerkaModel.Chatbot.Embeddings do
  @moduledoc """
  The Chatbot.Embeddings context.
  """

  import Ecto.Query, warn: false
  alias InzynjerkaModel.Repo

  alias InzynjerkaModel.Chatbot.Embeddings.QuestionEmbedding
  alias InzynjerkaModel.Chatbot.Questions.Question

  @doc """
  Returns the list of question_embeddings.

  ## Examples

      iex> list_question_embeddings()
      [%QuestionEmbedding{}, ...]

  """
  def list_question_embeddings do
    Repo.all(QuestionEmbedding)
  end

  @doc """
  Gets a single question_embedding.

  Raises `Ecto.NoResultsError` if the Question embedding does not exist.

  ## Examples

      iex> get_question_embedding!(123)
      %QuestionEmbedding{}

      iex> get_question_embedding!(456)
      ** (Ecto.NoResultsError)

  """
  def get_question_embedding!(id), do: Repo.get!(QuestionEmbedding, id)

  @doc """
  Creates a question_embedding.

  ## Examples

      iex> create_question_embedding(%{field: value})
      {:ok, %QuestionEmbedding{}}

      iex> create_question_embedding(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_question_embedding(attrs \\ %{}) do
    %QuestionEmbedding{}
    |> QuestionEmbedding.changeset(attrs)
    |> Repo.insert()
  end

  def create_question_embeddings(attrs_list \\ []) do
    changesets = Enum.map(attrs_list, fn attrs -> QuestionEmbedding.create_with_default_dates(attrs) end)
    Repo.insert_all(QuestionEmbedding, changesets)
  end

  @doc """
  Updates a question_embedding.

  ## Examples

      iex> update_question_embedding(question_embedding, %{field: new_value})
      {:ok, %QuestionEmbedding{}}

      iex> update_question_embedding(question_embedding, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_question_embedding(%QuestionEmbedding{} = question_embedding, attrs) do
    question_embedding
    |> QuestionEmbedding.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a question_embedding.

  ## Examples

      iex> delete_question_embedding(question_embedding)
      {:ok, %QuestionEmbedding{}}

      iex> delete_question_embedding(question_embedding)
      {:error, %Ecto.Changeset{}}

  """
  def delete_question_embedding(%QuestionEmbedding{} = question_embedding) do
    Repo.delete(question_embedding)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking question_embedding changes.

  ## Examples

      iex> change_question_embedding(question_embedding)
      %Ecto.Changeset{data: %QuestionEmbedding{}}

  """
  def change_question_embedding(%QuestionEmbedding{} = question_embedding, attrs \\ %{}) do
    QuestionEmbedding.changeset(question_embedding, attrs)
  end

  def get_question_embedding_by_question_id(question_id) do
    Repo.one(from q in QuestionEmbedding, where: q.question_id == ^question_id)
  end

  def get_questions_without_embeddings_for_model(model) do
#   SELECT q.content, q.id  FROM questions q LEFT OUTER JOIN question_embeddings qe ON q.id = qe.question_id WHERE qe.model != model_id OR qe.model IS NULL;
    Repo.all(from q in Question,
             left_join: qe in QuestionEmbedding, on: q.id == qe.question_id,
             where: (qe.model != ^model) or (is_nil(qe.model)),
             select: [q.content, q.id])
  end

  def get_question_embeddings_for_model(model) do
    Repo.all(from qe in QuestionEmbedding,
             where: qe.model == ^model,
             order_by: [desc: qe.question_id],
             select: qe)
  end
end
