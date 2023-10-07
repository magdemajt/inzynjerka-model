defmodule InzynjerkaModel.Chatbot.QuestionsTest do
  use InzynjerkaModel.DataCase

  alias InzynjerkaModel.Chatbot.Questions

  describe "questions" do
    alias InzynjerkaModel.Chatbot.Questions.Question

    import InzynjerkaModel.Chatbot.QuestionsFixtures

    @invalid_attrs %{language: nil, content: nil, answer: nil, is_displayed: nil}

    test "list_questions/0 returns all questions" do
      question = question_fixture()
      assert Questions.list_questions() == [question]
    end

    test "get_question!/1 returns the question with given id" do
      question = question_fixture()
      assert Questions.get_question!(question.id) == question
    end

    test "create_question/1 with valid data creates a question" do
      valid_attrs = %{language: "some language", content: "some content", answer: "some answer", is_displayed: true}

      assert {:ok, %Question{} = question} = Questions.create_question(valid_attrs)
      assert question.language == "some language"
      assert question.content == "some content"
      assert question.answer == "some answer"
      assert question.is_displayed == true
    end

    test "create_question/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Questions.create_question(@invalid_attrs)
    end

    test "update_question/2 with valid data updates the question" do
      question = question_fixture()
      update_attrs = %{language: "some updated language", content: "some updated content", answer: "some updated answer", is_displayed: false}

      assert {:ok, %Question{} = question} = Questions.update_question(question, update_attrs)
      assert question.language == "some updated language"
      assert question.content == "some updated content"
      assert question.answer == "some updated answer"
      assert question.is_displayed == false
    end

    test "update_question/2 with invalid data returns error changeset" do
      question = question_fixture()
      assert {:error, %Ecto.Changeset{}} = Questions.update_question(question, @invalid_attrs)
      assert question == Questions.get_question!(question.id)
    end

    test "delete_question/1 deletes the question" do
      question = question_fixture()
      assert {:ok, %Question{}} = Questions.delete_question(question)
      assert_raise Ecto.NoResultsError, fn -> Questions.get_question!(question.id) end
    end

    test "change_question/1 returns a question changeset" do
      question = question_fixture()
      assert %Ecto.Changeset{} = Questions.change_question(question)
    end
  end

  describe "question_asks" do
    alias InzynjerkaModel.Chatbot.Questions.QuestionAsk

    import InzynjerkaModel.Chatbot.QuestionsFixtures

    @invalid_attrs %{similarity: nil, response_delay: nil}

    test "list_question_asks/0 returns all question_asks" do
      question_ask = question_ask_fixture()
      assert Questions.list_question_asks() == [question_ask]
    end

    test "get_question_ask!/1 returns the question_ask with given id" do
      question_ask = question_ask_fixture()
      assert Questions.get_question_ask!(question_ask.id) == question_ask
    end

    test "create_question_ask/1 with valid data creates a question_ask" do
      valid_attrs = %{similarity: 42, response_delay: 120.5}

      assert {:ok, %QuestionAsk{} = question_ask} = Questions.create_question_ask(valid_attrs)
      assert question_ask.similarity == 42
      assert question_ask.response_delay == 120.5
    end

    test "create_question_ask/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Questions.create_question_ask(@invalid_attrs)
    end

    test "update_question_ask/2 with valid data updates the question_ask" do
      question_ask = question_ask_fixture()
      update_attrs = %{similarity: 43, response_delay: 456.7}

      assert {:ok, %QuestionAsk{} = question_ask} = Questions.update_question_ask(question_ask, update_attrs)
      assert question_ask.similarity == 43
      assert question_ask.response_delay == 456.7
    end

    test "update_question_ask/2 with invalid data returns error changeset" do
      question_ask = question_ask_fixture()
      assert {:error, %Ecto.Changeset{}} = Questions.update_question_ask(question_ask, @invalid_attrs)
      assert question_ask == Questions.get_question_ask!(question_ask.id)
    end

    test "delete_question_ask/1 deletes the question_ask" do
      question_ask = question_ask_fixture()
      assert {:ok, %QuestionAsk{}} = Questions.delete_question_ask(question_ask)
      assert_raise Ecto.NoResultsError, fn -> Questions.get_question_ask!(question_ask.id) end
    end

    test "change_question_ask/1 returns a question_ask changeset" do
      question_ask = question_ask_fixture()
      assert %Ecto.Changeset{} = Questions.change_question_ask(question_ask)
    end
  end
end
