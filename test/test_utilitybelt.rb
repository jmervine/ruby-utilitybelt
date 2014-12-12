require 'minitest/autorun'
require 'tmpdir'
require 'fileutils'
require './utilitybelt'

class TestUtilityBelt < Minitest::Unit::TestCase
  def setup
    @paths = OpenStruct.new({
      :dir  => File.join(Dir.tmpdir(), "test_dir"),
      :file => File.join(Dir.tmpdir(), "test_file.txt"),
      :txt  => File.join(Dir.tmpdir(), "test_save.txt"),
      :bin  => File.join(Dir.tmpdir(), "test_save.bin"),
      :gpgt => File.join(Dir.tmpdir(), "gpg.txt"),
      :gpg  => File.join(Dir.tmpdir(), "gpg.gpg"),
      :gpgd => File.join(Dir.tmpdir(), "gpgout.txt"),
    })

    reset
  end

  def teardown
    reset
  end

  # cleanup helper
  def reset
    @paths.to_h.each_value do |path|
      FileUtils.rm_rf(path)  if File.exist?(path)
    end
  end

  def test_mkdir
    UtilityBelt.mkdir(@paths.dir)
    assert File.directory?(@paths.dir)
  end

  def test_touch
    refute File.exists?(@paths.file), "file shouldn't exist"
    UtilityBelt.touch(@paths.file)
    assert File.exists?(@paths.file), "file created"
    assert_equal sprintf("%o", File.stat(@paths.file).mode), "100644", "correct file mode"

    mtime = File.mtime(@paths.file)
    sleep 1
    UtilityBelt.touch(@paths.file)
    assert File.mtime(@paths.file) > mtime, "file mtime updated"
  end

  def test_save
    bin = [1,2].pack('c*')
    txt = "1, 2"

    refute File.exists?(@paths.txt), "txt shouldn't exists"
    refute File.exists?(@paths.bin), "bin shouldn't exists"

    UtilityBelt.save(@paths.txt, txt)
    assert File.exists?(@paths.txt), "txt shouldn't exists"
    assert_equal File.read(@paths.txt), txt, "txt should match"

    UtilityBelt.save(@paths.bin, bin, true)
    assert File.exists?(@paths.bin), "bin shouldn't exists"
    assert_equal File.read(@paths.bin), bin, "bin should match"
  end

  def test_exec
    r1 = UtilityBelt.exec("badcmd")
    assert r1.status > 0, "should fail"
    assert_equal "No such file or directory - badcmd",
      r1.stderr, "stdout shouldn't be empty"
    assert_equal "", r1.stdout, "stdout should be empty"

    r2 = UtilityBelt.exec("echo", "foobar")
    assert_equal r2.status, 0, "should pass"
    assert_equal "foobar\n", r2.stdout, "should have stdout"
    assert_equal "", r2.stderr, "shouldn't have stderr"

    r3 = UtilityBelt.exec("echo boobah")
    assert_equal 0, r3.status, "should pass"
    assert_equal "boobah\n", r3.stdout, "should have stdout"
    assert_equal "", r3.stderr, "shouldn't have stderr"
  end

  if ENV['GPG_ID']
    def test_gpg
      File.open(@paths.gpgt, 'w') { |f| f << "gpg.txt data" }

      res = UtilityBelt.encrypt!(@paths.gpgt, @paths.gpg, ENV['GPG_ID'])

      assert_equal @paths.gpg, res
      assert File.exist?(@paths.gpg)

      res = UtilityBelt.decrypt(@paths.gpg, ENV['GPG_ID'])
      assert_equal File.read(@paths.gpgt), res

      res = UtilityBelt.decrypt_to(@paths.gpg, @paths.gpgd, ENV['GPG_ID'])
      assert_equal @paths.gpgd, res
      assert_equal File.read(@paths.gpgt), File.read(@paths.gpgd)

    end
  else
    def test_gpg
      skip "excluding gpg tests, add: `GPG_ID=<your gpg id>` to enable"
    end
  end
end

