class CalorieCounter
  @calories = []

  def initialize
    raw_data = File.readlines('./input.txt')
    @calories = clean(raw_data)
  end

  def write_rows
    @calories.each do |calorie|
      puts calorie.to_i
    end
  end

  def find_max_carried
    carried_calories = 0
    @max_calorie = 0

    @calories.each do |calorie|
      if calorie == 0
        @max_calorie = carried_calories if carried_calories > @max_calorie
        carried_calories = 0
      else
        carried_calories += calorie
      end
    end
    @max_calorie
  end

  def sum_of_top_3
    # put all sums in an array, sort by total and pick the top 3 then sum and return
    carried_calories = 0
    calorie_totals = []

    @calories.each do |calorie|
      if calorie == 0
        calorie_totals << carried_calories
        carried_calories = 0
      else
        carried_calories += calorie
      end
    end
    calorie_totals.sort.reverse.take(3).sum
  end

  private

  def clean(raw_data)
    clean_data = []
    raw_data.each do |row|
      clean_data << row.gsub(/\R+/, '').to_i
    end
    clean_data
  end
end