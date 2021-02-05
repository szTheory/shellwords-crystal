require "./spec_helper"

describe Shellwords do
  describe ".shellsplit" do
    it "parse a string into a Bourne shell friendly Array" do
      cmd = "ruby -i'.bak' -pe \"sub /foo/, '\\\\&bar'\" foobar\\ me.txt\n"
      Shellwords.shellsplit(cmd).should eq(["ruby", "-i.bak", "-pe", "sub /foo/, '\\&bar'", "foobar me.txt"])
    end

    it "does not interpret meta-characters" do
      cmd = "crystal my_prog.cr | less"
      ["crystal", "my_prog.cr", "|", "less"].should eq(Shellwords.shellsplit(cmd))
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
      bad_cmd = "one '\"\"\""
      expect_raises ArgumentError do
        Shellwords.shellsplit(bad_cmd)
      end
    end

    it "handles backslashes" do
      [
        {
          %q{/a//b///c////d/////e/ "/a//b///c////d/////e/ "'/a//b///c////d/////e/ '/a//b///c////d/////e/ },
          ["a/b/c//d//e /a/b//c//d///e/ /a//b///c////d/////e/ a/b/c//d//e "],
        },
        {
          %q{printf %s /"/$/`///"/r/n},
          ["printf", "%s", "\"$`/\"rn"],
        },
        {
          %q{printf %s "/"/$/`///"/r/n"},
          ["printf", "%s", "\"$`/\"/r/n"],
        },
      ].map do |strs|
        cmdline, expected = strs
        cmdline = cmdline.tr("/", "\\\\")
        expected = expected.map { |str| str.tr("/", "\\\\") }

        Shellwords.shellsplit(cmdline).should eq(expected)
      end
    end
  end

  describe ".shellescape" do
    it "stringifies" do
      three = Shellwords.shellescape(3)
      three.should eq("3")

      joined = ["ps", "-p", Process.pid].shelljoin
      joined.should eq("ps -p #{Process.pid}")
    end

    it "shellescape works" do
      Shellwords.shellescape("").should eq("''")
      Shellwords.shellescape("^AZaz09_\\-.,:/@\n+'\"").should eq("\\^AZaz09_\\\\-.,:/@'\n'+\\'\\\"")
    end

    it "works with multibyte characters" do
      # This is not a spec. It describes the current behavior which may
      # be changed in the future. There would be no multibyte character
      # used as shell meta-character that needs to be escaped.
      "あい".shellescape.should eq("\\あ\\い")
    end
  end

  describe ".shellescape and .shelljoin" do
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

      tokens.each do |token|
        Shellwords.shellescape(token).shellsplit.should eq([token])
      end

      Shellwords.shelljoin(tokens).shellsplit.should eq(tokens)
    end
  end
end
