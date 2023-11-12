# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     InzynjerkaModel.Repo.insert!(%InzynjerkaModel.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias InzynjerkaModel.Chatbot.Questions

create_questions_for_one_answer = fn %{"questions" => questions, "answer" => answer} ->
  Enum.map(questions, fn question ->
    {:ok, new_question} = Questions.create_question(
      %{language: "Polish",
        content: question,
        answer: answer,
        is_displayed: true}
    ) end
  )
end

with {:ok, body} <- File.read("priv/repo/seed.json"), {:ok, json} <- Jason.decode(body) do
  Enum.map(json, create_questions_for_one_answer)
end
