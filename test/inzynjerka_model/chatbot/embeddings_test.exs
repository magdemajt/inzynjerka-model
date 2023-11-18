defmodule InzynjerkaModel.Chatbot.EmbeddingsTest do
  use InzynjerkaModel.DataCase

  alias InzynjerkaModel.Chatbot.Embeddings

  describe "question_embeddings" do
    alias InzynjerkaModel.Chatbot.Embeddings.QuestionEmbedding

    import InzynjerkaModel.Chatbot.EmbeddingsFixtures

    @invalid_attrs %{model: nil, embeddings: nil}

    test "list_question_embeddings/0 returns all question_embeddings" do
      question_embedding = question_embedding_fixture()
      assert Embeddings.list_question_embeddings() == [question_embedding]
    end

    test "get_question_embedding!/1 returns the question_embedding with given id" do
      question_embedding = question_embedding_fixture()
      assert Embeddings.get_question_embedding!(question_embedding.id) == question_embedding
    end

    test "create_question_embedding/1 with valid data creates a question_embedding" do
      valid_attrs = %{model: "some model", embeddings: "some embeddings"}

      assert {:ok, %QuestionEmbedding{} = question_embedding} = Embeddings.create_question_embedding(valid_attrs)
      assert question_embedding.model == "some model"
      assert question_embedding.embeddings == "some embeddings"
    end

    test "create_question_embedding/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Embeddings.create_question_embedding(@invalid_attrs)
    end

    test "update_question_embedding/2 with valid data updates the question_embedding" do
      question_embedding = question_embedding_fixture()
      update_attrs = %{model: "some updated model", embeddings: "some updated embeddings"}

      assert {:ok, %QuestionEmbedding{} = question_embedding} = Embeddings.update_question_embedding(question_embedding, update_attrs)
      assert question_embedding.model == "some updated model"
      assert question_embedding.embeddings == "some updated embeddings"
    end

    test "update_question_embedding/2 with invalid data returns error changeset" do
      question_embedding = question_embedding_fixture()
      assert {:error, %Ecto.Changeset{}} = Embeddings.update_question_embedding(question_embedding, @invalid_attrs)
      assert question_embedding == Embeddings.get_question_embedding!(question_embedding.id)
    end

    test "delete_question_embedding/1 deletes the question_embedding" do
      question_embedding = question_embedding_fixture()
      assert {:ok, %QuestionEmbedding{}} = Embeddings.delete_question_embedding(question_embedding)
      assert_raise Ecto.NoResultsError, fn -> Embeddings.get_question_embedding!(question_embedding.id) end
    end

    test "change_question_embedding/1 returns a question_embedding changeset" do
      question_embedding = question_embedding_fixture()
      assert %Ecto.Changeset{} = Embeddings.change_question_embedding(question_embedding)
    end
  end
end
