defmodule InzynjerkaModelWeb.QuestionLiveTest do
  use InzynjerkaModelWeb.ConnCase

  import Phoenix.LiveViewTest
  import InzynjerkaModel.Chatbot.QuestionsFixtures
  import InzynjerkaModelWeb.EnsureQueryParamAdmin
  import Mock

  @create_attrs %{language: "some language", content: "some content", answer: "some answer", is_displayed: true}
  @update_attrs %{language: "some updated language", content: "some updated content", answer: "some updated answer", is_displayed: false}
  @invalid_attrs %{language: nil, content: nil, answer: nil, is_displayed: false}

  defp create_question(_) do
    question = question_fixture()
    %{question: question}
  end

  describe "Index" do
    setup [:create_question]

    test "lists all questions", %{conn: conn, question: question} do
      with_mock InzynjerkaModelWeb.EnsureQueryParamAdmin, [call: fn(conn, _opts) -> conn end, init: fn(opts) -> opts end] do
        {:ok, _index_live, html} = live(conn, ~p"/questions")

        assert html =~ "Listing Questions"
        assert html =~ question.language
      end
    end

    test "saves new question", %{conn: conn} do
      with_mock InzynjerkaModelWeb.EnsureQueryParamAdmin, [call: fn(conn, _opts) -> conn end, init: fn(opts) -> opts end] do
        {:ok, index_live, _html} = live(conn, ~p"/questions")

        assert index_live |> element("a", "New Question") |> render_click() =~
                "New Question"

        assert_patch(index_live, ~p"/questions/new")

        assert index_live
              |> form("#question-form", question: @invalid_attrs)
              |> render_change() =~ "can&#39;t be blank"

        assert index_live
              |> form("#question-form", question: @create_attrs)
              |> render_submit()

        assert_patch(index_live, ~p"/questions")

        html = render(index_live)
        assert html =~ "Question created successfully"
        assert html =~ "some language"
      end
    end

    test "updates question in listing", %{conn: conn, question: question} do
      with_mock InzynjerkaModelWeb.EnsureQueryParamAdmin, [call: fn(conn, _opts) -> conn end, init: fn(opts) -> opts end] do
        {:ok, index_live, _html} = live(conn, ~p"/questions")

        assert index_live |> element("#questions-#{question.id} a", "Edit") |> render_click() =~
                "Edit Question"

        assert_patch(index_live, ~p"/questions/#{question}/edit")

        assert index_live
              |> form("#question-form", question: @invalid_attrs)
              |> render_change() =~ "can&#39;t be blank"

        assert index_live
              |> form("#question-form", question: @update_attrs)
              |> render_submit()

        assert_patch(index_live, ~p"/questions")

        html = render(index_live)
        assert html =~ "Question updated successfully"
        assert html =~ "some updated language"
      end
    end

    test "deletes question in listing", %{conn: conn, question: question} do
      with_mock InzynjerkaModelWeb.EnsureQueryParamAdmin, [call: fn(conn, _opts) -> conn end, init: fn(opts) -> opts end] do
        {:ok, index_live, _html} = live(conn, ~p"/questions")

        assert index_live |> element("#questions-#{question.id} a", "Delete") |> render_click()
        refute has_element?(index_live, "#questions-#{question.id}")
      end
    end
  end

  describe "Show" do
    setup [:create_question]

    test "displays question", %{conn: conn, question: question} do
      with_mock InzynjerkaModelWeb.EnsureQueryParamAdmin, [call: fn(conn, _opts) -> conn end, init: fn(opts) -> opts end] do
        {:ok, _show_live, html} = live(conn, ~p"/questions/#{question}")

        assert html =~ "Show Question"
        assert html =~ question.language
      end
    end

    test "updates question within modal", %{conn: conn, question: question} do
      with_mock InzynjerkaModelWeb.EnsureQueryParamAdmin, [call: fn(conn, _opts) -> conn end, init: fn(opts) -> opts end] do
        {:ok, show_live, _html} = live(conn, ~p"/questions/#{question}")

        assert show_live |> element("a", "Edit") |> render_click() =~
                "Edit Question"

        assert_patch(show_live, ~p"/questions/#{question}/show/edit")

        assert show_live
              |> form("#question-form", question: @invalid_attrs)
              |> render_change() =~ "can&#39;t be blank"

        assert show_live
              |> form("#question-form", question: @update_attrs)
              |> render_submit()

        assert_patch(show_live, ~p"/questions/#{question}")

        html = render(show_live)
        assert html =~ "Question updated successfully"
        assert html =~ "some updated language"
      end
    end
  end
end
