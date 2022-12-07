class RpsCounter
  @rounds = []

  def initialize
    raw_data = File.readlines('./input.txt')
    @rounds = clean(raw_data)
  end

  def write_rows
    @rounds.each do |round|
      hands = round.split(" ")
      puts "Elf: #{hands[0]} - Me: #{hands[1]} - #{hand_score(hands[1])} : #{win_score(hands[0], hands[1])}"
    end
  end

  def play
    total_score = 0
    @rounds.each do |round|
      hands = round.split(" ")
      # puts "Elf: #{hands[0]} - Me: #{hands[1]} - #{score_for_round(hands[0], hands[1])}"
      total_score += score_for_round(hands[0], hands[1])
    end
    total_score
  end

  def play_as_directed
    total_score = 0
    @rounds.each do |round|
      hands = round.split(" ")
      my_hand = select_hand(outcome(hands[1]), hands[0])
      # puts "Elf: #{hands[0]} outcome: #{outcome(hands[1])} my_hand: #{my_hand} for #{score_for_round(hands[0], my_hand)} points"
      total_score += score_for_round(hands[0], my_hand)
    end
    total_score
  end

  private

  def outcome(expectation)
    expectation == 'X' ? 'loose' : (expectation == 'Y' ? 'draw' : 'win')
  end

  def select_hand(outcome, elf_hand)
    return same_as_elf_hand(elf_hand) if outcome == 'draw'

    case elf_hand
    when 'A' # rock
      outcome == 'win' ? 'Y' : 'Z'
    when 'B' # paper
      outcome == 'win' ? 'Z' : 'X'
    else # 'C' scissors
      outcome == 'win' ? 'X' : 'Y'
    end
  end

  def same_as_elf_hand(elf_hand)
    elf_hand == 'A' ? 'X' : (elf_hand == 'B' ? 'Y' : 'Z')
  end

  def score_for_round(elf_hand, my_hand)
    hand_score(my_hand) + win_score(elf_hand, my_hand)
  end

  def hand_score(hand)
    hand == 'X' ? 1 : (hand == 'Y' ? 2 : 3)
  end

  def win_score(elf_hand, my_hand)
    # elf A = rock, B = paper, C = scissors
    # me X = rock, Y = paper, Z = scissors
    return 3 if equal_hands(elf_hand, my_hand)

    case my_hand
    when 'X' # rock
      elf_hand == 'B' ? 0 : 6
    when 'Y' # paper
      elf_hand == 'C' ? 0 : 6
    else # 'Z' scissors
      elf_hand == 'A' ? 0 : 6
    end
  end

  def equal_hands(elf_hand, my_hand)
    return true if (elf_hand == 'A' && my_hand == 'X') || 
                   (elf_hand == 'B' && my_hand == 'Y') || 
                   (elf_hand == 'C' && my_hand == 'Z')
  end

  def clean(raw_data)
    clean_data = []
    raw_data.each do |row|
      clean_data << row.gsub(/\R+/, '')
    end
    clean_data
  end
end