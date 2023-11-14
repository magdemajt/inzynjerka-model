defmodule InzynjerkaModel.Chatbot do
  alias Bumblebee.Shared
  alias InzynjerkaModel.Chatbot.Questions

  def get_questions(:only_content) do
    questions = Questions.list_questions()
    questions = if length(questions) == 0 do
    [
      "Badania lekarskie  na podstawie skierowania otrzymanego z Centrum Rekrutacji AGH można zrealizować nieodpłatnie jedynie w Małopolskim Ośrodku Medycyny Pracy – szczegóły na stronie www.bhp.agh.edu.pl/kandydaci. W pozostałych Poradniach Medycyny Pracy badania te mogą być wykonane, ale odpłatnie.Uzyskane od lekarza zaświadczenie o braku przeciwwskazań zdrowotnych do podjęcia studiów na wybranym kierunku należy dostarczyć do Dziekanatu Wydziału prowadzącego dany kierunek najpóźniej do dnia rozpoczęcia zajęć. Niedopełnienie tego obowiązku może skutkować skreśleniem z listy studentów.",
      "Wszystkie informacje dla kandydatów na studia I i II stopnia, którzy uzyskali wykształcenie za granicą znajdują się na stronie Zagraniczne Wykształcenie: https://rekrutacja.agh.edu.pl/zagraniczne-wyksztalcenie/",
      "W = M + 3 · G1 + G2gdzie:G1 – liczby punktów uzyskanych z przedmiotu głównego wymienionego w Uchwale 62/2022 Senatu AGH  – Tabela 1 w kolumnie G1 (w przypadku matematyki uwzględniany jest tylko wynik egzaminu na poziomie rozszerzonym),G2 – liczby punktów uzyskanych z przedmiotu głównego wymienionego w Uchwale 62/2022 Senatu AGH – Tabela 1 w kolumnie G2 (w przypadku matematyki uwzględniany jest tylko wynik egzaminu na poziomie rozszerzonym) lub kwalifikacji zawodowej wymienionej w Uchwale 62/2022 Senatu AGH – Tabela 3 lub 4.M – podwojona liczba punktów uzyskanych z matematyki na poziomie podstawowym.Sposób wyliczania wskaźnika rekrutacji zależy też od rodzaju posiadanego świadectwa dojrzałości/świadectwa maturalnego, kwalifikacji zawodowych, rodzaju matury (IB, EB), a także od skali ocen stosowanej przy egzaminach maturalnych.Szczegóły wyliczania wskaźnika rekrutacji W opisane są na stroniehttps://rekrutacja.agh.edu.pl/warunki-rekrutacji/",
      "W przypadku poprawy matury, w systemie rekrutacyjnym należy wprowadzić numer, oraz datę i miejsce wydania świadectwa dojrzałości otrzymanego w roku zdawania matury. Oceny należy wprowadzić na podstawie posiadanych dokumentów (w przypadku poprawy wyniku — oceny z aneksu).",
      "Przeliczenie wskaźnika rekrutacji nastąpi w momencie wprowadzenia ocen przez kandydata oraz opłacenia deklaracji w systemie e-Rekrutacja (W przypadku świadectw zagranicznych proces może ulec wydłużeniu).",
      "Osoby posiadające polskie obywatelstwo są przyjmowane tylko i wyłącznie na zasadach obowiązujących Polaków.",
      "Istnieje możliwość przystąpienia do rekrutacji w drugim cyklu rekrutacyjnym na ten sam kierunek co w pierwszym cyklu. W tym celu należy jeszcze raz złożyć i opłacić deklarację kierunku oraz przesłać wszystkie wymagane dokumenty."
    ] else
      questions |> Enum.map(fn question -> question.content end)
    end
    questions
  end

  def get_questions(:content_question_tuple) do
    questions = Questions.list_questions()
    questions = if length(questions) == 0 do
      [
        "Badania lekarskie  na podstawie skierowania otrzymanego z Centrum Rekrutacji AGH można zrealizować nieodpłatnie jedynie w Małopolskim Ośrodku Medycyny Pracy – szczegóły na stronie www.bhp.agh.edu.pl/kandydaci. W pozostałych Poradniach Medycyny Pracy badania te mogą być wykonane, ale odpłatnie.Uzyskane od lekarza zaświadczenie o braku przeciwwskazań zdrowotnych do podjęcia studiów na wybranym kierunku należy dostarczyć do Dziekanatu Wydziału prowadzącego dany kierunek najpóźniej do dnia rozpoczęcia zajęć. Niedopełnienie tego obowiązku może skutkować skreśleniem z listy studentów.",
        "Wszystkie informacje dla kandydatów na studia I i II stopnia, którzy uzyskali wykształcenie za granicą znajdują się na stronie Zagraniczne Wykształcenie: https://rekrutacja.agh.edu.pl/zagraniczne-wyksztalcenie/",
        "W = M + 3 · G1 + G2gdzie:G1 – liczby punktów uzyskanych z przedmiotu głównego wymienionego w Uchwale 62/2022 Senatu AGH  – Tabela 1 w kolumnie G1 (w przypadku matematyki uwzględniany jest tylko wynik egzaminu na poziomie rozszerzonym),G2 – liczby punktów uzyskanych z przedmiotu głównego wymienionego w Uchwale 62/2022 Senatu AGH – Tabela 1 w kolumnie G2 (w przypadku matematyki uwzględniany jest tylko wynik egzaminu na poziomie rozszerzonym) lub kwalifikacji zawodowej wymienionej w Uchwale 62/2022 Senatu AGH – Tabela 3 lub 4.M – podwojona liczba punktów uzyskanych z matematyki na poziomie podstawowym.Sposób wyliczania wskaźnika rekrutacji zależy też od rodzaju posiadanego świadectwa dojrzałości/świadectwa maturalnego, kwalifikacji zawodowych, rodzaju matury (IB, EB), a także od skali ocen stosowanej przy egzaminach maturalnych.Szczegóły wyliczania wskaźnika rekrutacji W opisane są na stroniehttps://rekrutacja.agh.edu.pl/warunki-rekrutacji/",
        "W przypadku poprawy matury, w systemie rekrutacyjnym należy wprowadzić numer, oraz datę i miejsce wydania świadectwa dojrzałości otrzymanego w roku zdawania matury. Oceny należy wprowadzić na podstawie posiadanych dokumentów (w przypadku poprawy wyniku — oceny z aneksu).",
        "Przeliczenie wskaźnika rekrutacji nastąpi w momencie wprowadzenia ocen przez kandydata oraz opłacenia deklaracji w systemie e-Rekrutacja (W przypadku świadectw zagranicznych proces może ulec wydłużeniu).",
        "Osoby posiadające polskie obywatelstwo są przyjmowane tylko i wyłącznie na zasadach obowiązujących Polaków.",
        "Istnieje możliwość przystąpienia do rekrutacji w drugim cyklu rekrutacyjnym na ten sam kierunek co w pierwszym cyklu. W tym celu należy jeszcze raz złożyć i opłacić deklarację kierunku oraz przesłać wszystkie wymagane dokumenty."
      ] else
      questions |> Enum.map(fn question -> {question.content, question} end)
    end
    questions
  end

  def get_answer_from_similarity(similarity, %{"low_threshold" => low, "high_threshold" => high}) do
    max_value = Nx.reduce_max(similarity) |> Nx.to_number() |> Kernel.*(100)
    max_index = Nx.argmax(similarity) |> Nx.to_number()
    max_question = get_questions(:content_question_tuple) |> Enum.at(max_index)
    {_, question} = max_question
    metadata = case question do
      nil -> %{question_id: nil, max_index: max_index, max_value: max_value}
      _ -> %{question_id: question.id, max_index: max_index, max_value: max_value}
    end
    IO.puts "sim: #{max_value}"
    cond do
      max_value < low -> {:confidence_too_low, "Niestety nie znam odpowiedzi", metadata}
      question.answer == nil -> {:no_answer, "Niestety nie znam odpowiedzi", metadata}
      max_value < high -> {:confidence_low, question.answer, metadata}
      true -> {:ok, question.answer, metadata}
    end
  end

  def cosine_similarity(a, b) do
    bT = Nx.transpose(b)
    Nx.divide(Nx.dot(a, bT), Nx.multiply(Nx.LinAlg.norm(a), Nx.LinAlg.norm(b, axes: [1])))
  end

  def qa_model(model_info, tokenizer) do
    %{model: model, params: params, spec: spec} = model_info

    #na razie wykonuje sie tylko raz, nie bierze pod uwage modyfikacji questions,
    #ale też nie ma co robić tego co zapytanie do czatu,
    #proponuję przenieść do osobnego modułu i na modyfikację repo Questions aktualizować tokenized
    raw_answers = get_questions(:only_content)
#    Add lazy loading, trzymać wektory w bazie danych, dla danego modelu
    tokenized = Bumblebee.apply_tokenizer(tokenizer, raw_answers)

    Nx.Serving.new(
      fn ->
        {_init_fun, predict_fun} = Axon.build(model)

        %{ pooled_state: answers } = predict_fun.(params, tokenized)

        fn inputs ->
          %{ pooled_state: outputs } = predict_fun.(params, inputs)
          similarity = cosine_similarity(outputs, answers)
          similarity
        end
      end,
      batch_size: 1
    )
    |> Nx.Serving.client_preprocessing(fn input ->
      {texts, multi?} = Shared.validate_serving_input!(input, &Shared.validate_string/1)
      inputs = Bumblebee.apply_tokenizer(tokenizer, texts, return_token_type_ids: false)

      {Nx.Batch.concatenate([inputs]), multi?}
    end)
  end
end
