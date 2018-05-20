context("parser tests")

util <- pds3_lexer_parser()
parser <- util$parser
lexer <- util$lexer

test_that("Simple Assignment", {
  string <- "TEST = 12312
  END"

  res <- parser$parse(string, lexer)
  expect_length(res, 1)
})

test_that("Simple Assignment 2", {
  string <- "TEST = 'string'
  TEST2 = 24
  END"

  res <- parser$parse(string, lexer)
  expect_length(res, 2)
})

test_that("Simple Assignment 2", {
  string <- "BEGIN_OBJECT = TEST
  END"

  res <- parser$parse(string, lexer)
  expect_length(res, 1)
})

test_that("Pointer Assignment", {
  string <- " ^HEADER = (\"MV10110413_6000000_001_RR.FIT\",1)
  END"

  res <- parser$parse(string, lexer)
  expect_length(res, 1)
})
