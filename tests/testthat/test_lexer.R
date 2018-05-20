context("lexer tests")

lexer <- pds3:::pds3_lexer_parser()$lexer

expect_lex_token <- function(string, value, type) {
  lexer$input(string)
  token <- lexer$token()
  eval(bquote(expect_s3_class(token, c("LexToken", "R6"))))
  eval(bquote(expect_equal(.(token$type), .(type))))
  eval(bquote(expect_equal(.(token$value), .(value))))
  expect_null(lexer$token())
}

test_that("Decimal Integers", {
  tests <- c("0", "123", "+440", "-150000")
  result <- c(0, 123, 440, -150000)

  mapply(expect_lex_token, tests, result, "DINT")
})

test_that("Based Integers", {
  tests <- c("2#1001011#", "8#113#", "10#75#", "16#4B#", "16#+4B#", "16#-4B#")
  result <- c(75, 75, 75, 75, 75, -75)

  mapply(expect_lex_token, tests, result, "BINT")
})

test_that("Real Numbers", {
  tests <- c(
    "0.0",
    "123.",
    "+1234.56",
    "-.9981",
    "-1.E-3",
    "31459e1"
  )
  results <- c(0, 123, 1234.56, -.9981, -0.001, 314590)

  mapply(expect_lex_token, tests, results, "REAL")
})

test_that("Dates", {
  tests <- c(
    "1990-07-04",
    "1990-158",
    "2001-001",
    "1990-07-04T12:00",
    "1990-158T15:24:12Z",
    "2001-001T01:10:39.457591+7")
  mapply(expect_lex_token, tests, tests, "DATE")
})

test_that("Times", {
  tests <- c(
    "12:00",
    "15:24:12Z",
    "01:10:39.4575+07"
  )
  mapply(expect_lex_token, tests, tests, "TIME")
})

test_that("Strings", {
  tests <- c(
    "\"String\"",
    "\"15:24:12Z\"",
    "\"234\""
  )
  results <- c(
    "String",
    "15:24:12Z",
    "234"
  )
  mapply(expect_lex_token, tests, results, "STRING")
})

test_that("Symbols", {
  tests <- c(
    "'String'",
    "'15:24:12Z'",
    "'234'"
  )
  results <- c(
    "String",
    "15:24:12Z",
    "234"
  )
  mapply(expect_lex_token, tests, results, "SYMBOL")
})

test_that("Identifiers", {
  tests <- c(
    "VOYAGER",
    "VOYAGER_2",
    "BLUE_FILTER",
    "USA_NASA_PDS_1_0007",
    "SHOT_1_RANGE_TO_SURFACE"
  )
  mapply(expect_lex_token, tests, tests, "IDENTIFIER")
})

test_that("Reserved Identifiers", {
  tests <- c(
    "END",
    "END_GROUP",
    "END_OBJECT",
    "BEGIN_OBJECT",
    "GROUP",
    "OBJECT")
  types <- c(
    "END",
    "END_GROUP",
    "END_OBJECT",
    "BEGIN_OBJECT",
    "BEGIN_GROUP",
    "BEGIN_OBJECT")
  mapply(expect_lex_token, tests, tests, types)
})
