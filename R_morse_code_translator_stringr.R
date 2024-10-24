library(stringr)  # For text manipulation

# Morse code mapping
morse_code <- c(
  A = ".-", B = "-...", C = "-.-.", D = "-..", E = ".", F = "..-.", G = "--.",
  H = "....", I = "..", J = ".---", K = "-.-", L = ".-..", M = "--",
  N = "-.", O = "---", P = ".--.", Q = "--.-", R = ".-.", S = "...", T = "-",
  U = "..-", V = "...-", W = ".--", X = "-..-", Y = "-.--", Z = "--..",
  "1" = ".----", "2" = "..---", "3" = "...--", "4" = "....-", "5" = ".....",
  "6" = "-....", "7" = "--...", "8" = "---..", "9" = "----.", "0" = "-----",
  SPACE = "/"
)

# Function to convert text to Morse code
text_to_morse <- function(text, key) {
  text <- toupper(text)  # Convert to uppercase to match Morse code mapping
  letters <- strsplit(text, "")[[1]]
  morse <- sapply(letters, function(ltr) {
    if (ltr == " ") return(key["SPACE"])
    return(key[ltr])
  })
  return(paste(morse, collapse = " "))
}

# Function to convert Morse code to text
morse_to_text <- function(morse_text, key) {
  morse_words <- strsplit(morse_text, " / ")[[1]]
  decoded_message <- sapply(morse_words, function(word) {
    letters <- strsplit(word, " ")[[1]]
    decoded <- sapply(letters, function(ltr) {
      letter <- names(key)[key == ltr]
      if (length(letter) == 0) letter <- "?"  # Handle unmatched morse codes
      return(letter)
    })
    return(paste(decoded, collapse = ""))
  })
  return(paste(decoded_message, collapse = " "))
}

# Function to detect if the input is Morse code
is_morse_code <- function(input) {
  return(all(strsplit(input, "")[[1]] %in% c(".", "-", " ", "/")))
}

# Main function to handle input and conversion
convert_input <- function(input_text, key) {
  if (is_morse_code(input_text)) {
    # If input is Morse code, convert to text
    decoded_text <- morse_to_text(input_text, key)
    cat("Decoded Text: ", decoded_text, "\n")
  } else {
    # If input is text, convert to Morse code
    morse_code_output <- text_to_morse(input_text, key)
    cat("Morse Code: ", morse_code_output, "\n")
  }
}

# Prompt user for input
cat("Enter text or Morse code: ")
input_text <- readline()

# Convert input based on its type
convert_input(input_text, morse_code)