defmodule LibraryFees do
  def datetime_from_string(string) do
    # Извлекаем NaiveDateTime из ISO8601 строки
    {:ok, datetime} = NaiveDateTime.from_iso8601(string)
    datetime
  end

  def before_noon?(datetime) do
    # Сравниваем время с полуднем
    datetime.hour < 12
  end

  def return_date(checkout_datetime) do
    # Определяем количество дней (28 или 29) и прибавляем к дате
    days = if before_noon?(checkout_datetime), do: 28, else: 29
    checkout_datetime
    |> NaiveDateTime.to_date()
    |> Date.add(days)
  end

  def days_late(planned_return_date, actual_return_datetime) do
    # Считаем разницу в днях. Если вернули раньше — 0.
    actual_date = NaiveDateTime.to_date(actual_return_datetime)
    diff = Date.diff(actual_date, planned_return_date)
    
    if diff > 0, do: diff, else: 0
  end

  def monday?(datetime) do
    # Проверяем, является ли день недели понедельником (1)
    datetime
    |> NaiveDateTime.to_date()
    |> Date.day_of_week() == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    # Собираем всё вместе: парсим строки, считаем дни и применяем скидку
    checkout_dt = datetime_from_string(checkout)
    return_dt = datetime_from_string(return)
    
    planned_date = return_date(checkout_dt)
    days = days_late(planned_date, return_dt)
    
    total_fee = days * rate
    
    if monday?(return_dt) do
      div(total_fee, 2) # Скидка 50% с округлением вниз
    else
      total_fee
    end
  end
end