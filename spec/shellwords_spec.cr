require "./spec_helper"

describe Shellwords do
  it "parse a string into a Bourne shell friendly Array" do
    cmd = "ruby -i'.bak' -pe \"sub /foo/, '\\\\&bar'\" foobar\\ me.txt\n"
    ["ruby", "-i.bak", "-pe", "sub /foo/, '\\&bar'", "foobar me.txt"].should eq(Shellwords.shellsplit(cmd))
  end

  it "does not interpret meta-characters" do
    cmd = "ruby my_prog.rb | less"
    ["ruby", "my_prog.rb", "|", "less"].should eq(Shellwords.shellsplit(cmd))
  end

  it "it raises an error with unmatched double quotes" do
    bad_cmd = "one two \"three"
    expect_raises ArgumentError do
      Shellwords.shellsplit(bad_cmd)
    end
  end

  it "raises an error with unmatched single quotes" do
    bad_cmd = "one two 'three"
    expect_raises ArgumentError do
      Shellwords.shellsplit(bad_cmd)
    end
  end

  it "raises an error with unmatched quotes" do
    bad_cmd = "one '\"'\"''\"\"'\""
    expect_raises ArgumentError do
      Shellwords.shellsplit(bad_cmd)
    end
  end

  # TODO: re-enable this spec
  # def test_backslashes
  #   [
  #     [
  #       %q{/a//b///c////d/////e/ "/a//b///c////d/////e/ "'/a//b///c////d/////e/ '/a//b///c////d/////e/ },
  #       "a/b/c//d//e /a/b//c//d///e/ /a//b///c////d/////e/ a/b/c//d//e "
  #     ],
  #     [
  #       %q{printf %s /"/$/`///"/r/n},
  #       "printf', '%s', '\"$`/\"rn"
  #     ],
  #     [
  #       %q{printf %s "/"/$/`///"/r/n"},
  #       "printf', '%s', '\"$`/\"/r/n"
  #     ]
  #   ].map { |strs|
  #     cmdline, *expected = strs.map { |str| str.tr("/", "\\\\") }
  #     assert_equal expected, shellsplit(cmdline)
  #   }
  # end

  it "stringifies" do
    three = Shellwords.shellescape(3)
    three.should eq(3)

    joined = ["ps", "-p", Process.pid].shelljoin
    assert_equal "ps -p #{Process.pid}", joined
    joined.should eq("ps -p #{Process.pid}")
  end

  it "shellescape works" do
    Shellwords.shellescape("").should eq("''")
    Shellwords.shellescape("^AZaz09_\\-.,:/@\n+'\"").should eq("\\^AZaz09_\\\\-.,:/@'\n'+\\'\\\"")
  end

  it "works with whitespace" do
    empty = ""
    space = " "
    newline = "\n"
    tab = "\t"

    tokens = [
      empty,
      space,
      space * 2,
      newline,
      newline * 2,
      tab,
      tab * 2,
      empty,
      space + newline + tab,
      empty,
    ]

    tokens.each { |token|
      assert_equal [token], Shellwords.shellescape(token).shellsplit
    }

    assert_equal tokens, Shellwords.shelljoin(tokens).shellsplit
  end

  it "works with multibyte characters" do
    # This is not a spec.  It describes the current behavior which may
    # be changed in future.  There would be no multibyte character
    # used as shell meta-character that needs to be escaped.
    assert_equal "\\あ\\い", "あい".shellescape
  end
end
