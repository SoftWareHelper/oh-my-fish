function assert.error_message
  set -l number_of_arguments (count $argv)

  switch $argv[1]
    case !
      switch $number_of_arguments
        case 3
          set operator (assert.expand_operator $argv[2])
          set actual $argv[3]
          echo "Expected $actual to not be $operator"
        case 4
          set expected $argv[2]
          set operator "not" (assert.expand_operator $argv[3])
          set actual   $argv[4]
          echo "Expected $actual to $operator $expected"
        case \*
          return 1
        end
    case \-\*
      test $number_of_arguments != 2; and return 1
      set operator (assert.expand_operator $argv[1])
      set actual $argv[2]
      echo "Expected $actual to be $operator"
    case \*
      test $number_of_arguments != 3; and return 1
      set expected $argv[1]
      set operator (assert.expand_operator $argv[2])
      set actual   $argv[3]
      echo "Expected $actual to $operator $expected"
  end
end
