require_relative "./calculate_RPN"
require_relative "./transform_equasion"

def input
  puts "Input your equasion (end with \"=\")"
  get_string = gets.chomp
  analyze(get_string.chars)
end

def analyze(equasion)
  priorities = ['(', '+', '-', ')', '*', '/', '%', '^']
  @output = []
  @stack = []
  @buffer = ""
  @had_a_dot = false
  @last_character = ""
  for i in equasion
    if i != " "
      case
      when priorities.include?(@last_character) && i == '-'
        @buffer = "-"
        @last_character = i
      else
        result = check_character(i)
        @last_character = i
        # puts "Character: #{i}, Output buffer: #{@output}, Stack buffer #{@stack}, Character buffer: #{@buffer}"
        break if result == true
      end
    end
  end
  equasion = nil
  @buffer = nil
  @had_a_dot = nil
  pop_off_stack
  print "#{@output}\n"
  puts "Result: #{calculate(@output)}"
  @output = nil
end


input


# Algorytm

# Dla wszystkich symboli z wyrażenia ONP wykonuj:
    # jeśli i-ty symbol jest liczbą, to odłóż go na stos,
    # jeśli i-ty symbol jest operatorem to:
        # zdejmij ze stosu jeden element (ozn. a),
        # zdejmij ze stosu kolejny element (ozn. b),
        # odłóż na stos wartość b operator a.
    # jeśli i-ty symbol jest funkcją to:
        # zdejmij ze stosu oczekiwaną liczbę parametrów funkcji(ozn. a1...an)
        # odłóż na stos wynik funkcji dla parametrów a1...an
    # Zdejmij ze stosu wynik.
# 
# Przykład 1
# 
    # Wyrażenie w notacji infiksowej: 12+2×(3×4+10/5)
    # Wyrażenie ONP: 12 2 3 4 × 10 5 / + × +
    # Gdy wczytany element jest liczbą, to zapisuje się ją na stos. W przeciwnym wypadku należy wykonać działanie arytmetyczne na 2 ostatnich liczbach na stosie. Wartość wyrażenia znajduje się na stosie.
# 
# Krok 	Wejście 	Stos 	Operacja
# 1 	12 	12 	Odłóż na stos
# 2 	2 	12 2 	Odłóż na stos
# 3 	3 	12 2 3 	Odłóż na stos
# 4 	4 	12 2 3 4 	Odłóż na stos
# 5 	× 	12 2 12 	Zdejmij ze stosu dwa razy ( 3 i 4 ), następnie oblicz ( 3 × 4 = 12 ) a wynik odłóż na stos
# 6 	10 	12 2 12 10 	Odłóż na stos
# 7 	5 	12 2 12 10 5 	Odłóż na stos
# 8 	/ 	12 2 12 2 	Zdejmij ze stosu dwa razy ( 10 i 5 ), następnie oblicz ( 10 / 5 = 2 ) a wynik odłóż na stos
# 9 	+ 	12 2 14 	Zdejmij ze stosu dwa razy ( 12 i 2 ), następnie oblicz ( 12 + 2 = 14 ) a wynik odłóż na stos
# 10 	× 	12 28 	Zdejmij ze stosu dwa razy ( 14 i 2 ), następnie oblicz ( 2 × 14 = 28 ) a wynik odłóż na stos
# 11 	+ 	40 	Zdejmij ze stosu dwa razy ( 28 i 12 ), następnie oblicz ( 12 + 28 = 40 ) a wynik odłóż na stos
# 
    # Wartość wyrażenia (zdejmij ze stosu ostatni element): 40
